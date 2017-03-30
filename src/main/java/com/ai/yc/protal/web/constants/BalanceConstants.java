package com.ai.yc.protal.web.constants;

/**
 * 账务相关内容
 * Created by liutong on 16/11/14.
 */
public final class BalanceConstants {
    private BalanceConstants(){}

    //支付需要验证密码
    public static final String PAY_CHECK_TRUE= "1";
    //支付不需要验证密码
    public static final String PAY_CHECK_FALSE="0";
    /**
     * 1：预付费
     */
    public static final String ACCOUNT_TYPE_PRE = "1";
    /**
     * 2：预付费
     */
    public static final String ACCOUNT_TYPE_AFTER = "2";
    /**
     * 译云PC中文站
     */
    public static final String USED_SCENE_PC_CN = "1";

    /**
     * 译云PC英文站
     */
    public static final String USED_SCENE_PC_EN = "2";
}
