package com.ai.yc.protal.web.controller;

import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import com.alibaba.fastjson.JSONArray;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
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

//    @Value("${yeekit.translate.url}")
    private String SERVER_URL="http://api.yeekit.com/dotranslate.php";

    //语言检测
//    @Value("${yee.detection.url}")
    private String TRANSLAN_URL="http://translateport.yeekit.com:9006/detection";
//    @Value("${yeekit.translate.appkid}")
    private String APP_KID = "58105e00cabc3";
//    @Value("${yeekit.translate.appkey}")
    private String APP_KEY = "53eeb0bb6c1b613ab361a4f8057b2bd9";
    
   

    @ResponseBody
    @RequestMapping(value = "/mt")  
    public InvokeResult mt(String from, String to, String text) {  
        Map<String,String> result = new HashMap<>();
        try {
            verifyTranslateLan(from,text);
            Map<String,Object> postParams = new HashMap<>();
            postParams.put("from",from);//源语言
            postParams.put("to",to);//目标语言
            postParams.put("app_kid",APP_KID);//授权APP ID
            postParams.put("app_key",APP_KEY);//授权APP KEY
            postParams.put("text", URLEncoder.encode(text,"UTF-8"));//待翻译文本,UTF-8编码
            String resultStr = HttpUtil.doPost(SERVER_URL,postParams);
            JSONArray translateds = JSON.parseObject(resultStr)
                    .getJSONArray("translation")
                    .getJSONObject(0).getJSONArray("translated");
            StringBuffer sb = new StringBuffer();
            for (int i=0;i<translateds.size();i++) {
                JSONObject jsonObject = translateds.getJSONObject(i);
                sb.append(jsonObject.getString("text").replaceAll("\\s*", ""));
            }
            LOGGER.info("response:\r\n"+sb.toString());
            result.put("text",URLDecoder.decode(sb.toString(),"UTF-8"));
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
     * 验证传入的text和lan是否相符
     * @param lan 语言
     * @param text 文本
     * @return
     * @author mimw
     */
    @ResponseBody
    @RequestMapping(value = "/verifyTranslateLan")  
    public boolean verifyTranslateLan(String lan, String text) {  
        try {
            String resultStr = HttpUtil.doPost(TRANSLAN_URL, text);
            
            JSONObject translated = JSON.parseObject(resultStr);
            LOGGER.info(translated.toJSONString());
            if (translated.getString("result").equalsIgnoreCase(lan)) {
                return false;
            }
        } catch (Exception e) {
            LOGGER.error(e.getMessage());
        }
      
        return true;
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
            String resultStr = HttpUtil.doPost(TRANSLAN_URL, text);
            
            JSONObject translated = JSON.parseObject(resultStr);
           
            if (!translated.getInteger("errorCode").equals(0)) {
                resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,"");
            }
            lan = translated.getString("result");
        } catch (Exception e) {
            LOGGER.error(e.getMessage());
           // resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,"");
            //TODO 地址不通 弄个假数据
        }
      
        resData.setData(lan);
        return resData;
    }
}
