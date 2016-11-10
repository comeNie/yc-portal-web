package com.ai.yc.protal.web.controller.order;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.components.mcs.MCSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.common.api.cachekey.key.CacheKey;
import com.ai.yc.common.api.cachekey.model.SysDomain;
import com.ai.yc.common.api.cachekey.model.SysDuad;
import com.ai.yc.common.api.cachekey.model.SysPurpose;
import com.ai.yc.order.api.autooffer.interfaces.IQueryAutoOfferSV;
import com.ai.yc.order.api.autooffer.param.QueryAutoOfferReq;
import com.ai.yc.order.api.autooffer.param.QueryAutoOfferRes;
import com.ai.yc.order.api.ordersubmission.interfaces.IOrderSubmissionSV;
import com.ai.yc.order.api.ordersubmission.param.BaseInfo;
import com.ai.yc.order.api.ordersubmission.param.ContactInfo;
import com.ai.yc.order.api.ordersubmission.param.FeeInfo;
import com.ai.yc.order.api.ordersubmission.param.OrderSubmissionRequest;
import com.ai.yc.order.api.ordersubmission.param.OrderSubmissionResponse;
import com.ai.yc.order.api.ordersubmission.param.ProductInfo;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.jni.Local;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

/**
 * 通用订单
 * Created by liutong on 16/11/2.
 */
@Controller
@RequestMapping("/order")
public class OrderController {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrderController.class);
    @Autowired
    ResWebBundle rb;

    /**
     * 显示文本类下单页面
     * @return
     */
    @RequestMapping("/create/text")
    public String createTextView(Model uiModel,String selPurpose){
        
        List<SysDuad> duadList = new ArrayList<SysDuad>();
        List<SysDomain> domainList = new ArrayList<SysDomain>();
        List<SysPurpose> purposeList = new ArrayList<SysPurpose>();
        //TODO ：服务不可用，暂时关闭
        String duadStr,domainStr,purposeStr;
         //获取cache客户端
       /*ICacheClient iCacheClient = AiPassUitl.getCacheClient();
       
       if (rb.getDefaultLocale().getLanguage().equals(Locale.SIMPLIFIED_CHINESE)) {
            duadStr = iCacheClient.get(CacheKey.CN_DUAD_KEY);
            domainStr = iCacheClient.get(CacheKey.CN_DOMAIN_KEY);
            purposeStr = iCacheClient.get(CacheKey.CN_PURPOSE_KEY);
        } else {
            duadStr = iCacheClient.get(CacheKey.EN_DUAD_KEY);
            domainStr = iCacheClient.get(CacheKey.EN_DOMAIN_KEY);
            purposeStr = iCacheClient.get(CacheKey.EN_PURPOSE_KEY);
        }
        
        duadList = JSONObject.parseArray(duadStr, SysDuad.class);
        domainList = JSONObject.parseArray(domainStr, SysDomain.class);
        purposeList = JSONObject.parseArray(purposeStr, SysPurpose.class);
        */

        //模拟数据
        //语言对
        SysDuad sysDuad = new SysDuad();
        sysDuad.setDuadId("1");
        sysDuad.setLanguage("zh");
        sysDuad.setSourceCn("中文");
        sysDuad.setSourceEn("zh");
        sysDuad.setTargetCn("英文");
        sysDuad.setTargetEn("en");
        sysDuad.setCurrency("1");
        sysDuad.setOrdinary("100");
        sysDuad.setOrdinaryUrgent("150");
        sysDuad.setProfessional("200");
        sysDuad.setProfessionalUrgent("250");
        sysDuad.setPublish("300");
        sysDuad.setPublishUrgent("350");
        SysDuad sysDuad1 = new SysDuad();
        sysDuad1.setDuadId("1");
        sysDuad1.setLanguage("zh");
        sysDuad1.setSourceCn("中文2");
        sysDuad1.setSourceEn("zh");
        sysDuad1.setTargetCn("英文3");
        sysDuad1.setTargetEn("en");
        sysDuad1.setCurrency("1");
        sysDuad1.setOrdinary("100");
        sysDuad1.setOrdinaryUrgent("150");
        sysDuad1.setProfessional("200");
        sysDuad1.setProfessionalUrgent("250");
        sysDuad1.setPublish("300");
        sysDuad1.setPublishUrgent("350");
        duadList.add(sysDuad);
        duadList.add(sysDuad1);
        //领域
        SysDomain sysDomain = new SysDomain();
        sysDomain.setDomainId("1");
        sysDomain.setDomainCn("医学");
        sysDomain.setDomainEn("yixue");
        sysDomain.setLanguage("zh");
        domainList.add(sysDomain);
        domainList.add(sysDomain);
        //用途
        SysPurpose sysPurpose = new SysPurpose();
        sysPurpose.setPurposeId("1");
        sysPurpose.setLanguage("zh");
        sysPurpose.setPurposeCn("专业论文");
        sysPurpose.setPurposeEn("zhuanYeLunWen");
        sysPurpose.setPurposeId("2");
        sysPurpose.setLanguage("zh");
        sysPurpose.setPurposeCn("简历");
        sysPurpose.setPurposeEn("zhuanYeLunWen");
        sysPurpose.setPurposeId("3");
        sysPurpose.setLanguage("zh");
        sysPurpose.setPurposeCn("产品说明");
        sysPurpose.setPurposeEn("zhuanYeLunWen");

        purposeList.add(sysPurpose);
        purposeList.add(sysPurpose);

        uiModel.addAttribute("duadList", duadList);
        uiModel.addAttribute("domainList", domainList);
        uiModel.addAttribute("purposeList", purposeList);
        uiModel.addAttribute("selPurpose",selPurpose);

        return "order/createTextOrder";
    }

    /**
     * 显示口语类下单页面
     * @return
     */
    @RequestMapping("/create/oral")
    public String createOralView(Model uiModel){
        List<SysDuad> duadList = new ArrayList<SysDuad>();
        String duadStr;
        
        //TODO 暂时关闭
        /*ICacheClient iCacheClient = AiPassUitl.getCacheClient();
        if (rb.getDefaultLocale().getLanguage().equals(Locale.SIMPLIFIED_CHINESE)) {
            duadStr = iCacheClient.get(CacheKey.CN_DUAD_KEY);
        } else {
            duadStr = iCacheClient.get(CacheKey.EN_DUAD_KEY);
        }
        duadList = JSONObject.parseArray(duadStr, SysDuad.class);*/
        
        //模拟数据
        SysDuad sysDuad = new SysDuad();
        sysDuad.setDuadId("1");
        sysDuad.setLanguage("zh");
        sysDuad.setOrderType("2"); //口译类型
        sysDuad.setLanguage("zh");
        sysDuad.setSourceCn("中文");
        sysDuad.setSourceEn("zh");
        sysDuad.setTargetCn("英文");
        sysDuad.setTargetEn("en");
        sysDuad.setCurrency("rmb");
        duadList.add(sysDuad);
        duadList.add(sysDuad);
        
        uiModel.addAttribute("duadList", duadList);
        return "order/createOralOrder";
    }
    
    /**
     * 系统自动报价
     * @return
     */
    @RequestMapping(value = "/queryAutoOffer",method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<QueryAutoOfferRes> queryAutoOffer(HttpServletRequest request){
        ResponseData<QueryAutoOfferRes> resData = new ResponseData<QueryAutoOfferRes>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        LOGGER.info(request.getParameter("reqParams"));
        /*try {
            IQueryAutoOfferSV iQueryAutoOfferSV = DubboConsumerFactory.getService(IQueryAutoOfferSV.class);
            QueryAutoOfferReq offerInfo =  JSON.parseObject(request.getParameter("reqParams"), QueryAutoOfferReq.class);;
            QueryAutoOfferRes offerRes = iQueryAutoOfferSV.queryAutoOffer(offerInfo);
            ResponseHeader resHeader = offerRes==null? null:offerRes.getResponseHeader();
            //如果返回值为空,或返回信息中包含错误信息,则抛出异常
            if (offerRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
                throw new Exception("返回信息错误");
            }
        } catch(Exception e) {
            LOGGER.error("系统自动报价:",e);
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,rb.getMessage(""));
        }*/
        QueryAutoOfferRes offerRes = new QueryAutoOfferRes();
        offerRes.setCurrencyUnit("1");//币种 1：RMB 2：$
        offerRes.setPrice(new BigDecimal(100.22));
        resData.setData(offerRes);
        return resData;
    }

    /**
     * 提交订单
     * @return
     */
    @RequestMapping(value = "/save",method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<String> submitOrder(HttpServletRequest request){
        ResponseData<String> resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        String feeInfoStr = request.getParameter("feeInfo");
        String contactInfoStr = request.getParameter("contactInfo");
        String productInfoStr = request.getParameter("productInfo");
        String baseInfoStr = request.getParameter("baseInfo");
        //TODO 判断登录

        OrderSubmissionRequest subReq = new OrderSubmissionRequest();
        subReq.setBaseInfo(JSON.parseObject(baseInfoStr, BaseInfo.class));
        subReq.setProductInfo(JSON.parseObject(productInfoStr, ProductInfo.class));
        subReq.setContactInfo(JSON.parseObject(contactInfoStr, ContactInfo.class));
        subReq.setFeeInfo(JSON.parseObject(feeInfoStr, FeeInfo.class));

        LOGGER.info(JSONObject.toJSONString(subReq));
        /*try {
            IOrderSubmissionSV orderSubmissionSV = DubboConsumerFactory.getService(IOrderSubmissionSV.class);
            OrderSubmissionRequest subReq = new OrderSubmissionRequest();
            OrderSubmissionResponse subRes = orderSubmissionSV.orderSubmission(subReq);
            ResponseHeader resHeader = subRes==null?null:subRes.getResponseHeader();
            //如果返回值为空,或返回信息中包含错误信息,则抛出异常
            if (subRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){

            }
        }catch (BusinessException e){
            LOGGER.error("提交订单失败:",e);
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,rb.getMessage(""));
        }*/

        //TODO... 虚拟数据
        OrderSubmissionResponse subRes = new OrderSubmissionResponse();
        resData.setData(subRes.getOrderId()+"");//返回订单信息
        return resData;
    }
    
    @RequestMapping("/uploadFile")
    public void  uploadHeadPic(HttpServletRequest request,
            HttpServletResponse response)
            throws IllegalStateException, IOException {
        LOGGER.info("文件上传");
        String uid=request.getParameter("uid");//获取uid
        String pid=request.getParameter("pid");//获取jsp id参数
        System.out.println(uid);
        System.out.println(pid);
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(
                request.getSession().getServletContext());
        if (multipartResolver.isMultipart(request)) {
            MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest) request;
            Iterator<String> iter = multiRequest.getFileNames();
            while (iter.hasNext()) {
                // int pre = (int) System.currentTimeMillis();//开始时时间
                MultipartFile file = multiRequest.getFile(iter.next());
                if (file != null) {
                    String myFileName = file.getOriginalFilename();
                    if (myFileName.trim() != "") {
                        String fileName = file.getOriginalFilename();
                        String fileExt = fileName.substring(
                                fileName.lastIndexOf(".") + 1).toLowerCase();
                        SimpleDateFormat df = new SimpleDateFormat(
                                "yyyyMMddHHmmss");
                        String newFileName = df.format(new Date());
                        String fileNames = newFileName
                                + new Random().nextInt(1000) + "." + fileExt;
                         String path = "E:/" + fileNames;//上传路径
                        // String path =
                        // request.getSession().getServletContext()
                        // .getRealPath("/resources/contractImgs")
                        // + "/" + fileNames;
                        File localFile = new File(path);
                        if (!localFile.exists()) {// 如果文件夹不存在，自动创建
                            localFile.mkdirs();
                        }
                        file.transferTo(localFile);
                    }
                }
            }
        }
    }

    /**
     * 订单支付结果
     * @return
     */
    @RequestMapping("/payResult")
    public String orderPayResult(Model uiModel){
        //订单号
        uiModel.addAttribute("orderId","23423");
        //支付结果
        uiModel.addAttribute("payResult","1");
        return "order/orderPayResult";
    }
}
