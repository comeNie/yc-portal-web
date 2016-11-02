package com.ai.yc.protal.web.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class DemoController {
    @RequestMapping(value = "/demo")  
    public String  text2audio() {
        return "demo";
    }
}
