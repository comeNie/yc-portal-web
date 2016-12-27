package com.ai.yc.protal.web.controller;

import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.protal.web.service.YeekitService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.opt.sdk.web.model.ResponseData;

import java.io.UnsupportedEncodingException;


/**
 * 译库机器翻译
 */
@Controller
public class YeekitController {
    private static final Logger LOGGER = LoggerFactory.getLogger(YeekitController.class);

    @Autowired
    YeekitService yeekitService;
    @Autowired
    ResWebBundle rb;


    /**
     * 机器翻译
     * @param from
     * @param to
     * @param text
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/mt")  
    public ResponseData<String> mt(String from, String to, String text) {  
        ResponseData<String> resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try {
            String fromTmp = from;
            //判断是否是自动检测
            if ("auto".equals(from)) {
                fromTmp = yeekitService.detection(text);
            }
            String result = yeekitService.dotranslate(fromTmp,to,text);
            if (result.startsWith("error:")) {
                //机器返回错误
                resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, rb.getMessage(""));
            }
            resData.setData(result);
        } catch (Exception e) {
            LOGGER.error("机器翻译失败：", e);
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, rb.getMessage(""));
        }
        
        return resData;
    }
    
    /**
     * 机器翻译语言检测
     * @param text 文本
     * @return 
     * @author mimw
     */
    @ResponseBody
    @RequestMapping(value = "/translateLan")  
    public ResponseData<String> translateLan(String text) {  
        ResponseData<String> resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        //TODO 
        String lan;
        try {
            lan = yeekitService.detection(text);
            resData.setData(lan);
        } catch (UnsupportedEncodingException e) {
            LOGGER.error("",e.getMessage());
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "FAIL");
        }
        //TODO
//        resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
//        resData.setData(lan);
        return resData;
    }
  
}
