package com.ai.yc.protal.web.controller.order;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.order.api.ordersubmission.interfaces.IOrderSubmissionSV;
import com.ai.yc.order.api.ordersubmission.param.OrderSubmissionRequest;
import com.ai.yc.order.api.ordersubmission.param.OrderSubmissionResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 通用订单
 * Created by liutong on 16/11/2.
 */
@Controller
@RequestMapping("/order")
public class OrderController {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrderController.class);
//    @Autowired
//    ResWebBundle rb;

    /**
     * 显示文本类下单页面
     * @return
     */
    @RequestMapping("/create/text")
    public String createTextView(){
        return "order/createTextOrder";
    }

    /**
     * 显示口语类下单页面
     * @return
     */
    @RequestMapping("/create/oral")
    public String createOralView(){
        return "order/createOralOrder";
    }

    /**
     * 提交订单
     * @return
     */
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<String> submitOrder(){
        ResponseData<String> resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        /*try {
            IOrderSubmissionSV orderSubmissionSV = DubboConsumerFactory.getService(IOrderSubmissionSV.class);
            OrderSubmissionRequest subReq = new OrderSubmissionRequest();
            OrderSubmissionResponse subRes = orderSubmissionSV.orderSubmission(subReq);
            ResponseHeader resHeader = subRes==null?null:subRes.getResponseHeader();
            //如果返回值为空,或返回信息中包含错误信息,则抛出异常
            if (subRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){

            }
        }catch (BusinessException e){
            LOGGER.error("提交订单失败:",e);
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,rb.getMessage(""));
        }*/

        //TODO... 虚拟数据
        OrderSubmissionResponse subRes = new OrderSubmissionResponse();
        resData.setData(subRes.getOrderId()+"");//返回订单信息
        return resData;
    }
}
