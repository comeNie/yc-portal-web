package com.ai.yc.protal.web.controller.order;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.util.DateUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.i18n.ZoneContextHolder;
import com.ai.yc.order.api.orderallocation.interfaces.IOrderAllocationSV;
import com.ai.yc.order.api.orderallocation.param.*;
import com.ai.yc.order.api.orderquery.interfaces.IOrderQuerySV;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountResponse;
import com.ai.yc.order.api.orderreceive.interfaces.IOrderReceiveSV;
import com.ai.yc.order.api.orderreceive.param.*;
import com.ai.yc.order.api.orderreceivesearch.interfaces.IOrderWaitReceiveSV;
import com.ai.yc.order.api.orderreceivesearch.param.OrderWaitReceiveSearchInfo;
import com.ai.yc.order.api.orderreceivesearch.param.OrderWaitReceiveSearchRequest;
import com.ai.yc.order.api.orderreceivesearch.param.OrderWaitReceiveSearchResponse;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.ErrorCode;
import com.ai.yc.protal.web.constants.OrderConstants;
import com.ai.yc.protal.web.constants.TranslatorConstants;
import com.ai.yc.protal.web.service.CacheServcie;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.translator.api.translatorservice.interfaces.IYCTranslatorServiceSV;
import com.ai.yc.translator.api.translatorservice.param.SearchYCTranslatorSkillListRequest;
import com.ai.yc.translator.api.translatorservice.param.UsrLanguageMessage;
import com.ai.yc.translator.api.translatorservice.param.YCTranslatorSkillListResponse;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Timestamp;
import java.util.*;

/**
 * 订单大厅
 * Created by liutong on 16/11/15.
 */
@Controller
@RequestMapping("/p/assigntask")
public class AssignTaskController {
    private static final Logger LOGGER = LoggerFactory.getLogger(AssignTaskController.class);
    @Autowired
    private CacheServcie cacheServcie;
    @Autowired
    ResWebBundle rb;
    /**
     * 分配订单页面
     * @return
     */
    @RequestMapping("/view")
    public String taskCenterView(Model uiModel){
        String retView = "transOrder/assignTask";
        //获取译员信息
        String userId = UserUtil.getUserId();

        try {
            //获取领域和用途
            uiModel.addAttribute("domainList", cacheServcie.getAllDomain(rb.getDefaultLocale()));
            uiModel.addAttribute("purposeList", cacheServcie.getAllPurpose(rb.getDefaultLocale()));
            //获取译员信息
            IYCTranslatorServiceSV userServiceSV = DubboConsumerFactory.getService(IYCTranslatorServiceSV.class);
            SearchYCTranslatorSkillListRequest searchYCUserReq = new SearchYCTranslatorSkillListRequest();
            searchYCUserReq.setTenantId(Constants.DEFAULT_TENANT_ID);
            searchYCUserReq.setUserId(userId);
            YCTranslatorSkillListResponse userInfoResponse = userServiceSV.getTranslatorSkillList(searchYCUserReq);
            //如果译员认证不通过或级别为空，则跳转到认证界面
            //0：认证不通过，1：认证通过
            if(!"1".equals(userInfoResponse.getApproveState())
                    || StringUtils.isBlank(userInfoResponse.getVipLevel())){
                retView = "forward:/p/security/interpreterIndex?showCert=true";
            }else {
                //语言对集合
                List<Object> languageIdList = getLanguageId(userInfoResponse.getUsrLanguageList());
                uiModel.addAttribute("languageIds",languageIdList);
                //查询分配订单数量
                IOrderAllocationSV orderAllocationSV = DubboConsumerFactory.getService(IOrderAllocationSV.class);
                OrdAllocationCountRequest countRequest = new OrdAllocationCountRequest();
                countRequest.setInterperId(UserUtil.getUserId());
                OrdAllocationCountResponse countResponse = orderAllocationSV.queryAlloOrderCount(countRequest);
                if(countResponse != null) {
                    uiModel.addAttribute("assignNum",
                            countResponse.getOrderCount() > 99 ? "99+" : countResponse.getOrderCount());
                }
            }
        } catch (Exception e) {
            LOGGER.error("",e);
            uiModel.addAttribute("isTrans",true);//添加译员标识，用来显示译员菜单和译员的订单地址
            retView = "/sysError.jsp";
        }
        return retView;
    }

    /**
     * 获得待领取订单信息
     * 领域,用途,订单时间(单位:天),输入内容
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public ResponseData<PageInfo<OrderAllocationSearchInfo>> taskCenter(
            @RequestParam(value = "startDateStr",required = false)String startDateStr,
            @RequestParam(value = "endDateStr",required = false)String endDateStr,
            OrderAllocationSearchRequest orderReq){
        ResponseData<PageInfo<OrderAllocationSearchInfo> > resData =
                new ResponseData<PageInfo<OrderAllocationSearchInfo>>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try {
            orderReq.setInterperId(UserUtil.getUserId());
            //若没有页面,则使用第1页为默认
            if (orderReq.getPageNo()==null || orderReq.getPageNo()<1) {
                orderReq.setPageNo(1);
            }
            //获取当前用户所处时区
            TimeZone timeZone = TimeZone.getTimeZone(ZoneContextHolder.getZone());
            //添加下单开始时间
            if (StringUtils.isNotBlank(startDateStr)){
                String dateTmp = startDateStr+" 00:00:00";
                Timestamp date =DateUtil.getTimestamp(dateTmp,DateUtil.DATETIME_FORMAT,timeZone);
                orderReq.setStartStateTime(date);
            }
            //添加下单结束时间
            if (StringUtils.isNotBlank(endDateStr)){
                String dateTmp = endDateStr+" 23:59:59";
                Timestamp date =DateUtil.getTimestamp(dateTmp,DateUtil.DATETIME_FORMAT,timeZone);
                orderReq.setEndStateTime(date);
            }
            IOrderAllocationSV orderAllocationSV = DubboConsumerFactory.getService(IOrderAllocationSV.class);
            OrderAllocationSearchResponse searchResponse = orderAllocationSV.pageSearchAlloWaitReceive(orderReq);

            ResponseHeader resHeader = searchResponse==null?null:searchResponse.getResponseHeader();
            //如果返回值为空,或返回信息中包含错误信息,返回失败
            if (resHeader!=null && !resHeader.isSuccess()){
                throw new BusinessException(resHeader.getResultCode(),resHeader.getResultMessage());
            } else {
                //返回订单分页信息
                resData.setData(searchResponse.getPageInfo());
            }
        } catch (BusinessException e){
            LOGGER.error("查询订单分页失败:",e);
            resData = new ResponseData<PageInfo<OrderAllocationSearchInfo>>(ResponseData.AJAX_STATUS_FAILURE,
                    rb.getMessage("common.res.sys.error",new String[]{e.getErrorCode()}));
        }catch (Exception e) {
            LOGGER.error("查询订单分页失败:",e);
            resData = new ResponseData<PageInfo<OrderAllocationSearchInfo>>(ResponseData.AJAX_STATUS_FAILURE,
                    rb.getMessage("common.res.sys.error", new String[]{ErrorCode.SYSTEM_ERROR}));
        }
        return resData;
    }

    /**
     * 领取订单
     * @return
     */
    @RequestMapping("/claim")
    @ResponseBody
    public ResponseData<String> claimOrder(Long orderId,String step){
        ResponseData<String> responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try {
            OrderAlloReceiveRequest receiveRequest = new OrderAlloReceiveRequest();
            receiveRequest.setOrderId(orderId);
            receiveRequest.setOperName(UserUtil.getUserName());
            receiveRequest.setStep(step);
            receiveRequest.setInterperId(UserUtil.getUserId());
            IOrderReceiveSV iOrderReceiveSV = DubboConsumerFactory.getService(IOrderReceiveSV.class);
            OrderReceiveResponse receiveResponse = iOrderReceiveSV.orderAlloReceive(receiveRequest);
            ResponseHeader header =receiveResponse==null?null:receiveResponse.getResponseHeader();
            //出现错误
            if(header!=null && !header.isSuccess()){
                LOGGER.error("claim order fail,head status:{},head info:{}",
                        header==null?"null":header.getIsSuccess(),header==null?"null":header.getResultMessage());
                //订单领取达到上限
                if (OrderConstants.ErrorCode.NUM_MAX_LIMIT.equals(header.getResultCode())){
                    //领取失败
                    responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
                            rb.getMessage("order.info.claim.max"));
                }//订单已被领取
                else if (OrderConstants.ErrorCode.ALREADY_CLAIM.equals(header.getResultCode())){
                    //领取失败
                    responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
                            rb.getMessage("order.info.already.claim"));
                }
            }

        }catch (Exception e){
            LOGGER.error("Claim order is fail",e);
            //领取失败
            responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,
                    rb.getMessage("common.res.sys.error",new String[]{ErrorCode.SYSTEM_ERROR}));
        }
        return responseData;
    }

    private List<Object> getLanguageId(List<UsrLanguageMessage> languageList){
        List<Object> languageIdList = new ArrayList<>();
        //TODO ...模拟数据
//        languageIdList.add("1");
//        languageIdList.add("10");
//        languageIdList.add("109");
        if (CollectionUtil.isEmpty(languageList)){
            return languageIdList;
        }
        for (UsrLanguageMessage languageMessage:languageList){
            languageIdList.add(languageMessage.getDuadId());
        }
        return languageIdList;
    }
}
