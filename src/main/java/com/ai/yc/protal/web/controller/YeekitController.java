package com.ai.yc.protal.web.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import com.ai.yc.protal.web.service.YeekitService;
import com.alibaba.fastjson.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.yc.protal.web.utils.HttpUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.yc.order.api.ordersubmission.param.OrderSubmissionResponse;
import com.ai.yc.protal.web.common.InvokeResult;
import com.ai.yc.protal.web.exception.HttpStatusException;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/**
 * 译库机器翻译
 */
@Controller
public class YeekitController {
    private static final Logger LOGGER = LoggerFactory.getLogger(YeekitController.class);

    @Autowired
    YeekitService yeekitService;


    /**
     * 机器翻译
     * @param from
     * @param to
     * @param text
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "/mt")  
    public InvokeResult mt(String from, String to, String text) {  
        Map<String,String> result = new HashMap<>();
        try {
            String fromTmp = from;
            //判断是否是自动检测
            if ("auto".equals(from))
                fromTmp = yeekitService.detection(text);
            result.put("text",yeekitService.dotranslate(fromTmp,to,text));
        } catch (IOException e) {
            e.printStackTrace();
            return InvokeResult.failure("失败");
        } catch (HttpStatusException e) {
            e.printStackTrace();
            return InvokeResult.failure("网络异常");
        }
        
        return InvokeResult.dataSuccess(result);
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
        String lan = "en";
        try {
            lan = yeekitService.detection(text);
        } catch (Exception e) {
            LOGGER.error(e.getMessage());
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,"");
        }
      
        resData.setData(lan);
        return resData;
    }
}
