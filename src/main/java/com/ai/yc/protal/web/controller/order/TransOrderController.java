package com.ai.yc.protal.web.controller.order;

import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.common.api.cachekey.model.SysDomain;
import com.ai.yc.common.api.cachekey.model.SysPurpose;
import com.ai.yc.order.api.orderdetails.interfaces.IQueryOrderDetailsSV;
import com.ai.yc.order.api.orderdetails.param.QueryOrderDetailsResponse;
import com.ai.yc.order.api.orderquery.interfaces.IOrderQuerySV;
import com.ai.yc.order.api.orderquery.param.OrdOrderVo;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountResponse;
import com.ai.yc.order.api.orderquery.param.QueryOrderRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrderRsponse;
import com.ai.yc.protal.web.service.CacheServcie;
import com.ai.yc.protal.web.utils.UserUtil;
import com.alibaba.fastjson.JSONObject;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;


/**
 * Created by liutong on 16/11/15.
 */
@Controller
@RequestMapping("/p/trans/order")
public class TransOrderController {
    private static final Logger LOGGER = LoggerFactory.getLogger(TransOrderController.class);
            
    @Autowired
    private CacheServcie cacheServcie;
    @Autowired
    ResWebBundle rb;
    
    /**
     * 译员订单,订单列表
     * @return
     */
    @RequestMapping("/list/view")
    public String orderListView(Model uiModel){
        List<SysDomain> domainList = cacheServcie.getAllDomain(rb.getDefaultLocale());
        List<SysPurpose> purpostList = cacheServcie.getAllPurpose(rb.getDefaultLocale());
        
        uiModel.addAttribute("domainList", domainList); //领域
        uiModel.addAttribute("purpostList", purpostList); //用途
        
        String userId = UserUtil.getUserId();
        IOrderQuerySV iOrderQuerySV = DubboConsumerFactory.getService(IOrderQuerySV.class);
        QueryOrdCountRequest ordCountReq = new QueryOrdCountRequest();
        ordCountReq.setUserId(userId);
        
        // 21：已领取
        ordCountReq.setDisplayFlag("21");
        QueryOrdCountResponse ordCountRes = iOrderQuerySV.queryOrderCount(ordCountReq);
        uiModel.addAttribute("ReceivedCount", ordCountRes.getCountNumber());
        
        //211：已分配 
        ordCountReq.setDisplayFlag("211");
        ordCountRes = iOrderQuerySV.queryOrderCount(ordCountReq);
        uiModel.addAttribute("AssignedCount", ordCountRes.getCountNumber());
        
        //23：翻译中 
        ordCountReq.setDisplayFlag("23");
        ordCountRes = iOrderQuerySV.queryOrderCount(ordCountReq);
        uiModel.addAttribute("TranteCount", ordCountRes.getCountNumber());
        
        return "transOrder/orderList";
    }
    
    /**
     * 译员订单 显示订单详情
     * @param orderId
     * @param uiModel
     * @return
     */
    @RequestMapping("/{orderId}")
    public String orderInfoView(@PathVariable("orderId") String orderId, Model uiModel){
        //TODO 跳转错误页面
        if (StringUtils.isEmpty(orderId)) {
        }
        
        try {
            IQueryOrderDetailsSV iQueryOrderDetailsSV = DubboConsumerFactory.getService(IQueryOrderDetailsSV.class);
            QueryOrderDetailsResponse orderDetailsRes = iQueryOrderDetailsSV.queryOrderDetails(Long.valueOf(orderId));
            ResponseHeader resHeader = orderDetailsRes.getResponseHeader();
            LOGGER.info("订单详细信息 ：" + JSONObject.toJSONString(orderDetailsRes));
            //如果返回值为空,或返回信息中包含错误信息,返回失败
            if (orderDetailsRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
            }
//  getProdLevels  返回的是id,前台把 id转成对应的 中英文文字。    
//          ("100110", "陪同翻译");("100120", "交替传译");("100130", "同声翻译");
//          ("100210", "标准级");("100220", "专业级");("100230", "出版级");
            uiModel.addAttribute("OrderDetails", orderDetailsRes);
        } catch (Exception e) {
            LOGGER.error("查询订单详情失败:",e);
        }
        return "transOrder/orderInfo";
    }
    
}
