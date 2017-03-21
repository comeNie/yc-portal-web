package com.ai.yc.protal.web.service;

import com.ai.opt.base.exception.BusinessException;
import com.ai.yc.protal.web.exception.HttpStatusException;
import com.ai.yc.protal.web.utils.HttpUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.http.impl.client.CloseableHttpClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by liutong on 16/11/10.
 */
@Service
public class YeekitService {
    private static final Logger LOGGER = LoggerFactory.getLogger(YeekitService.class);

    //语言检测
    @Value("#{yeeSetting['yee.detection.url']}")
    private String TRANSLAN_URL;

    //机器翻译
    @Value("#{yeeSetting['yeekit.translate.url']}")
    private String SERVER_URL;
    @Value("#{yeeSetting['yeekit.translate.appkid']}")
    private String APP_KID;
    @Value("#{yeeSetting['yeekit.translate.appkey']}")
    private String APP_KEY ;
    @Autowired
    private CloseableHttpClient client;
    /**
     * 语言检查出现错误
     */
    public static final String DETECTION_FAIL = "detectionFail";

    /**
     * 语言检查出现错误
     */
    public static final String TRAINNS_FAIL = "trainFail";

    /**
     * 进行机器翻译
     * @param from
     * @param to
     * @param text
     * @return
     */
    public String dotranslate(String from, String to, String text)
            throws BusinessException,IOException, HttpStatusException {
        Map<String, Object>  postParams =new HashMap();
//        postParams.put("srcl", from);// 源语言
//        postParams.put("tgtl", to);// 目标语言
        postParams.put("from", from);// 源语言
        postParams.put("to", to);// 目标语言
        postParams.put("app_kid", APP_KID);// 授权APP ID
        postParams.put("app_key", APP_KEY);// 授权APP KEY
//        postParams.put("detoken", true);
        postParams.put("align", true);
        postParams.put("text", text);// 待翻译文本,UTF-8编码
        String resultStr="";
        try {
            LOGGER.info("机器翻译入参:", JSONObject.toJSONString(postParams));
//            resultStr = HttpsUtil.HttpsPost(SERVER_URL, postParams.toString(), "UTF-8");
            resultStr = HttpUtil.doPost(client, SERVER_URL, postParams);
            if(resultStr!=null) {
                resultStr = resultStr.replaceAll("\\s*\r\n","").trim();
            }
            LOGGER.info("dotranslate result:{}", resultStr);

//            //失败 解析为json异常
            if(resultStr.substring(1).startsWith("error")) {
                LOGGER.error("机器翻译失败");
                throw new BusinessException(TRAINNS_FAIL,"The detection is fail.");
            }
        }  catch (Exception e) {
            LOGGER.error("机器翻译失败:", e);
            throw new BusinessException(TRAINNS_FAIL,"The detection is fail.");
        }

        return resultStr;

//            return  URLDecoder.decode(resultStr, "UTF-8");
    }

    /**
     * 进行机器翻译，直接返回译文新
     * @param from
     * @param to
     * @param text
     * @return
     */
    public String doTranslateNoFormat(String from, String to, String text)
            throws IOException, HttpStatusException {
        StringBuffer sb = new StringBuffer();
        try {
            String resultStr = dotranslate(from, to, text);
            JSONArray translateds = JSON.parseObject(resultStr).getJSONArray("translation")
                    .getJSONObject(0).getJSONArray("translated");
            for (int i = 0; i < translateds.size(); i++) {
                JSONObject jsonObject = translateds.getJSONObject(i);
                sb.append(jsonObject.getString("text"));
            }
            LOGGER.info("response:\r\n" + sb.toString());
        } catch (BusinessException e){
            if("zh".equals(from)){
                sb.append("****翻译失败");
            }else {
                sb.append("****"+doTranslateNoFormat("zh",to,"翻译失败"));
            }
        }
        return sb.toString();
    }

    /**
     * 检测内容的语言
     * @param text
     * @return
     */
    public String detection(String text) throws UnsupportedEncodingException {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("text",URLEncoder.encode(text,"UTF-8"));
        String resultStr = HttpUtil.doGet(client,TRANSLAN_URL, params);
        LOGGER.info("detection result:{}",resultStr);
        JSONObject translated = JSON.parseObject(resultStr);
        //返回失败信息
        if (!translated.getInteger("errorCode").equals(0)) {
            LOGGER.error("detection text is error.\r\n",resultStr);
            throw new BusinessException(DETECTION_FAIL,"The detection is fail.");
        }
        //获取语言
        return translated.getString("result");
    }
}
