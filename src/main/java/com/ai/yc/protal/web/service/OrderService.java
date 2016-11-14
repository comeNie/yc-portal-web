package com.ai.yc.protal.web.service;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.order.api.orderpay.interfaces.IOrderPayProcessedResultSV;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultBaseInfo;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultFeeInfo;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultProdInfo;
import com.ai.yc.order.api.orderpay.param.OrderPayProcessedResultRequest;
import com.ai.yc.protal.web.constants.OrderConstants;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;

/**
 * 订单相关服务
 * Created by liutong on 16/11/14.
 */
@Service
public class OrderService {

    /**
     * 订单支付处理
     * @param userId 用户ID
     * @param orderId 订单ID
     * @param orderType 订单类型 企业/个人
     * @param totalFee 订单金额
     * @param payStyle 支付方式,对应支付机构
     * @param outOrderId 支付流水号
     * @param notifyTime 支付时间
     */
    public void orderPayProcessResult(
            String userId,long orderId,String orderType,long totalFee,
            String payStyle,String outOrderId,Timestamp notifyTime){
        //TODO...若是企业订单,需要查询企业信息,一阶段暂不实现
        OrderPayProcessedResultRequest payResultReq = new OrderPayProcessedResultRequest();
        //基本信息
        OrderPayProcessedResultBaseInfo payResultReqBase = new OrderPayProcessedResultBaseInfo();
        payResultReq.setBaseInfo(payResultReqBase);
        payResultReqBase.setOrderId(orderId);
        payResultReqBase.setOrderType(orderType);
        payResultReqBase.setUserId(userId);
        //用户类型
        if (OrderConstants.ORDER_TYPE_PERSON.equals(orderType)) {
            payResultReqBase.setUserType(OrderConstants.USER_TYPE_PERSON);
        }//TODO... 缺少代理人的检查,后续二阶段实现
        else if (OrderConstants.ORDER_TYPE_ENTERPRISE.equals(orderType)){
            payResultReqBase.setUserType(OrderConstants.USER_TYPE_ENTERPRISE);
            //添加企业ID
        }
        //费用信息
        OrderPayProcessedResultFeeInfo payResultFeeInfo = new OrderPayProcessedResultFeeInfo();
        payResultReq.setFeeInfo(payResultFeeInfo);
        payResultFeeInfo.setPayStyle(payStyle);//支付机构
        payResultFeeInfo.setTotalFee(totalFee);
        payResultFeeInfo.setExternalId(outOrderId);
        payResultFeeInfo.setPayTime(notifyTime);
        //产品信息
        OrderPayProcessedResultProdInfo payResultProdInfo = new OrderPayProcessedResultProdInfo();
        payResultReq.setProdInfo(payResultProdInfo);
        payResultProdInfo.setStateTime(notifyTime);
        IOrderPayProcessedResultSV payResultSv= DubboConsumerFactory.getService(IOrderPayProcessedResultSV.class);
        payResultSv.orderPayProcessedResult(payResultReq);
    }
}
