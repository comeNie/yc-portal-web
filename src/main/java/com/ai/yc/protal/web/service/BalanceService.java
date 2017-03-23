package com.ai.yc.protal.web.service;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.BeanUtils;
import com.ai.slp.balance.api.accountquery.interfaces.IAccountQuerySV;
import com.ai.slp.balance.api.fundquery.param.AccountIdParam;
import com.ai.slp.balance.api.accountquery.param.AccountInfoVo;
import com.ai.slp.balance.api.fundquery.interfaces.IFundQuerySV;
import com.ai.slp.balance.api.fundquery.param.FundInfo;
import com.ai.slp.balance.api.sendcoupon.param.DeductionCouponResponse;
import com.ai.yc.protal.web.constants.BalanceConstants;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.model.pay.AccountBalanceInfo;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.user.api.usercompany.interfaces.IYCUserCompanySV;
import com.ai.yc.user.api.usercompany.param.UserCompanyInfoRequest;
import com.ai.yc.user.api.usercompany.param.UserCompanyInfoResponse;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;

/**
 * 账户对应服务
 * Created by liutong on 16/11/14.
 */
@Service
public class BalanceService {

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
            accountBalanceInfo = queryByAccount(userInfoResponse.getAccountId());
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
            accountBalanceInfo = queryByAccount(response.getAccountId());
            if(accountBalanceInfo!=null){
                accountBalanceInfo.setObjId(response.getCompanyId());
            }
        }

        return accountBalanceInfo;
    }

    /**
     * 根据账户ID查询账户信息
     * @param accountId
     * @return
     */
    private AccountBalanceInfo queryByAccount(long accountId){
        AccountBalanceInfo accountBalanceInfo = null;
        //查询用户余额
        IFundQuerySV fundQuerySV = DubboConsumerFactory.getService(IFundQuerySV.class);
        AccountIdParam accountIdParam = new AccountIdParam();
        accountIdParam.setTenantId(Constants.DEFAULT_TENANT_ID);
        accountIdParam.setAccountId(accountId);
        FundInfo fundInfo = fundQuerySV.queryUsableFund(accountIdParam);
        //查询账号设置
        IAccountQuerySV accountQuerySV = DubboConsumerFactory.getService(IAccountQuerySV.class);
        com.ai.slp.balance.api.accountquery.param.AccountIdParam accountInfoReq =
                new com.ai.slp.balance.api.accountquery.param.AccountIdParam();
        accountInfoReq.setTenantId(Constants.DEFAULT_TENANT_ID);
        accountInfoReq.setAccountId(accountId);
        AccountInfoVo accountInfoVo = accountQuerySV.queryAccontById(accountInfoReq);

        //TODO....模拟数据
//        fundInfo = new FundInfo();
//        fundInfo.setAccountId(23423l);
//        fundInfo.setBalance(110l);
        //TODO....模拟数据
//        accountInfoVo = new AccountInfoVo();
//        0 不验证 1 验证
//        accountInfoVo.setPayCheck(BalanceConstants.PAY_CHECK_TRUE);
        //支付密码
//        accountInfoVo.setPayPassword(null);

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


}
