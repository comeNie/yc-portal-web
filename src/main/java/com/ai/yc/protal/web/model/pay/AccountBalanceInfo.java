package com.ai.yc.protal.web.model.pay;

/**
 * 账户余额信息
 * Created by liutong on 16/11/14.
 */
public class AccountBalanceInfo {
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
    private String payPassword;
    /*
    币种
     */
    private String currencyUnit;

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
    
}
