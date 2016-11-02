package com.ai.yc.protal.web.controller;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.StringEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ai.yc.protal.web.utils.HttpUtil;
import com.ai.yc.protal.web.utils.MD5Util;
import com.ai.yc.protal.web.common.InvokeResult;
import com.ai.yc.protal.web.exception.HttpStatusException;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;


/**
 * Created by liutong on 16/10/31.
 */
@Controller
@RequestMapping ( "/Hcicloud" )
public class HcicloudController {
    private static final Logger LOGGER = LoggerFactory.getLogger(HcicloudController.class);
    public static File file = new File("tts.wav");
    private static String APPKEY = "ad5d5421";
    private static String DEVKEY = "bca4b0015b309b76301bb10efdf90561";
    private static String SERVER_URL = "http://test.api.hcicloud.com:8880/tts/SynthText";
    byte[] WAVHEAD8K = {82, 73, 70, 70, 2, 70, 0, 0, 87, 65, 86, 69, 102, 109, 116, 32, 16, 0, 0, 0, 1, 0, 1, 0, 64, 31, 0, 0, -128, 62, 0, 0, 2, 0, 16, 0, 100, 97, 116, 97, -34, 69, 0, 0};
    
    @ResponseBody
    @RequestMapping(value = "/text2audio")  
    public ModelAndView  text2audio(String lan, String text, HttpServletRequest request,
            HttpServletResponse response) throws Exception {
        String agent = request.getHeader("User-Agent").toLowerCase();
        String browserName = getBrowserName(agent);
        LOGGER.info(browserName);
        
        String config = "";
        String audioformat="";
        if (lan.equals("zh")) {
            config += "capkey=tts.cloud.wangjing";
        } else if(lan.equals("en")) {
            config += "capkey=tts.cloud.serena";
        }//TODO 其他语言
        
        if (browserName.equals("firefox") || browserName.equals("opera")) {
            audioformat = ",audioformat=pcm8k16bit";
        } else {
            audioformat = ",audioformat=mp3_16";
        }
        config += audioformat;
        
        CloseableHttpClient client = HttpClients.createDefault();  
        HttpPost post = new HttpPost(SERVER_URL);
        CloseableHttpResponse ttsResponse = null;
        
        SimpleDateFormat dateFormater = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date=new Date();
        String dataStr = dateFormater.format(date);
        System.out.println(dataStr);
        
        post.setHeader("x-app-key", APPKEY);
        post.setHeader("x-sdk-version", "3.6");
        post.setHeader("x-request-date", dateFormater.format(date));
        post.setHeader("x-task-config", config);
        post.setHeader("x-session-key", MD5Util.MD5(dataStr + DEVKEY ));
        post.setHeader("x-udid", "101:1234567890"); 
        
        System.out.println(MD5Util.MD5(dataStr + DEVKEY ));
        
        StringEntity  param =new StringEntity(text,  "UTF-8");// 构造请求数据
        post.setEntity(param);
        try {
            long httpStart = System.currentTimeMillis();
            LOGGER.info("开始httpClient,当前时间戳:{}",httpStart);
            ttsResponse = client.execute(post);
            long httpEnd = System.currentTimeMillis();
            LOGGER.info("结束httpClient,当前时间戳:{},用时:{}",httpEnd,(httpEnd-httpStart));
            HttpEntity entity = ttsResponse.getEntity();

            //写入文件
            byte[] audioByte = intoFile(file,entity.getContent(),audioformat);
            
            OutputStream os = response.getOutputStream();
            response.addHeader("Accept-Ranges", "bytes");
            response.addHeader("Content-Length", audioByte.length + "");
            response.addHeader("Content-Type", "audio/mpeg;charset=UTF-8");
            os.write(audioByte);
            os.close();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            if (ttsResponse != null) {
                try {
                    EntityUtils.consume(ttsResponse.getEntity());
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }  
    
    private byte[] intoFile(File file,InputStream inputStream, String audioformat){
        byte[] audioByte = null;
        try {
            if (!file.exists())
                file.createNewFile();
            System.out.println(file.getAbsolutePath());
          
            ByteArrayOutputStream baos = new ByteArrayOutputStream();  
            InputStream input = inputStream;
            byte[] buffer = new byte[1024*1024];  
            int lens;  
            while ((lens = input.read(buffer)) > -1 ) {  
                baos.write(buffer, 0, lens);  
            }  
            baos.flush();  
            
            String resStr = new String(baos.toByteArray(), "utf-8");
            String splitStr = "</ResponseInfo>";
            String[] temp = resStr.split(splitStr);
            String resXml = temp[0] + splitStr;
            LOGGER.info(resXml);
            
            //xml byte长度
            int offset = resXml.getBytes().length;

            InputStream is = new ByteArrayInputStream(baos.toByteArray());
            //丢掉xml内容
            is.skip(offset);
            FileOutputStream fos = new FileOutputStream(file.getAbsolutePath());
            
            //pcm8k16bit  写入wav头
            if (audioformat.equals("pcm8k16bit")) {
                fos.write(WAVHEAD8K);
            }

            ByteArrayOutputStream swapStream = new ByteArrayOutputStream(); 
            byte[] b = new byte[1024*1024];
            int len = 0;
            while((len = is.read(b)) != -1)
            {
                fos.write(b,0,len);
                swapStream.write(b, 0, len); 
            }
            audioByte = swapStream.toByteArray();
            is.close();
            fos.close();
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return audioByte;
    }
    
    private String getBrowserName(String agent) {
        if(agent.indexOf("msie 7")>0){
         return "ie7";
        }else if(agent.indexOf("msie 8")>0){
         return "ie8";
        }else if(agent.indexOf("msie 9")>0){
         return "ie9";
        }else if(agent.indexOf("msie 10")>0){
         return "ie10";
        }else if(agent.indexOf("msie")>0){
         return "ie";
        }else if(agent.indexOf("opera")>0){
         return "opera";
        }else if(agent.indexOf("firefox")>0){
         return "firefox";
        }else if(agent.indexOf("webkit")>0){
         return "webkit";
        }else if(agent.indexOf("gecko")>0 && agent.indexOf("rv:11")>0){
         return "ie11";
        }else{
         return "Others";
        }
      }
}
