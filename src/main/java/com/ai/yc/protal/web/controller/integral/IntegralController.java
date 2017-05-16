package com.ai.yc.protal.web.controller.integral;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.exception.SystemException;
import com.ai.opt.base.vo.BaseListResponse;
import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.BeanUtils;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.util.UUIDUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.slp.balance.api.incomeoutquery.interfaces.IncomeOutQuerySV;
import com.ai.slp.balance.api.incomeoutquery.param.FundBookQueryResponse;
import com.ai.slp.balance.api.incomeoutquery.param.IncomeDetail;
import com.ai.slp.balance.api.incomeoutquery.param.IncomeQueryRequest;
import com.ai.slp.balance.api.integrals.interfaces.IIntegralsSV;
import com.ai.slp.balance.api.integrals.param.IncomeQueryIntegralsRequest;
import com.ai.slp.balance.api.integrals.param.IntegralsDetail;
import com.ai.slp.balance.api.integrals.param.IntegralsQueryResponse;
import com.ai.slp.balance.api.integrals.param.IntegralsResponse;
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
import scala.util.parsing.combinator.testing.Str;

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
        String userId = UserUtil.getUserId();
        //查询积分信息
        IntegralsResponse integralsResponse = null;
        IIntegralsSV iIntegralsSV = DubboConsumerFactory.getService(IIntegralsSV.class);
        integralsResponse = iIntegralsSV.queryIntegrals(userId);
        Integer nowIntegral = 0;
        if(true==integralsResponse.getResponseHeader().isSuccess()){
            uiModel.addAttribute("integration", integralsResponse.getNowIntegral());
        }
        if ("0001".equals(integralsResponse.getResponseHeader().getResultCode())){
            uiModel.addAttribute("integration", nowIntegral);
        }
        return "integral/myIntegral";
    }

    @RequestMapping("/integralsList")
    @ResponseBody
    public ResponseData<PageInfo<IntegralsDetail>> integralsList(@RequestParam(value = "flag") String flag,
                                                                 @RequestParam(value = "pageNo")int pageNO,
                                                                 @RequestParam(value = "pageSize")int pageSize){
        ResponseData<PageInfo<IntegralsDetail>> resData =null;
        IncomeQueryIntegralsRequest incomeQueryIntegralsRequest = new IncomeQueryIntegralsRequest();
        String userId = UserUtil.getUserId();
        incomeQueryIntegralsRequest.setUserId(userId);
        if (!StringUtils.isBlank(flag)){
            incomeQueryIntegralsRequest.setFlag(flag);
        }
        IIntegralsSV iIntegralsSV = DubboConsumerFactory.getService(IIntegralsSV.class);
        try {
            IntegralsQueryResponse integralsQueryResponse = new IntegralsQueryResponse();
            PageInfo<IntegralsDetail> pageInfo = new  PageInfo<IntegralsDetail>();
            pageInfo.setPageNo(pageNO);
            pageInfo.setPageSize(pageSize);
            incomeQueryIntegralsRequest.setPageInfo(pageInfo);
            integralsQueryResponse = iIntegralsSV.incomeOutIntegrals(incomeQueryIntegralsRequest);
            if (integralsQueryResponse.getResponseHeader().isSuccess()) {
                resData = new ResponseData<PageInfo<IntegralsDetail>>(ResponseData.AJAX_STATUS_SUCCESS, "查询成功",integralsQueryResponse.getPageInfo());
            }else {
                resData = new ResponseData<PageInfo<IntegralsDetail>>(ResponseData.AJAX_STATUS_FAILURE, "查询失败", null);
            }
        }catch (Exception e) {
            LOGGER.error("查询账单列表失败：", e);
            resData = new ResponseData<PageInfo<IntegralsDetail>>(ResponseData.AJAX_STATUS_FAILURE, "查询信息异常", null);
        }
        return resData;
    }

}
