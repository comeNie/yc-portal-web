package com.ai.yc.protal.web.controller;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.yc.protal.web.utils.HttpUtil;
import com.ai.yc.protal.web.common.InvokeResult;
import com.ai.yc.protal.web.exception.HttpStatusException;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

@Controller
public class YeekitController {
    private static final Logger LOGGER = LoggerFactory.getLogger(YeekitController.class);
    public static final String SERVER_URL = "http://api.yeekit.com/dotranslate.php";
    public static final String APP_KID = "58105e00cabc3";
    public static final String APP_KEY = "53eeb0bb6c1b613ab361a4f8057b2bd9";

    @ResponseBody
    @RequestMapping(value = "/mt")  
    public InvokeResult mt(String from, String to, String text) {  
        Map<String,String> result = new HashMap<>();
        try {
            Map<String,Object> postParams = new HashMap<>();
            postParams.put("from",from);//源语言
            postParams.put("to",to);//目标语言
            postParams.put("app_kid",APP_KID);//授权APP ID
            postParams.put("app_key",APP_KEY);//授权APP KEY
            postParams.put("text", URLEncoder.encode(text,"UTF-8"));//待翻译文本,UTF-8编码
            String resultStr = HttpUtil.doPost(SERVER_URL,postParams);
            JSONObject translated0 = JSON.parseObject(resultStr)
                    .getJSONArray("translation").getJSONObject(0).getJSONArray("translated").getJSONObject(0);

            result.put("srcTokenized",translated0.getString("src-tokenized").replaceAll("\\s*", ""));
            result.put("text",translated0.getString("text").replaceAll("\\s*", ""));
        } catch (IOException e) {
            e.printStackTrace();
            return InvokeResult.failure("失败");
        } catch (HttpStatusException e) {
            e.printStackTrace();
            return InvokeResult.failure("网络异常");
        }
        
        return InvokeResult.dataSuccess(result);
    }  
}
