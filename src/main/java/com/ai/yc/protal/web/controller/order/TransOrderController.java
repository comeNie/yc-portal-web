package com.ai.yc.protal.web.controller.order;

import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.protal.web.service.CacheServcie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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

}
