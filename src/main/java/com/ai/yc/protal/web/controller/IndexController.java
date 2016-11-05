package com.ai.yc.protal.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by liutong on 16/11/5.
 */
@Controller
public class IndexController {

    /**
     * 首页
     * @return
     */
    @RequestMapping("/home")
    public String indexView(){
        return "/home";
    }
}
