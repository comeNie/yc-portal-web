package com.ai.yc.protal.web.controller.order;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ai.yc.order.api.ordersubmission.param.*;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ai.opt.base.exception.BusinessException;
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
    
    /**
     * 提交订单，填写联系人
     * @return
     */
    @RequestMapping(value = "/contact")
    public String contactView(int skip,Model uiModel){
        uiModel.addAttribute("skip", skip);
        LOGGER.info("skip = " + skip);
        return "order/orderContact";
    }

    /**
     * 提交订单
     * @return
     */
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<String> submitOrder(HttpServletRequest request, HttpSession session) {
        ResponseData<String> resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        String contactInfoStr = request.getParameter("contactInfo");
        String remark = request.getParameter("remark");

        try {
            IOrderSubmissionSV orderSubmissionSV = DubboConsumerFactory.getService(IOrderSubmissionSV.class);
            OrderSubmissionRequest subReq  = (OrderSubmissionRequest) session.getAttribute("orderInfo");
            subReq.setContactInfo(JSON.parseObject(contactInfoStr, ContactInfo.class));
            subReq.getBaseInfo().setUserId(UserUtil.getUserId());
            subReq.getBaseInfo().setOrderTime(new Timestamp(System.currentTimeMillis()));
            if (StringUtils.isNotEmpty(remark)) {
                subReq.getBaseInfo().setRemark(remark);
            }

            OrderSubmissionResponse subRes = orderSubmissionSV.orderSubmission(subReq);
            ResponseHeader resHeader = subRes==null?null:subRes.getResponseHeader();
            LOGGER.info(JSONObject.toJSONString(subRes));
            //如果返回值为空,或返回信息中包含错误信息,则抛出异常
            if (subRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
                resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, "");
            } else {
                resData.setData(subRes.getOrderId()+"");//返回订单信息
            }
        } catch (Exception e) {
            LOGGER.error("提交订单失败:",e);
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,"");
        }

        return  resData;
    }
}
