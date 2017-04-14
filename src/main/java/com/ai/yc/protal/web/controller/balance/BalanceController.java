package com.ai.yc.protal.web.controller.balance;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.base.vo.BaseListResponse;
import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.BeanUtils;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.util.DateUtil;
import com.ai.opt.sdk.util.UUIDUtil;
import com.ai.opt.sdk.web.model.ResponseData;

import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.slp.balance.api.accountquery.interfaces.IAccountQuerySV;
import com.ai.slp.balance.api.accountquery.param.AccountInfoVo;
import com.ai.slp.balance.api.fundquery.interfaces.IFundQuerySV;
import com.ai.slp.balance.api.fundquery.param.AccountIdParam;
import com.ai.slp.balance.api.fundquery.param.FundInfo;
import com.ai.slp.balance.api.incomeoutquery.interfaces.IncomeOutQuerySV;
import com.ai.slp.balance.api.incomeoutquery.param.FundBookQueryResponse;
import com.ai.slp.balance.api.incomeoutquery.param.IncomeDetail;
import com.ai.slp.balance.api.incomeoutquery.param.IncomeQueryRequest;

import com.ai.slp.balance.api.sendcoupon.interfaces.ISendCouponSV;
import com.ai.slp.balance.api.sendcoupon.param.DeductionCouponRequest;
import com.ai.slp.balance.api.sendcoupon.param.DeductionCouponResponse;
import com.ai.slp.balance.api.sendcoupon.param.FreezeCouponRequest;
import com.ai.slp.balance.api.sendcoupon.param.FunDiscountCouponResponse;
import com.ai.yc.protal.web.constants.BalanceConstants;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.model.pay.AccountBalanceInfo;
import com.ai.yc.protal.web.model.sso.GeneralSSOClientUser;
import com.ai.yc.protal.web.service.BalanceService;

import com.ai.yc.protal.web.utils.*;
import org.apache.commons.lang3.StringUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 我的帐户
 * Created by lixiaokui on 16/11/14.
 */
@Controller
@RequestMapping("/p/balance")
public class BalanceController {
    private static final Logger LOGGER = LoggerFactory.getLogger(BalanceController.class);
    @Autowired
    BalanceService balanceService;
    @Autowired
    ResWebBundle rb;

    /**
     * 显示我的帐户页面
     * @return
     */
    @RequestMapping("/account")
    public String toMyAccount(Model uiModel){
        //帐户余额
        AccountBalanceInfo balanceInfo =  balanceService.queryOfUser(UserUtil.getUserId());
        uiModel.addAttribute("currencyUnit",balanceInfo.getCurrencyUnit());
        uiModel.addAttribute("balance",String.valueOf(AmountUtil.changeLiToYuan(balanceInfo.getBalance())));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date beginDate = new Date();
        beginDate.setMonth(beginDate.getMonth()-1);
        String date1 = formatter.format(beginDate);
        Date endDate = new Date();
        endDate.setMonth(endDate.getMonth());
        String date2 = formatter.format(endDate);

        uiModel.addAttribute("beginTime",date1);
        uiModel.addAttribute("endTime",date2);
        return "balance/account";
    }

    @RequestMapping("/accountList")
    @ResponseBody
    public ResponseData<PageInfo<IncomeDetail>> accountList(IncomeQueryRequest incomeQueryRequest,
                                                            @RequestParam(value = "pageNo")int pageNO,
                                                            @RequestParam(value = "pageSize")int pageSize){
        ResponseData<PageInfo<IncomeDetail>> resData =
                new ResponseData<PageInfo<IncomeDetail>>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        AccountBalanceInfo balanceInfo =  balanceService.queryOfUser(UserUtil.getUserId());
        IncomeOutQuerySV incomeOutQuerySV =  DubboConsumerFactory.getService(IncomeOutQuerySV.class);
        incomeQueryRequest.setAccountId(balanceInfo.getAccountId());
        incomeQueryRequest.setTenantId(Constants.DEFAULT_TENANT_ID);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try
        {
            if(StringUtils.isBlank(incomeQueryRequest.getBeginDate())){
                Date beginDate = new Date();
                beginDate.setMonth(beginDate.getMonth()-1);
                String date1 = formatter.format(beginDate);
                incomeQueryRequest.setBeginDate(date1+" 00:00:00");
            } else {
                incomeQueryRequest.setBeginDate(incomeQueryRequest.getBeginDate().toString()+" 00:00:00");
            }
            if(StringUtils.isBlank(incomeQueryRequest.getEndDate())){
                Date endDate = new Date();
                endDate.setMonth(endDate.getMonth());
                String date1 = formatter.format(endDate);
                incomeQueryRequest.setEndDate(date1+" 23:59:59");
            }else {
                incomeQueryRequest.setEndDate(incomeQueryRequest.getEndDate().toString()+" 23:59:59");
            }
            FundBookQueryResponse fundBookQueryResponse = new FundBookQueryResponse();
            PageInfo<IncomeDetail> pageInfo = new  PageInfo<IncomeDetail>();
            pageInfo.setPageNo(pageNO);
            pageInfo.setPageSize(pageSize);
            incomeQueryRequest.setPageInfo(pageInfo);
            fundBookQueryResponse = incomeOutQuerySV.incomeOutQuery(incomeQueryRequest);
            //总收支计算
            IncomeQueryRequest incomeQueryByDate = new IncomeQueryRequest();
            incomeQueryByDate.setTenantId(incomeQueryRequest.getTenantId());
            incomeQueryByDate.setAccountId(incomeQueryRequest.getAccountId());
            incomeQueryByDate.setBeginDate(incomeQueryRequest.getBeginDate());
            incomeQueryByDate.setEndDate(incomeQueryRequest.getEndDate());
            FundBookQueryResponse fundBookQueryResponseByDate = new FundBookQueryResponse();
            incomeQueryRequest.setPageInfo(pageInfo);
            fundBookQueryResponseByDate = incomeOutQuerySV.incomeOutQuery(incomeQueryByDate);
            Long incomeAmount = 0l;
            long outAmount = 0l;
            if (fundBookQueryResponse.getPageInfo()!=null){
                List<IncomeDetail> incomeDetails = fundBookQueryResponseByDate.getPageInfo().getResult();
                for (IncomeDetail incomeDetail:incomeDetails){
                    if (incomeDetail.getIncomeFlag().equals("1")){
                        incomeAmount = incomeAmount + incomeDetail.getTotalAmount();
                    }
                    if (incomeDetail.getIncomeFlag().equals("0")){
                        outAmount = outAmount + incomeDetail.getTotalAmount();
                    }
                }
                for (int i = 0;i<fundBookQueryResponse.getPageInfo().getResult().size();i++){
                    fundBookQueryResponse.getPageInfo().getResult().get(i).setIncomeBalance(incomeAmount);
                    fundBookQueryResponse.getPageInfo().getResult().get(i).setOutBalance(java.lang.Math.abs(outAmount));
                }

            }else {
                IncomeDetail incomeDetail = new IncomeDetail();
                incomeDetail.setIncomeBalance(incomeAmount);
                incomeDetail.setOutBalance(outAmount);
                List<IncomeDetail> list = new ArrayList<>();
                list.add(incomeDetail);
                pageInfo.setResult(list);
                fundBookQueryResponse.setPageInfo(pageInfo);
            }
            resData.setData(fundBookQueryResponse.getPageInfo());
        } catch (Exception e) {
            LOGGER.error("查询收支分页失败:",e);
            resData = new ResponseData<PageInfo<IncomeDetail>>(ResponseData.AJAX_STATUS_FAILURE, "查询收支失败");
        }
        return resData;
    }

    //充值页面
    @RequestMapping("/depositFund")
    public String toDepositFund(){
        return "balance/depositFund";
    }

    /**
     * 跳转第三方支付页面,需要登录后才能进行支付
     * @param
     * @param orderAmount
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/gotoPay")
    public String gotoPay(
            double orderAmount,String currencyUnit,String merchantUrl,String payOrgCode,
            HttpServletResponse response,Model uiModel)
            throws Exception {
        //租户
        String tenantId= ConfigUtil.getProperty("TENANT_ID");
        //服务异步通知地址
        String notifyUrl= ConfigUtil.getProperty("NOTIFY_DEPOSIT_URL")+"/"+ UserUtil.getUserId()+"/"+currencyUnit;
        //商户交易单号(要求商户每次提交的支付请求交易单号不能重复，用于唯一标识每个提交给支付中心的支付请求)
        String orderId = UUIDUtil.genId32();
        //异步通知地址,默认为用户
        String amount = String.valueOf(orderAmount);
        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", tenantId);//租户ID
        map.put("orderId", orderId);//请求单号
        map.put("subject","账户充值");
        map.put("returnUrl", ConfigUtil.getProperty("RETURN_DEPOSIT_URL"));//页面跳转地址
        map.put("notifyUrl", notifyUrl);//服务异步通知地址
        map.put("merchantUrl",merchantUrl);//用户付款中途退出返回商户的地址
        map.put("requestSource", Constants.SELF_SOURCE);//终端来源
        map.put("currencyUnit",currencyUnit);//币种
        map.put("orderAmount", amount);//金额
        map.put("subject", "账号充值");//订单名称
        map.put("payOrgCode",payOrgCode);
        // 加密
        String infoStr = orderId+ VerifyUtil.SEPARATOR
                + amount + VerifyUtil.SEPARATOR
                + notifyUrl + VerifyUtil.SEPARATOR
                + tenantId;
        String infoMd5 = VerifyUtil.encodeParam(infoStr, ConfigUtil.getProperty("REQUEST_KEY"));
        map.put("infoMd5", infoMd5);
        LOGGER.info("开始前台通知:" + map);
        String htmlStr = PaymentUtil.generateAutoSubmitForm(ConfigUtil.getProperty("ACTION_URL"), map);
        LOGGER.info("发起支付申请:" + htmlStr);
        uiModel.addAttribute("paramsMap",map);
        uiModel.addAttribute("actionUrl",ConfigUtil.getProperty("ACTION_URL"));
//        response.setCharacterEncoding("UTF-8");
//        response.setStatus(HttpServletResponse.SC_OK);
//        response.getWriter().write(htmlStr);
//        response.getWriter().flush();
        return "gotoPay";
    }


    /**
     * 根据币种和金额查询符合条件的优惠券
     * @param currencyUnit 币种
     * @param orderAmount 金额
     * @param orderType 订单类型
     * @return
     */
    @RequestMapping(value = "/query/coupon")
    @ResponseBody
    public ResponseData<List<DeductionCouponResponse>> queryCoupon(
            String currencyUnit, Long orderAmount,String orderType){
        ResponseData<List<DeductionCouponResponse>> responseData =
                new ResponseData<List<DeductionCouponResponse>>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        ISendCouponSV sendCouponSV = DubboConsumerFactory.getService(ISendCouponSV.class);
        DeductionCouponRequest couponRequest = new DeductionCouponRequest();
        couponRequest.setCurrencyUnit(currencyUnit);//币种
        couponRequest.setUserId(UserUtil.getUserId());//用户
        couponRequest.setTotalFee(orderAmount);//金额
        couponRequest.setOrderType(orderType);
        //传递适用站点
        couponRequest.setUsedScene(Locale.CHINA.equals(rb.getDefaultLocale()) ?
                BalanceConstants.USED_SCENE_PC_CN : BalanceConstants.USED_SCENE_PC_EN);
        BaseListResponse<DeductionCouponResponse> couponResponse =
                sendCouponSV.queryDisCountCoupon(couponRequest);
        List<DeductionCouponResponse> couponList = null;
        if(couponResponse!=null){
            couponList = couponResponse.getResult();
        }
        //TODO... 模拟数据
        if(CollectionUtil.isEmpty(couponList)) {
            couponList = new ArrayList<>();
        }
//        DeductionCouponResponse coupon = new DeductionCouponResponse();
//        coupon.setCouponId("62");
//        coupon.setCouponName("注册测试");
//        coupon.setFaceValue(1000);
//        coupon.setEffectiveEndTime(DateUtils.afterNow(3*24*60*60*1000));
//        couponList.add(coupon);
//        DeductionCouponResponse coupon1 = new DeductionCouponResponse();
//        coupon1.setCouponId("asdf8wer8293adfasdf");
//        coupon1.setCouponName("10元测试");
//        coupon1.setFaceValue(10000);
//        coupon1.setEffectiveEndTime(DateUtil.getSysDate());
//        couponList.add(coupon1);

        if (CollectionUtil.isEmpty(couponList)){
            couponList = Collections.emptyList();
        }
        responseData.setData(couponList);
        return responseData;
    }

    /**
     * 冻结优惠券
     * @param orderId
     * @param couponId
     * @return
     */
    @RequestMapping("/coupon/freeze")
    @ResponseBody
    public ResponseData<String> freezeCoupon(Long orderId,String couponId){
        ResponseData<String> responseData =
                new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        FreezeCouponRequest request = new FreezeCouponRequest();
        request.setCouponId(couponId);
        request.setOrderId(orderId);
        try {
            ISendCouponSV sendCouponSV = DubboConsumerFactory.getService(ISendCouponSV.class);
            BaseResponse response = sendCouponSV.updateStateFreeze(request);
            //若冻结失败
            if(response!=null && !response.getResponseHeader().isSuccess()){
                throw new BusinessException(response.getResponseHeader().getResultCode()
                        ,response.getResponseHeader().getResultMessage());
            }
        } catch (BusinessException|SystemException e) {
            LOGGER.error("锁定优惠券/优惠码失败。",e);
            responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
                    rb.getMessage("coupon.freeze.fail.msg"));
        }
        return responseData;
    }

    /**
     * 验证优惠券有效性
     * @param currencyUnit
     * @param orderAmount
     * @param couponId
     * @return
     */
    @RequestMapping("/coupon/verify")
    @ResponseBody
    public ResponseData<DeductionCouponResponse> verifyCoupon(String currencyUnit, Long orderAmount, String couponId){
        ResponseData<DeductionCouponResponse> responseData =
                new ResponseData<DeductionCouponResponse>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try {
            ISendCouponSV sendCouponSV = DubboConsumerFactory.getService(ISendCouponSV.class);
            DeductionCouponRequest couponRequest = new DeductionCouponRequest();
            couponRequest.setCurrencyUnit(currencyUnit);//币种
            couponRequest.setCouponId(couponId);//优惠券/优惠码
            couponRequest.setTotalFee(orderAmount);//金额
            //传递适用站点
            couponRequest.setUsedScene(Locale.CHINA.equals(rb.getDefaultLocale()) ?
                    BalanceConstants.USED_SCENE_PC_CN : BalanceConstants.USED_SCENE_PC_EN);
            BaseListResponse<DeductionCouponResponse> couponResponse =
                    sendCouponSV.queryDisCountCoupon(couponRequest);
            if(couponResponse==null || !couponResponse.getResponseHeader().isSuccess()
                    || CollectionUtil.isEmpty(couponResponse.getResult())){
                throw new BusinessException(couponResponse.getResponseHeader().getResultCode()
                        ,couponResponse.getResponseHeader().getResultMessage());
            }
            DeductionCouponResponse coupon = couponResponse.getResult().get(0);
            responseData.setData(coupon);
        } catch (BusinessException|SystemException e) {
            LOGGER.error("锁定优惠券/优惠码失败。",e);
            responseData = new ResponseData<DeductionCouponResponse>(ResponseData.AJAX_STATUS_FAILURE,
                    rb.getMessage("coupon.freeze.fail.msg"));
        }
        return responseData;
    }
}
