package com.ai.yc.protal.web.controller.integral;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.base.vo.BaseListResponse;
import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.util.UUIDUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.slp.balance.api.incomeoutquery.interfaces.IncomeOutQuerySV;
import com.ai.slp.balance.api.incomeoutquery.param.FundBookQueryResponse;
import com.ai.slp.balance.api.incomeoutquery.param.IncomeDetail;
import com.ai.slp.balance.api.incomeoutquery.param.IncomeQueryRequest;
import com.ai.slp.balance.api.sendcoupon.interfaces.ISendCouponSV;
import com.ai.slp.balance.api.sendcoupon.param.DeductionCouponRequest;
import com.ai.slp.balance.api.sendcoupon.param.DeductionCouponResponse;
import com.ai.slp.balance.api.sendcoupon.param.FreezeCouponRequest;
import com.ai.yc.protal.web.constants.BalanceConstants;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.model.pay.AccountBalanceInfo;
import com.ai.yc.protal.web.service.BalanceService;
import com.ai.yc.protal.web.utils.*;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 我的帐户
 * Created by lixiaokui on 16/11/14.
 */
@Controller
@RequestMapping("/p/integral")
public class IntegralController {
    private static final Logger LOGGER = LoggerFactory.getLogger(IntegralController.class);
    @Autowired
    BalanceService balanceService;
    @Autowired
    ResWebBundle rb;

    /**
     * 显示我的积分页面
     * @return
     */
    @RequestMapping("/myIntegral")
    public String toMyIntegral(Model uiModel){
        //积分
//        AccountBalanceInfo balanceInfo =  balanceService.queryOfUser(UserUtil.getUserId());
//        uiModel.addAttribute("currencyUnit",balanceInfo.getCurrencyUnit());
//        uiModel.addAttribute("balance",String.valueOf(AmountUtil.changeLiToYuan(balanceInfo.getBalance())));
//        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
//        Date beginDate = new Date();
//        beginDate.setMonth(beginDate.getMonth()-1);
//        String date1 = formatter.format(beginDate);
//        Date endDate = new Date();
//        endDate.setMonth(endDate.getMonth());
//        String date2 = formatter.format(endDate);
//
//        uiModel.addAttribute("beginTime",date1);
//        uiModel.addAttribute("endTime",date2);
        return "integral/myIntegral";
    }

}
