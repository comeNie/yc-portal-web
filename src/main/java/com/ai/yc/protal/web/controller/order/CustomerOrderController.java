package com.ai.yc.protal.web.controller.order;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.order.api.orderfee.interfaces.IOrderFeeQuerySV;
import com.ai.yc.order.api.orderfee.param.OrderFeeInfo;
import com.ai.yc.order.api.orderfee.param.OrderFeeQueryRequest;
import com.ai.yc.order.api.orderfee.param.OrderFeeQueryResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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
    @RequestMapping("/payOrder/{orderId}")
    public String createTextView(@PathVariable("orderId") Long orderId,Model uiModel){
        //TODO... 模拟数据
//        IOrderFeeQuerySV iOrderFeeQuerySV = DubboConsumerFactory.getService(IOrderFeeQuerySV.class);
//        OrderFeeQueryRequest feeQueryRequest = new OrderFeeQueryRequest();
//        feeQueryRequest.setOrderId(orderId);
//        OrderFeeQueryResponse feeQueryResponse = iOrderFeeQuerySV.orderFeeQuery(feeQueryRequest);
        OrderFeeQueryResponse feeQueryResponse = new OrderFeeQueryResponse();
        OrderFeeInfo orderFeeInfo = new OrderFeeInfo();
        feeQueryResponse.setOrderFeeInfo(orderFeeInfo);
        //模拟人民币
        if (orderId.equals(123201245464l)) {
            orderFeeInfo.setCurrencyUnit("1");
        }//美元
        else {
            orderFeeInfo.setCurrencyUnit("2");
        }
        //总费用
        orderFeeInfo.setTotalFee(10000l);
        //获取订单价格,币种
        //订单编号
        uiModel.addAttribute("orderId",orderId);
        //订单信息
        uiModel.addAttribute("orderFee",feeQueryResponse.getOrderFeeInfo());
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
