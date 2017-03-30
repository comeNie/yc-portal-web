package com.ai.yc.protal.web.model.pay;

/**
 * 订单支付
 * Created by liutong on 2017/3/28.
 */
public class OrderPay {
    /**
     * 订单号
     */
    private Long orderId;
    /**
     * 订单金额，单位：厘
     */
    private Long totalFee;
    /**
     * 应付金额，单位：厘
     */
    private Long orderAmount;
    /**
     * 金额币种，1：人民币；2：美元
     */
    private String currencyUnit;
    /**
     * 订单名称
     */
    private String translateName;
    /*
    订单支付机构编码
     */
    private String payOrgCode;
    /**
     * 当前页面地址
     */
    private String merchantUrl;
    /**
     * 订单类型，1：个人；2：企业
     */
    private String orderType;
    /**
     * 企业标识
     */
    private String corporaId;
    /**
     * 优惠券/优惠码
     */
    private String couponId;

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public Long getTotalFee() {
        return totalFee;
    }

    public void setTotalFee(Long totalFee) {
        this.totalFee = totalFee;
    }

    public Long getOrderAmount() {
        return orderAmount;
    }

    public void setOrderAmount(Long orderAmount) {
        this.orderAmount = orderAmount;
    }

    public String getCurrencyUnit() {
        return currencyUnit;
    }

    public void setCurrencyUnit(String currencyUnit) {
        this.currencyUnit = currencyUnit;
    }

    public String getTranslateName() {
        return translateName;
    }

    public void setTranslateName(String translateName) {
        this.translateName = translateName;
    }

    public String getPayOrgCode() {
        return payOrgCode;
    }

    public void setPayOrgCode(String payOrgCode) {
        this.payOrgCode = payOrgCode;
    }

    public String getMerchantUrl() {
        return merchantUrl;
    }

    public void setMerchantUrl(String merchantUrl) {
        this.merchantUrl = merchantUrl;
    }

    public String getOrderType() {
        return orderType;
    }

    public void setOrderType(String orderType) {
        this.orderType = orderType;
    }

    public String getCorporaId() {
        return corporaId;
    }

    public void setCorporaId(String corporaId) {
        this.corporaId = corporaId;
    }

    public String getCouponId() {
        return couponId;
    }

    public void setCouponId(String couponId) {
        this.couponId = couponId;
    }
}
