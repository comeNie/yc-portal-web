package com.ai.yc.protal.web.controller;

import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.components.dss.DSSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.paas.ipaas.dss.base.interfaces.IDSSClient;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.LoginConstants;
import com.ai.yc.protal.web.service.YeekitService;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.protal.web.utils.WordUtil;
import com.ai.yc.user.api.usercollectiontranslation.interfaces.IYCUserCollectionSV;
import com.ai.yc.user.api.usercollectiontranslation.param.UserCollectionInfo;
import com.ai.yc.user.api.usercollectiontranslation.param.UserCollectionInfoListResponse;
import com.ai.yc.user.api.usercollectiontranslation.param.UserCollectionPageInfoRequest;
import com.alibaba.dubbo.rpc.protocol.dubbo.DubboCodec;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.DocumentEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.opt.sdk.web.model.ResponseData;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;

import static com.ai.yc.protal.web.utils.WordUtil.readWord;
import static org.apache.hadoop.io.WritableUtils.toByteArray;


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
    private String textContent;

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
            String result = null;
            //若用户已登录,则查询译文信息
            if(UserUtil.getSsoUser() != null){
                result = queryCollection(from,to,text);
            }
            //若没查询都收藏译文，则进行机器翻译
            if (StringUtils.isBlank(result)) {
                result = yeekitService.dotranslate(fromTmp, to, text);
            }
            if (result.startsWith("error:")) {
                //机器返回错误
                resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
            }
            resData.setData(result);
            //若获取收藏译文，则返回收藏编码

        } catch (Exception e) {
            LOGGER.error("机器翻译失败：", e);
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, rb.getMessage(""));
        }
        
        return resData;
    }

    @ResponseBody
    @RequestMapping(value = "/mtUpload")
    public ResponseData<String> docMt(String from, String to, HttpServletRequest request) {
        ResponseData<String> resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try {
            MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;
            // 获取请求的参数
            MultipartFile mFile = mRequest.getFile("file");

            //txt 文件
            String text = "";
            if (mFile.getName().toLowerCase().endsWith("txt")) {
                byte[] mFileBytes = mFile.getBytes();
                //判断txt文件编码
                byte[] head = new byte[3];
                System.arraycopy(mFileBytes, 0, head, 0, 3);
                String code = "gb2312";
                if (head[0] == -1 && head[1] == -2 )
                    code = "UTF-16";
                if (head[0] == -2 && head[1] == -1 )
                    code = "Unicode";
                if(head[0]==-17 && head[1]==-69 && head[2] ==-65)
                    code = "UTF-8";
                text = new String(mFileBytes, code);
            } else {
                InputStream sbs = new ByteArrayInputStream(mFile.getBytes());
                text = WordUtil.readWord(mFile.getOriginalFilename(), sbs);
            }
            LOGGER.info(text);

            //分段翻译
            textContent = "";
            int len = text.length();
            int offfset = 2000;
            int alreadyLen = 0;

            while (len > 0 ) {
                String tempStr;
                if (len >= offfset) {
                    tempStr = text.substring(alreadyLen, offfset);
                    alreadyLen += offfset;
                    len -= offfset;
                } else {
                    len = 0;
                    tempStr = text.substring(alreadyLen);
                }
                textContent += yeekitService.dotranslate(from, to, tempStr);
            }

            resData.setData(textContent);
        } catch (Exception e) {
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,"");
            LOGGER.error("文档翻译失败:", e.getMessage());
        }
        return resData;
    }

    @RequestMapping("/downloadDoc")
    public void downloadDoc(String fileType, HttpServletRequest request,
                         HttpServletResponse response) {
        byte[] b;
        try {
            if ("doc" == fileType.toLowerCase()) {

                ByteArrayInputStream bs = new ByteArrayInputStream(textContent.getBytes("utf-8"));
                POIFSFileSystem fs = new POIFSFileSystem();
                DirectoryEntry directory = fs.getRoot();

                directory.createDocument("WordDocument", bs);

                ByteArrayOutputStream baos = new ByteArrayOutputStream();

                fs.writeFilesystem(baos);
                b = baos.toByteArray();

                baos.close();
                bs.close();
            } else {
                b = textContent.getBytes("utf-8");
            }

            OutputStream os = response.getOutputStream();
//            response.setCharacterEncoding("utf-8");
            response.setContentType("multipart/form-data");
            response.setHeader("Content-Disposition", "attachment;fileName=translation."+fileType);
            response.setHeader("Content-Length", b.length+"");
            os.write(b);
            os.close();

        } catch (Exception e) {
            LOGGER.info("下载文件异常：", e);
        }
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

    /**
     * 查询用户收藏译文
     * @return
     */
    private String queryCollection(String from,String to,String text){
        StringBuilder sb = new StringBuilder();
        IYCUserCollectionSV userCollectionSV = DubboConsumerFactory.getService(IYCUserCollectionSV.class);
        UserCollectionPageInfoRequest request = new UserCollectionPageInfoRequest();
        request.setUserId(UserUtil.getUserId());
        request.setSourceLanguage(from);
        request.setTargetLanguage(to);
        request.setOriginal(text);
        request.setPageNo(1);
        request.setPageSize(1);
        UserCollectionInfoListResponse response = userCollectionSV.queryCollectionInfo(request);
        PageInfo<UserCollectionInfo> pageInfo = response==null?null:response.getCollectionList();

        if (pageInfo != null && !CollectionUtil.isEmpty(pageInfo.getResult())) {
            UserCollectionInfo collectionInfo = pageInfo.getResult().get(0);

            /* 返回信息示例
            {
            "translation": [
                {
                    "translated": [
                        {
                            "alignment-raw": [
                                {
                                    "src-start": 0,
                                    "tgt-start": 0,
                                    "src-end": 0,
                                    "tgt-end": 0
                                }
                            ],
                            "text": "China",
                            "rank": 0,
                            "tgt-tokenized": "China ",
                            "score": -0.8170589804649353,
                            "src-tokenized": "中国"
                        }
                    ],
                    "translationId": "b68b0ab9f9ca44ce962b6d26a613eca6"
                }
            ],
            "collectionId":"" //收藏记录标识
            }
             */

            sb.append("{\"translation\": [{\"translated\":[{ ")
                    .append("\"text\":\"").append(collectionInfo.getTranslation()).append("\",\"rank\": 0")
                    .append(",\"score\": 1,").append("\"src-tokenized\":\"").append(text).append("\"")
                    .append("}],")
                    .append("\"translationId\": \"123\"").append("}]")
                    .append("\"collectionId\":").append(collectionInfo.getId()).append("}");
        }
        //TODO... 模拟数据
//        sb.append("{\"translation\": [{\"translated\":[{ ")
//                .append("\"text\":\"").append("Hello main").append("\",\"rank\": 0").append(",\"score\": 1,")
//                .append("\"src-tokenized\":\"").append(text).append("\"")
//                .append("}],")
//                .append("\"translationId\": \"123\"").append("}],")
//                .append("\"collectionId\":").append("345345").append("}");
        return sb.toString();
    }
  
}
