package com.ai.yc.protal.web.controller.order;

import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.common.api.cachekey.model.SysDomain;
import com.ai.yc.common.api.cachekey.model.SysPurpose;
import com.ai.yc.protal.web.service.CacheServcie;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * Created by liutong on 16/11/15.
 */
@Controller
@RequestMapping("/p/trans/order")
public class TransOrderController {
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
        
        uiModel.addAttribute("domainList", domainList);
        uiModel.addAttribute("purpostList", purpostList);
        
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
        return "transOrder/orderInfo";
    }

}
