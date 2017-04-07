package com.ai.yc.protal.web.controller.coupon;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.slp.balance.api.couponuserule.interfaces.ICouponUseRuleSV;
import com.ai.slp.balance.api.couponuserule.param.FunCouponUseRuleQueryResponse;
import com.ai.slp.balance.api.sendcoupon.interfaces.ISendCouponSV;
import com.ai.slp.balance.api.sendcoupon.param.DeductionCouponResponse;
import com.ai.slp.balance.api.sendcoupon.param.QueryCouCountRequest;
import com.ai.slp.balance.api.sendcoupon.param.QueryCouponRequest;
import com.ai.slp.balance.api.sendcoupon.param.QueryCouponRsponse;
import com.ai.yc.protal.web.utils.UserUtil;
import com.alibaba.fastjson.JSONObject;

/**
 * 优惠券 Created by shancc on 17/3/30.
 */
@Controller
@RequestMapping("/p/coupon")
public class CouponController {
	private static final Logger LOGGER = LoggerFactory.getLogger(CouponController.class);
	@Autowired
	private ResWebBundle rb;

	/**
	 * 我的优惠券
	 */
	@RequestMapping("/couponList")
	public String couponListView(Model uiModel) {
		String userId = UserUtil.getUserId();
		ISendCouponSV iSendCouponSV = DubboConsumerFactory.getService(ISendCouponSV.class);
		// 未使用
		QueryCouCountRequest queryCouCountRequest = new QueryCouCountRequest();
		queryCouCountRequest.setStatus("1");
		queryCouCountRequest.setUserId(userId);
		Integer queryCouponCountNot = iSendCouponSV.queryCouponCount(queryCouCountRequest);
		uiModel.addAttribute("queryCouponCountNot", queryCouponCountNot);
		// 已使用
		QueryCouCountRequest queryCouCountRequest1 = new QueryCouCountRequest();
		queryCouCountRequest1.setStatus("2");
		queryCouCountRequest1.setUserId(userId);
		Integer queryCouponCountAlr = iSendCouponSV.queryCouponCount(queryCouCountRequest1);
		uiModel.addAttribute("queryCouponCountAlr", queryCouponCountAlr);
		// 已过期
		QueryCouCountRequest queryCouCountRequest2 = new QueryCouCountRequest();
		queryCouCountRequest2.setUserId(userId);
		Integer queryCouponCountExp = iSendCouponSV.queryCouponOveCount(queryCouCountRequest2);
		uiModel.addAttribute("queryCouponCountExp", queryCouponCountExp);
		return "coupon/couponList";
	}

	/**
	 * 查询优惠券列表
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/queryCouponList")
	@ResponseBody
	public ResponseData<PageInfo<DeductionCouponResponse>> queryCouponList(HttpServletRequest request,
			QueryCouponRequest queryCouponRequest) {
		ResponseData<PageInfo<DeductionCouponResponse>> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS,
				"OK");
		String userId = UserUtil.getUserId();
		try {
			// 如果 状态、用户id 都为null，返回空。一般不会出现
			if (StringUtils.isEmpty(userId) && StringUtils.isEmpty(queryCouponRequest.getStatus())) {
				resData.setData(null);
				return resData;
			}
			ISendCouponSV iSendCouponSV = DubboConsumerFactory.getService(ISendCouponSV.class);
			queryCouponRequest.setUserId(userId);
			QueryCouponRsponse queryCouponPage = iSendCouponSV.queryCouponPage(queryCouponRequest);
			List<DeductionCouponResponse> result = queryCouponPage.getPageInfo().getResult();
			for (DeductionCouponResponse deductionCouponResponse : result) {
				if (!(deductionCouponResponse.getCouponUserId().equals("0"))) {
					String requiredMoneyAmounts = null;
					String couponUserId = deductionCouponResponse.getCouponUserId();
					ICouponUseRuleSV couponUseRuleSV = DubboConsumerFactory.getService(ICouponUseRuleSV.class);
					List<FunCouponUseRuleQueryResponse> queryFunCouponUseRule = couponUseRuleSV
							.queryFunCouponUseRule(couponUserId);
					for (FunCouponUseRuleQueryResponse funCouponUseRuleQueryResponse : queryFunCouponUseRule) {
						Integer requiredMoneyAmount = funCouponUseRuleQueryResponse.getRequiredMoneyAmount();
						requiredMoneyAmounts = requiredMoneyAmount.toString();
					}
					deductionCouponResponse.setCouponUserId(requiredMoneyAmounts);
				}
			}

			ResponseHeader resHeader = queryCouponPage == null ? null : queryCouponPage.getResponseHeader();
			LOGGER.info("优惠券列表查询 ：" + JSONObject.toJSONString(queryCouponPage));

			// 如果返回值为空,或返回信息中包含错误信息,返回失败
			if (queryCouponPage == null || (resHeader != null && (!resHeader.isSuccess()))) {
				resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
			} else {
				PageInfo<DeductionCouponResponse> pageInfo = queryCouponPage.getPageInfo();
				// 返回订单分页信息
				resData.setData(pageInfo);
			}
		} catch (Exception e) {
			LOGGER.error("查询优惠券分页失败:", e);
			resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
		}
		return resData;
	}
}
