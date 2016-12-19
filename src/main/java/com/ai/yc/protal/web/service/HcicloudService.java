package com.ai.yc.protal.web.service;

import com.ai.yc.protal.web.utils.MD5Util;
import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.*;
import java.text.SimpleDateFormat;
import java.util.Date;


@Service
public class HcicloudService {
    private static final Logger LOGGER = LoggerFactory.getLogger(HcicloudService.class);

    @Value("#{hciSetting['hcicloud.appkey']}")
    private String appkey;
    @Value("#{hciSetting['hcicloud.devkey']}")
    private String devkey;
    @Value("#{hciSetting['hcicloud.url']}")
    private String serverUrl;

    private static final int FILE_BUFFER = 1048576; //1024*1024;
    private static final  byte[] WAVHEAD8K = {82, 73, 70, 70, 2, 70, 0, 0, 87, 65, 86, 69, 102, 109, 116, 32, 16, 0, 0, 0, 1, 0, 1, 0, 64, 31, 0, 0, -128, 62, 0, 0, 2, 0, 16, 0, 100, 97, 116, 97, -34, 69, 0, 0};
    private static final  byte[] WAVHEAD16K = {82, 73, 70, 70, -102, -24, 0, 0, 87, 65, 86, 69, 102, 109, 116, 32, 16, 0, 0, 0, 1, 0, 1, 0, -128, 62, 0, 0, 0, 125, 0, 0, 2, 0, 16, 0, 100, 97, 116, 97, 118, -24, 0, 0};

    @Autowired
    private CloseableHttpClient client;

    /**
     * 语音合成
     * @param agent 浏览器
     * @param lan 语言
     * @param text 合成文本
     * @return 合成音频数据流
     */
    public byte[] text2audio(String agent,String lan, String text) {
        String browserName = getBrowserName(agent);
        LOGGER.info(browserName);

        String config = "capkey=";
        String audioformat;

        if ("zh".equals(lan)) {
            config += "tts.cloud.wangjing";
        } else if("en".equals(lan)) {
            config += "tts.cloud.serena";
        } else if("fr".equals(lan)) {// 法语
            config += "tts.cloud.thomas";
        } else if("de".equals(lan)) {// 德语
            config += "tts.cloud.anna";
        } else if("pt".equals(lan)) {//葡萄牙
            config += "tts.cloud.vera";
//        } else if(lan.equals("pl")) { //波兰
//            
//        } else if(lan.equals("fi")) { //芬兰
//            
        } else if("es".equals(lan)) { //西班牙
            config += "tts.cloud.diego";
        } else if("ru".equals(lan)) { //俄语
            config += "tts.cloud.milena";
        }
        
        if ("firefox".equals(browserName) || "opera".equals(browserName)) {
            audioformat = ",audioformat=pcm8k16bit";
        } else {
            audioformat = ",audioformat=mp3_16";
        }
        config += audioformat;

        HttpPost post = new HttpPost(serverUrl);
        HttpResponse ttsResponse = null;

        SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date=new Date();
        String dataStr = dateFormater.format(date);

        post.setHeader("x-app-key", appkey);
        post.setHeader("x-sdk-version", "3.6");
        post.setHeader("x-request-date", dateFormater.format(date));
        post.setHeader("x-task-config", config);
        post.setHeader("x-session-key", MD5Util.MD5(dataStr + devkey));
        post.setHeader("x-udid", "101:1234567890");

//        System.out.println(MD5Util.MD5(dataStr + DEVKEY ));

        StringEntity param =new StringEntity(text,  "UTF-8");// 构造请求数据
        post.setEntity(param);
        byte[] outByte = null;
        try {
            long httpStart = System.currentTimeMillis();
            LOGGER.info("开始httpClient,当前时间戳:{}",httpStart);
            ttsResponse = client.execute(post);
            long httpEnd = System.currentTimeMillis();
            LOGGER.info("结束httpClient,当前时间戳:{},用时:{}",httpEnd,(httpEnd-httpStart));
            HttpEntity entity = ttsResponse.getEntity();
            //写入文件
            outByte = intoFile(entity.getContent(),audioformat);
        } catch (Exception e) {
            LOGGER.error("",e);
        } finally {
            if (ttsResponse != null) {
                try {
                    EntityUtils.consume(ttsResponse.getEntity());
                } catch (Exception e) {
                    LOGGER.error("",e);
                }
            }
        }
        return outByte;
    }
    /**
     * 写入文件中
     * @param inputStream 音频流
     * @param audioFormat 音频格式
     * @return 最终音频流
     */
    private byte[] intoFile(InputStream inputStream, String audioFormat){
        byte[] audioByte = null;
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            byte[] buffer = new byte[FILE_BUFFER];
            int lens;
            while ((lens = inputStream.read(buffer)) > -1 ) {
                baos.write(buffer, 0, lens);
            }
            baos.flush();

            String resStr = new String(baos.toByteArray(), "utf-8");
            String splitStr = "</ResponseInfo>";
            String[] temp = resStr.split(splitStr);
            String resXml = temp[0] + splitStr;
            LOGGER.info(resXml);

            //xml byte长度
            int offset = resXml.getBytes("utf-8").length;
            InputStream is = new ByteArrayInputStream(baos.toByteArray());
            //丢掉xml内容
            is.skip(offset);

//            FileOutputStream fos = new FileOutputStream(file.getAbsolutePath());
            ByteArrayOutputStream swapStream = new ByteArrayOutputStream();
            //pcm8k16bit  写入wav头
            if (audioFormat.contains("pcm8k16bit")) {
//                fos.write(WAVHEAD8K);
                swapStream.write(WAVHEAD8K);
            } else if(audioFormat.contains("pcm16k16bit")) {
                swapStream.write(WAVHEAD16K);
            }

            byte[] b = new byte[FILE_BUFFER];
            int len;
            while((len = is.read(b)) != -1)
            {
//                fos.write(b,0,len);
                swapStream.write(b, 0, len);
            }
            audioByte = swapStream.toByteArray();
            is.close();
//            fos.close();
        } catch (Exception e) {
            LOGGER.error("",e);
        }
        return audioByte;
    }

    /**
     *  根据agent判断前端浏览器
     * @param agent 浏览器信息
     * @return 浏览器名称
     */
    private String getBrowserName(String agent) {
        String browsName;
        if(agent.indexOf("msie 7")>0){
            browsName =  "ie7";
        }else if(agent.indexOf("msie 8")>0){
            browsName = "ie8";
        }else if(agent.indexOf("msie 9")>0){
            browsName = "ie9";
        }else if(agent.indexOf("msie 10")>0){
            browsName = "ie10";
        }else if(agent.indexOf("msie")>0){
            browsName = "ie";
        }else if(agent.indexOf("opera")>0){
            browsName = "opera";
        }else if(agent.indexOf("firefox")>0){
            browsName = "firefox";
        }else if(agent.indexOf("webkit")>0){
            browsName = "webkit";
        }else if(agent.indexOf("gecko")>0 && agent.indexOf("rv:11")>0){
            browsName = "ie11";
        }else{
            browsName =   "Others";
        }

        return browsName;
    }
}
