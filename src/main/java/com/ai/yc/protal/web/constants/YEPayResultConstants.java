package com.ai.yc.protal.web.constants;

/**
 * 余额支付
 * Created by liutong on 16/12/30.
 */
public final class YEPayResultConstants {
    private YEPayResultConstants(){}

    /**
     * 已支付
     */
    public static final String ORDER_PAID = "-1";
    /**
     * 支付成功
     */
    public static final String RESULT_SUCCESS ="success";
    /**
     * 余额不足
     */
    public static final String CODE_000001="300002";
    /**
     * 账户不存在
     */
    public static final String CODE_000002="100001";
    /**
     * 账本不存在
     */
    public static final String CODE_000004="300001";
    /**
     * 请输入密码
     */
    public static final String CODE_000005="000005";
    /**
     * 支付密码不正确
     */
    public static final String CODE_000006="000006";
    /**
     * 支付密码未设置
     */
    public static final String CODE_000007="000007";
}
