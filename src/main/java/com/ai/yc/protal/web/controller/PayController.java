package com.ai.yc.protal.web.controller;

import com.ai.opt.sdk.components.sequence.util.SeqUtil;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.DateUtil;
import com.ai.slp.balance.api.deposit.interfaces.IDepositSV;
import com.ai.slp.balance.api.deposit.param.DepositParam;
import com.ai.slp.balance.api.deposit.param.TransSummary;
import com.ai.yc.order.api.orderpay.interfaces.IOrderPayProcessedResultSV;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultBaseInfo;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultFeeInfo;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultProdInfo;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultRequest;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.OrderConstants;
import com.ai.yc.protal.web.model.pay.PayNotify;
import com.ai.yc.protal.web.service.OrderService;
import com.ai.yc.protal.web.utils.*;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import com.alibaba.fastjson.JSON;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by liutong on 16/11/10.
 */
@Controller
@RequestMapping("/pay")
public class PayController {
    private static final Logger LOG = LoggerFactory.getLogger(PayController.class);
    @Autowired
    OrderService orderService;

    /**
     * 订单支付结果
     * @return
     */
    @RequestMapping("/payResultView")
    public String orderPayResultView(PayNotify payNotify, Model uiModel){
        //订单号
        uiModel.addAttribute("orderId",payNotify.getOrderId());
        //若哈希验证不通过,则表示支付结果有问题
        if (!verifyData(payNotify)){
            payNotify.setPayStates(PayNotify.PAY_STATES_FAIL);
        }
        //支付结果
        uiModel.addAttribute("payResult",PayNotify.PAY_STATES_SUCCESS.equals(payNotify.getPayStates()));
        return "order/orderPayResult";
    }
    /**
     * 订单支付结果
     * @return
     */
    @RequestMapping("/payResult/{orderType}/{userId}")
    @ResponseBody
    public String orderPayResult(
            @PathVariable("orderType")String orderType, @PathVariable("userId")String userId,
            PayNotify payNotify){
        LOG.info("The pay result.orderType:{},\r\n{}", orderType,JSON.toJSONString(payNotify));
        //若哈希验证不通过或支付失败,则表示支付结果有问题
        if (!verifyData(payNotify)
                || !PayNotify.PAY_STATES_SUCCESS.equals(payNotify.getPayStates())){
            LOG.error("The pay is fail.");
            return "The pay verify fail";
        }
        //获取交易时间 20161111181026
        Timestamp notifyTime = DateUtil.getTimestamp(payNotify.getNotifyTime(),"yyyyMMddHHmmss");
        //支付费用
        Double totalFee = Double.valueOf(payNotify.getOrderAmount())*1000;
        orderService.orderPayProcessResult(userId,null,Long.parseLong(payNotify.getOrderId()),orderType,
                totalFee.longValue(),payNotify.getPayOrgCode(),payNotify.getOutOrderId(),notifyTime);
        return "OK";
    }
    /**
     * 帐户充值结果 后台
     * @return
     */
    @RequestMapping("/depositFundResult/{userId}/{currencyUnit}")
    @ResponseBody
    public String accountDepositResult(@PathVariable("userId")String userId,@PathVariable("currencyUnit")String currencyUnit,
            PayNotify payNotify){
        LOG.info("The pay result.:{},\r\n{}",JSON.toJSONString(payNotify));
        //若哈希验证不通过或支付失败,则表示支付结果有问题
        if (!verifyData(payNotify)
                || !PayNotify.PAY_STATES_SUCCESS.equals(payNotify.getPayStates())){
            LOG.error("The pay is fail.");
            return "fail";
        }
        //支付费用
        Double totalFee = Double.valueOf(payNotify.getOrderAmount())*1000;
       //后场充值
        //
        IDepositSV iDepositSV = DubboConsumerFactory.getService(IDepositSV.class);
        DepositParam depositParam = new DepositParam();
        TransSummary summary = new TransSummary();
        summary.setAmount(new Double(totalFee).longValue());
        //资金科目ID,从公共域查,该充值模块为预存款,科目编码100000
        summary.setSubjectId(Long.parseLong(Constants.FUNDSUBJECT_ID));
        List<TransSummary> transSummaryList = new ArrayList<TransSummary>();
        transSummaryList.add(summary);
        depositParam.setTransSummary(transSummaryList);
        IYCUserServiceSV userServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
        SearchYCUserRequest searchYCUserReq = new SearchYCUserRequest();
        searchYCUserReq.setTenantId(Constants.DEFAULT_TENANT_ID);
//        String userId = UserUtil.getUserId();
        searchYCUserReq.setUserId(userId);
        YCUserInfoResponse userInfoResponse = userServiceSV.searchYCUserInfo(searchYCUserReq);
        //若没有账户信息,直接返回null
        if (userInfoResponse==null||userInfoResponse.getAccountId()==null){
            LOG.error("没有该帐户信息.请创建帐户");
            return "FAIL123";
        }
        //用户账户
        long accountId = userInfoResponse.getAccountId();
        depositParam.setAccountId(accountId);
        //业务描述
        depositParam.setBusiDesc("充值");
        depositParam.setBusiSerialNo(payNotify.getOrderId());
        depositParam.setSystemId(Constants.SYSTEM_ID);
        depositParam.setTenantId(Constants.DEFAULT_TENANT_ID);
        depositParam.setCurrencyUnit(currencyUnit);
        /*支付方式
        ZFB: 	支付宝
        YL: 	   银联
        WEIXIN: 微信
        XY ：兴业
                */
        if (payNotify.getPayOrgCode()!=null){
            if (payNotify.getPayOrgCode().equals("ZFB")){
                depositParam.setPayStyle("支付宝");
            }else if (payNotify.getPayOrgCode().equals("YL")){
                depositParam.setPayStyle("银联");
            }else if (payNotify.getPayOrgCode().equals("XY")){
                depositParam.setPayStyle("兴业");
            }
        }
        //内部系统充值
        depositParam.setBusiOperCode("300000");
        try {
            String result = iDepositSV.depositFund(depositParam);

        }catch (Exception e){
            LOG.error("The deposit is fail.accountID="+accountId);
            return "FAIL456";
        }
       /* if (result==null){
            LOG.error("The deposit is fail.");
            return "faile1";
        }else {
            LOG.debug("The deposit is success.");
        }*/
        return "OK";
    }
    /**
     * 帐户充值结果
     * @return
     */
    @RequestMapping("/depositFundResultView")
    public String accountDepositResultView(PayNotify payNotify, Model uiModel){
        //订单号
        uiModel.addAttribute("orderId",payNotify.getOrderId());
        //若哈希验证不通过,则表示支付结果有问题
        if (!verifyData(payNotify)){
            payNotify.setPayStates(PayNotify.PAY_STATES_FAIL);
        }
        //支付结果
        //如果成功,跳转到支付成功页面
        if (PayNotify.PAY_STATES_SUCCESS.equals(payNotify.getPayStates())){
            return "balance/depositResultSuccess";
        }
        else
            return "balance/depositResultFailed";
    }
    /**
     * 验证签名是否正常
     * @param payNotify
     * @return
     */
    private boolean verifyData(PayNotify payNotify){
        String infoStr = payNotify.getOutOrderId()+ VerifyUtil.SEPARATOR
                + payNotify.getOrderId() + VerifyUtil.SEPARATOR
                + payNotify.getOrderAmount() + VerifyUtil.SEPARATOR
                + payNotify.getPayStates()+ VerifyUtil.SEPARATOR
                + payNotify.getTenantId();
        String infoMd5 = VerifyUtil.encodeParam(infoStr, ConfigUtil.getProperty("REQUEST_KEY"));
        return payNotify.getInfoMd5().equals(infoMd5);
    }
}
