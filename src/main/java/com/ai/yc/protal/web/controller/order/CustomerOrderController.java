package com.ai.yc.protal.web.controller.order;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.order.api.orderfee.interfaces.IOrderFeeQuerySV;
import com.ai.yc.order.api.orderfee.param.OrderFeeInfo;
import com.ai.yc.order.api.orderfee.param.OrderFeeQueryRequest;
import com.ai.yc.order.api.orderfee.param.OrderFeeQueryResponse;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.utils.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.order.api.ordersubmission.interfaces.IOrderSubmissionSV;
import com.alibaba.fastjson.JSONObject;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * 客户订单
 * Created by liutong on 16/11/3.
 */
@Controller
@RequestMapping("/p/customer/order")
public class CustomerOrderController {
    private static final Logger LOGGER = LoggerFactory.getLogger(CustomerOrderController.class);
    
    /**
     * 我的订单,订单列表
     * @return
     */
    @RequestMapping("/list/view")
    public String orderListView(){
        return "customerOrder/orderList";
    }

    /**
     * 支付页面
     * @return
     */
    @RequestMapping("/payOrder/{orderId}")
    public String createTextView(@PathVariable("orderId") Long orderId,String unit,Model uiModel){
        //TODO... 模拟数据
//        IOrderFeeQuerySV iOrderFeeQuerySV = DubboConsumerFactory.getService(IOrderFeeQuerySV.class);
//        OrderFeeQueryRequest feeQueryRequest = new OrderFeeQueryRequest();
//        feeQueryRequest.setOrderId(orderId);
//        OrderFeeQueryResponse feeQueryResponse = iOrderFeeQuerySV.orderFeeQuery(feeQueryRequest);
        OrderFeeQueryResponse feeQueryResponse = new OrderFeeQueryResponse();
        OrderFeeInfo orderFeeInfo = new OrderFeeInfo();
        feeQueryResponse.setOrderFeeInfo(orderFeeInfo);
        //模拟币种
        orderFeeInfo.setCurrencyUnit(unit);

        //总费用
        orderFeeInfo.setTotalFee(100000l);
        //获取订单价格,币种
        //订单编号
        uiModel.addAttribute("orderId",orderId);
        //订单信息
        uiModel.addAttribute("orderFee",feeQueryResponse.getOrderFeeInfo());
        return "order/payOrder";
    }

    /**
     * 跳转支付页面,需要登录后才能进行支付
     * @param orderId
     * @param orderAmount
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/gotoPay")
    public void gotoPay(
            String orderId,Long orderAmount,String currencyUnit,String merchantUrl,String payOrgCode,
            String orderType,
            HttpServletResponse response)
            throws Exception {
        //租户
        String tenantId= ConfigUtil.getProperty("TENANT_ID");
        //服务异步通知地址
        String notifyUrl= ConfigUtil.getProperty("NOTIFY_URL")+"/"+orderType+"/"+ UserUtil.getUserId();

        //异步通知地址,默认为用户
        String amount = String.valueOf(AmountUtil.changeLiToYuan(orderAmount));
        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", tenantId);//租户ID
        map.put("orderId", orderId);//请求单号
        map.put("returnUrl", ConfigUtil.getProperty("RETURN_URL"));//页面跳转地址
        map.put("notifyUrl", notifyUrl);//服务异步通知地址
        map.put("merchantUrl",merchantUrl);//用户付款中途退出返回商户的地址
        map.put("requestSource", Constants.SELF_SOURCE);//终端来源
        map.put("currencyUnit",currencyUnit);//币种
        map.put("orderAmount", amount);//金额
        map.put("subject", "orderPay");//订单名称
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
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(htmlStr);
        response.getWriter().flush();
    }

    /**
     * 显示订单详情
     * @param orderId
     * @param uiModel
     * @return
     */
    @RequestMapping("/{orderId}")
    public String orderInfoView(@PathVariable("orderId") String orderId, Model uiModel){
        //TODO... 查询订单详情
        return "customerOrder/orderInfo";
    }
}
