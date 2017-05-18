package com.ai.yc.protal.web.controller.order;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.order.api.ordersubmission.param.*;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.InsertYCContactRequest;
import com.ai.yc.user.api.userservice.param.SearchYCContactRequest;
import com.ai.yc.user.api.userservice.param.YCContactInfoResponse;
import com.ai.yc.user.api.userservice.param.YCInsertContactResponse;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.yc.order.api.ordersubmission.interfaces.IOrderSubmissionSV;
import com.ai.yc.protal.web.utils.UserUtil;
import com.alibaba.fastjson.JSONObject;

import java.sql.Timestamp;

@Controller
@RequestMapping("/p/order")
public class OrderLoginController {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrderLoginController.class);
    @Autowired
    ResWebBundle rb;
    
    /**
     * 提交订单，填写联系人
     * @return
     */
    @RequestMapping(value = "/contact")
    public String contactView(int skip,String transType, Model uiModel){
        uiModel.addAttribute("skip", skip);
        LOGGER.info("skip = " + skip);

        //获取联系人
        try {
            IYCUserServiceSV iYCUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
            SearchYCContactRequest contactReq = new SearchYCContactRequest();
            contactReq.setUserId(UserUtil.getUserId());
            YCContactInfoResponse contactRes = iYCUserServiceSV.searchYCContactInfo(contactReq);
            if (!CollectionUtil.isEmpty(contactRes.getUsrContactList())) {
                uiModel.addAttribute("Contact", contactRes.getUsrContactList());
            }
            uiModel.addAttribute("TransType", transType);

        } catch (Exception e) {
            LOGGER.error("查询联系人失败：", e);
        }

        return "order/orderContact";
    }

    /**
     * 保存联系人
     * @return
     */
    @RequestMapping(value = "/saveContact",method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<String> saveContact(InsertYCContactRequest contactReq) {
        ResponseData<String> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS,"OK");

//        保存联系人信息
        try {
            IYCUserServiceSV iYCUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
            contactReq.setUserId(UserUtil.getUserId());
            YCInsertContactResponse contactRes = iYCUserServiceSV.insertYCContact(contactReq);
            ResponseHeader resHeader = contactRes==null?null:contactRes.getResponseHeader();
            //如果返回值为空,或返回信息中包含错误信息,则抛出异常
            if (contactRes==null|| (resHeader!=null && (!resHeader.isSuccess()))) {
                resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
            }
        } catch(Exception e) {
            LOGGER.error("保存联系人失败：", e);
            resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
        }

        return  resData;
    }

    /**
     * 提交订单
     * @return
     */
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<String> submitOrder(HttpServletRequest request, HttpSession session) {
        ResponseData<String> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        String remark = request.getParameter("remark");
        String contactInfoStr = request.getParameter("contactInfo");
        String transType = request.getParameter("transType");
        LOGGER.info("联系人信息: "+ contactInfoStr);
        LOGGER.info("remark: " + remark);
        LOGGER.info("transType: " + transType);
        try {
            IOrderSubmissionSV orderSubmissionSV = DubboConsumerFactory.getService(IOrderSubmissionSV.class);
            OrderSubmissionRequest subReq;
            if ("2".equals(transType)) {
                subReq  = (OrderSubmissionRequest) session.getAttribute(OrderController.SESSION_ORAL_ORDER_INFO);
            } else {
                subReq  = (OrderSubmissionRequest) session.getAttribute(OrderController.SESSION_WRITE_ORDER_INFO);
            }
            LOGGER.info("订单信息: " + JSONObject.toJSONString(subReq));
            ContactInfo contactInfo = JSON.parseObject(contactInfoStr, ContactInfo.class);
            subReq.setContactInfo(contactInfo);
            subReq.getBaseInfo().setUserId(UserUtil.getUserId());
            StateChgInfo stateChgInfo = new StateChgInfo();
            stateChgInfo.setOperName(UserUtil.getUserName());
            subReq.setStateChgInfo(stateChgInfo);
            subReq.getBaseInfo().setOrderTime(new Timestamp(System.currentTimeMillis()));
            if (StringUtils.isNotEmpty(remark)) {
                subReq.getBaseInfo().setRemark(remark);
            }

            OrderSubmissionResponse subRes = orderSubmissionSV.orderSubmission(subReq);
            ResponseHeader resHeader = subRes==null?null:subRes.getResponseHeader();
            LOGGER.info(JSONObject.toJSONString(subRes));
            //如果返回值为空,或返回信息中包含错误信息,则抛出异常
            if (subRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
                resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, "");
            } else {
                resData.setData(subRes.getOrderId()+"");//返回订单信息
                //保存成功，清除会话中的 订单信息
                session.removeAttribute(OrderController.SESSION_ORAL_ORDER_INFO);
                session.removeAttribute(OrderController.SESSION_ORAL_ORDER_SUMMARY);
                session.removeAttribute(OrderController.SESSION_WRITE_ORDER_INFO);
                session.removeAttribute(OrderController.SESSION_WRITE_ORDER_SUMMARY);
                session.removeAttribute(OrderController.SESSION_ORDER_FILE_LIST);
            }


        } catch (Exception e) {
            LOGGER.error("提交订单失败:",e);
            resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE,"");
        }

        return  resData;
    }
}
