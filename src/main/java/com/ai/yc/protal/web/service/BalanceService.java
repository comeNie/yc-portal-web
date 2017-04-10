package com.ai.yc.protal.web.service;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.BeanUtils;
import com.ai.opt.sdk.util.StringUtil;
import com.ai.slp.balance.api.accountquery.interfaces.IAccountQuerySV;
import com.ai.slp.balance.api.fundquery.param.AccountIdParam;
import com.ai.slp.balance.api.accountquery.param.AccountInfoVo;
import com.ai.slp.balance.api.fundquery.interfaces.IFundQuerySV;
import com.ai.slp.balance.api.fundquery.param.FundInfo;
import com.ai.slp.balance.api.sendcoupon.interfaces.ISendCouponSV;
import com.ai.slp.balance.api.sendcoupon.param.DeductionCouponRequest;
import com.ai.yc.protal.web.constants.BalanceConstants;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.model.pay.AccountBalanceInfo;
import com.ai.yc.user.api.usercompany.interfaces.IYCUserCompanySV;
import com.ai.yc.user.api.usercompany.param.UserCompanyInfoRequest;
import com.ai.yc.user.api.usercompany.param.UserCompanyInfoResponse;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Locale;

/**
 * 账户对应服务
 * Created by liutong on 16/11/14.
 */
@Service
public class BalanceService {
    private static final Logger LOGGER = LoggerFactory.getLogger(BalanceService.class);

    /**
     * 查询当前登录用户的余额信息
     *
     * @return 若没有余额信息,则返回null
     */
    public AccountBalanceInfo queryOfUser(String userId){
        //获取当前用户
        IYCUserServiceSV userServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
        SearchYCUserRequest searchYCUserReq = new SearchYCUserRequest();
        searchYCUserReq.setTenantId(Constants.DEFAULT_TENANT_ID);
        searchYCUserReq.setUserId(userId);
        YCUserInfoResponse userInfoResponse = userServiceSV.searchYCUserInfo(searchYCUserReq);
        AccountBalanceInfo accountBalanceInfo = null;
        //若账户信息不为空，则查询账户信息
        if (userInfoResponse != null && userInfoResponse.getAccountId() != null){
            accountBalanceInfo = queryByAccount(userInfoResponse.getAccountId(),null);
        }
        if(accountBalanceInfo!=null){
            accountBalanceInfo.setObjId(userId);
        }

        return accountBalanceInfo;
    }

    /**
     * 根据用户Id查询所属企业的账户信息
     * @param userId
     * @return 若用户属于企业，则正常反应企业账户信息，否则返回null
     */
    public AccountBalanceInfo queryOfCompanyByUserId(String userId){
        IYCUserCompanySV userCompanySV = DubboConsumerFactory.getService(IYCUserCompanySV.class);
        UserCompanyInfoRequest request = new UserCompanyInfoRequest();
        request.setUserId(userId);
        //只能查询到已认证企业
        UserCompanyInfoResponse response = userCompanySV.queryCompanyInfo(request);
        AccountBalanceInfo accountBalanceInfo = null;
        if(response != null && response.getAccountId() != null){
            accountBalanceInfo = queryByAccount(response.getAccountId(),response.getCompanyId());
            if(accountBalanceInfo!=null){
                accountBalanceInfo.setObjId(response.getCompanyId());
            }
        }//TODO... 模拟数据
        /*else {
            accountBalanceInfo = new AccountBalanceInfo();
            accountBalanceInfo.setObjId("234asdf");
            accountBalanceInfo.setAccountId(23423l);//账户ID
            accountBalanceInfo.setBalance(110l);//余额
            accountBalanceInfo.setPayCheck("2");//不需要密码验证
            accountBalanceInfo.setCurrencyUnit(Constants.CURRENCTY_UNIT_RMB);//人民币
            accountBalanceInfo.setAccountType("2");//后付费
            accountBalanceInfo.setDiscount(new BigDecimal(0.88));//折扣
            accountBalanceInfo.setDiscountStr("8.8");//折扣的字符串
//          是否验证密码。0 不验证 1 验证
            accountBalanceInfo.setPayCheck(BalanceConstants.PAY_CHECK_TRUE);
        }*/

        return accountBalanceInfo;
    }

    /**
     * 根据账户ID查询账户信息
     * @param accountId
     * @return
     */
    private AccountBalanceInfo queryByAccount(long accountId,String userId){
        AccountBalanceInfo accountBalanceInfo = null;

        //查询用户余额
        IFundQuerySV fundQuerySV = DubboConsumerFactory.getService(IFundQuerySV.class);
        AccountIdParam accountIdParam = new AccountIdParam();
        accountIdParam.setTenantId(Constants.DEFAULT_TENANT_ID);
        accountIdParam.setAccountId(accountId);
        accountIdParam.setUserID(userId);
        FundInfo fundInfo = fundQuerySV.queryUsableFund(accountIdParam);

        //查询账号设置
        IAccountQuerySV accountQuerySV = DubboConsumerFactory.getService(IAccountQuerySV.class);
        com.ai.slp.balance.api.accountquery.param.AccountIdParam accountInfoReq =
                new com.ai.slp.balance.api.accountquery.param.AccountIdParam();
        accountInfoReq.setTenantId(Constants.DEFAULT_TENANT_ID);
        accountInfoReq.setAccountId(accountId);
        AccountInfoVo accountInfoVo = accountQuerySV.queryAccontById(accountInfoReq);

        accountBalanceInfo = new AccountBalanceInfo();
        BeanUtils.copyProperties(accountBalanceInfo,fundInfo);
        accountBalanceInfo.setPayCheck(accountInfoVo.getPayCheck());
        accountBalanceInfo.setPayPassword(accountInfoVo.getPayPassword());
        //进行折扣处理,均是两位小数，如0.88标识8.8折
        BigDecimal discount = fundInfo.getDiscount();
        if(discount != null){
            double dis = discount.doubleValue()*10;
            //若有小数，则显示小数，否则显示整数
            accountBalanceInfo.setDiscountStr(dis%1>0?Double.toString(dis):Integer.toString((int)dis));
        }
        return accountBalanceInfo;
    }

    /**
     * 使用优惠券
     * @param userId
     * @param couponId
     * @param orderId
     * @param totalFee
     * @param currencyUnit
     * @param orderType
     */
    public void deductionCoupon(String userId, String couponId, Long orderId, Long totalFee,
                                String currencyUnit, Locale locale, String orderType) throws BusinessException {
        //若优惠券为空，则不进行处理。
        if(StringUtil.isBlank(couponId))
            return;
        ISendCouponSV sendCouponSV = DubboConsumerFactory.getService(ISendCouponSV.class);
        DeductionCouponRequest request = new DeductionCouponRequest();
        request.setUserId(userId);
        request.setOrderId(orderId);
        request.setTotalFee(totalFee);
        request.setCouponId(couponId);
        request.setCurrencyUnit(currencyUnit);
        request.setOrderType(orderType);
        request.setUsedScene(
                Locale.CHINA.equals(locale) ? BalanceConstants.USED_SCENE_PC_CN : BalanceConstants.USED_SCENE_PC_EN);
        BaseResponse response = sendCouponSV.deducionCoupon(request);
        //若操作不成功，则抛出异常
        if(response==null || !response.getResponseHeader().isSuccess()
                || !Constants.SUCCESS_CODE.equals(response.getResponseHeader().getResultCode())){
            LOGGER.warn("抵扣优惠券失败，错误码：{}，错误信息：{}",response.getResponseHeader().getResultCode(),
                    response.getResponseHeader().getResultMessage());
            throw new BusinessException(response.getResponseHeader().getResultCode(),
                    response.getResponseHeader().getResultMessage());
        }
    }

}
