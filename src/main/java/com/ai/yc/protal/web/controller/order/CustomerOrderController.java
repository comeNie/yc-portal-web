package com.ai.yc.protal.web.controller.order;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * 客户订单
 * Created by liutong on 16/11/3.
 */
@Controller
@RequestMapping("/p/customer/order")
public class CustomerOrderController {

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
    public String createTextView(String orderId){
        //获取订单价格,币种
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
