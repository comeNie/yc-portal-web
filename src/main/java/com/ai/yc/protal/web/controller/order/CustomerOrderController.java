package com.ai.yc.protal.web.controller.order;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.order.api.ordersubmission.interfaces.IOrderSubmissionSV;
import com.alibaba.fastjson.JSONObject;

/**
 * 客户订单
 * Created by liutong on 16/11/3.
 */
@Controller
@RequestMapping("/p/customer/order")
public class CustomerOrderController {
    private static final Logger LOGGER = LoggerFactory.getLogger(CustomerOrderController.class);
    
    /**
     * 我的订单,订单列表
     * @return
     */
    @RequestMapping("/list/view")
    public String orderListView(){
        return "customerOrder/orderList";
    }

    /**
     * 支付页面
     * @return
     */
    @RequestMapping("/payOrder")
    public String createTextView(String orderId,  Model uiModel){
        //获取订单价格,币种
        
        //TODO 暂时关闭
//        try {
//            IQueryOrderDetailsSV iQueryOrderDetailsSV =  DubboConsumerFactory.getService(IQueryOrderDetailsSV.class);
//            QueryOrderDetailsResponse orderDetailsRes = iQueryOrderDetailsSV.queryOrderDetails(Long.valueOf(orderId));
//            
//            uiModel.addAttribute("OrderDetails", orderDetailsRes);
//        } catch (Exception e) {
//            LOGGER.error("查询订单详情失败:",e);
//        }
        
        String string = "{  "
                + "'orderId': 10086,"
                + "'orderFee': {'currentcyUnit': '1', 'totalFee': 100, 'discountFee': 10, 'paidFee': 90}"
                + "}";
      
        uiModel.addAttribute("OrderDetails", JSONObject.parse(string));
        return "order/payOrder";
    }

    /**
     * 显示订单详情
     * @param orderId
     * @param uiModel
     * @return
     */
    @RequestMapping("/{orderId}")
    public String orderInfoView(@PathVariable("orderId") String orderId, Model uiModel){
        //TODO... 查询订单详情
        return "customerOrder/orderInfo";
    }
}
