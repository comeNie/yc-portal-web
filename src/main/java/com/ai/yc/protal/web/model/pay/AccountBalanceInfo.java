package com.ai.yc.protal.web.model.pay;

import java.math.BigDecimal;

/**
 * 账户余额信息
 * Created by liutong on 16/11/14.
 */
public class AccountBalanceInfo {
    /*
    主体标识，用户ID或企业ID
    */
    private String objId;
    /*
    账户ID
     */
    private long accountId;
    /*
    余额 单位:厘
     */
    private long balance;
    /*
    是否需要密码
     */
    private String payCheck;
    /**
     * 支付密码
     */
    private String payPassword;
    /*
    币种
     */
    private String currencyUnit;
    /**
     * 结算方式  1：预付费2：后付费
     */
    private String accountType;
    /**
     * 折扣,传小数,例如88折,返回0.88
     */
    private BigDecimal discount;
    /**
     * 折扣字符，如0.88,显示8.8折，0.8,显示8折
     */
    private String discountStr;

    public String getCurrencyUnit() {
        return currencyUnit;
    }

    public void setCurrencyUnit(String currencyUnit) {
        this.currencyUnit = currencyUnit;
    }

    public long getAccountId() {
        return accountId;
    }

    public void setAccountId(long accountId) {
        this.accountId = accountId;
    }

    public long getBalance() {
        return balance;
    }

    public void setBalance(long balance) {
        this.balance = balance;
    }

    public String getPayCheck() {
        return payCheck;
    }

    public void setPayCheck(String payCheck) {
        this.payCheck = payCheck;
    }

	public String getPayPassword() {
		return payPassword;
	}

	public void setPayPassword(String payPassword) {
		this.payPassword = payPassword;
	}

    public BigDecimal getDiscount() {
        return discount;
    }

    public void setDiscount(BigDecimal discount) {
        this.discount = discount;
    }

    public String getDiscountStr() {
        return discountStr;
    }

    public void setDiscountStr(String discountStr) {
        this.discountStr = discountStr;
    }

    public String getObjId() {
        return objId;
    }

    public void setObjId(String objId) {
        this.objId = objId;
    }

    public String getAccountType() {
        return accountType;
    }

    public void setAccountType(String accountType) {
        this.accountType = accountType;
    }
}
