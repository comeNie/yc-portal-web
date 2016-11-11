package com.ai.yc.protal.web.controller;

import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.model.pay.PayNotify;
import com.ai.yc.protal.web.utils.AmountUtil;
import com.ai.yc.protal.web.utils.ConfigUtil;
import com.ai.yc.protal.web.utils.PaymentUtil;
import com.ai.yc.protal.web.utils.VerifyUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by liutong on 16/11/10.
 */
@Controller
@RequestMapping("/pay")
public class PayController {
    private static final Logger LOG = LoggerFactory.getLogger(PayController.class);

    /**
     * 跳转支付页面
     * @param orderId
     * @param orderAmount
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/gotoPay")
    public void gotoPay(
            String orderId,Long orderAmount,String currencyUnit,String merchantUrl,String payOrgCode,
            HttpServletResponse response)
            throws Exception {
        String tenantId=ConfigUtil.getProperty("TENANT_ID");
        //服务异步通知地址
        String notifyUrl= ConfigUtil.getProperty("NOTIFY_URL");
        String amount = String.valueOf(AmountUtil.changeLiToYuan(orderAmount));
        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", tenantId);//租户ID
        map.put("orderId", orderId);//请求单号
        map.put("returnUrl", ConfigUtil.getProperty("RETURN_URL"));//页面跳转地址
        map.put("notifyUrl", ConfigUtil.getProperty("NOTIFY_URL"));//服务异步通知地址
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
        LOG.info("开始前台通知:" + map);
        String htmlStr = PaymentUtil.generateAutoSubmitForm(ConfigUtil.getProperty("ACTION_URL"), map);
        LOG.info("发起支付申请:" + htmlStr);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(htmlStr);
        response.getWriter().flush();
    }

    /**
     * 订单支付结果
     * @return
     */
    @RequestMapping("/payResultView")
    public String orderPayResultView(PayNotify payNotify, Model uiModel){
        //订单号
        uiModel.addAttribute("orderId",payNotify.getOrderId());
        //支付结果
        uiModel.addAttribute("payResult",PayNotify.PAY_STATES_SUCCESS.equals(payNotify.getPayStates()));
        return "order/orderPayResult";
    }
    /**
     * 订单支付结果
     * @return
     */
    @RequestMapping("/payResult")
    public void orderPayResult(PayNotify payNotify){
        //TODO...
        LOG.info("The pay result,orderId:{},payResult:{}",payNotify.getOrderId(),payNotify.getPayStates());
    }
}
