package com.ai.yc.protal.web.controller.coupon;


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
import com.ai.slp.balance.api.sendcoupon.interfaces.ISendCouponSV;
import com.ai.slp.balance.api.sendcoupon.param.DeductionCouponResponse;
import com.ai.slp.balance.api.sendcoupon.param.QueryCouponRequest;
import com.ai.slp.balance.api.sendcoupon.param.QueryCouponRsponse;
import com.alibaba.fastjson.JSONObject;


/**
 * 优惠券
 * Created by shancc on 17/3/30.
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
    @RequestMapping("/list/view")
    public String orderListView(Model uiModel){
        return "coupon/couponList";
    }
    
    /**
     * 查询优惠券列表
     * @param request
     * @return
     */
    @RequestMapping("/couponList")
    @ResponseBody
    public ResponseData<PageInfo<DeductionCouponResponse> > couponList(HttpServletRequest request,  QueryCouponRequest couponReq){
        ResponseData<PageInfo<DeductionCouponResponse>> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try {
            //如果 状态、用户id 都为null，返回空。一般不会出现
            if (StringUtils.isEmpty(couponReq.getUserId()) && StringUtils.isEmpty(couponReq.getStatus())) {
                resData.setData(null);
                return resData;
            }
            LOGGER.info("优惠券列表查询数据：" +JSONObject.toJSONString(couponReq));
            
            ISendCouponSV iSendCouponSV = DubboConsumerFactory.getService(ISendCouponSV.class);
            QueryCouponRsponse queryCouponPage = iSendCouponSV.queryCouponPage(couponReq);
            ResponseHeader resHeader = queryCouponPage==null?null:queryCouponPage.getResponseHeader();
            LOGGER.info("优惠券列表查询 ：" + JSONObject.toJSONString(queryCouponPage));
            
            //如果返回值为空,或返回信息中包含错误信息,返回失败
            if (queryCouponPage==null|| (resHeader!=null && (!resHeader.isSuccess()))){
                resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
            } else {
                PageInfo<DeductionCouponResponse> pageInfo = queryCouponPage.getPageInfo();
                //返回订单分页信息
                resData.setData(pageInfo);
            }
        } catch (Exception e) {
            LOGGER.error("查询优惠券分页失败:",e);
            resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
        }
        return resData;
    }
}
