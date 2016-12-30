package com.ai.yc.protal.web.model.pay;

/**
 * 余额支付结果
 * Created by liutong on 16/12/30.
 */
public class YEPayResult {
    String orderId;
    /*
    余额支付状态码，最新信息参考
    com.ai.yc.protal.web.constants.YEPayResultConstants
     */
    String payResultCode;

    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getPayResultCode() {
        return payResultCode;
    }

    public void setPayResultCode(String payResultCode) {
        this.payResultCode = payResultCode;
    }
}
