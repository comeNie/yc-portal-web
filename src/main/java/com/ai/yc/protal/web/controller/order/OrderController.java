package com.ai.yc.protal.web.controller.order;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.components.mcs.MCSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.platform.common.api.cachekey.key.CacheKey;
import com.ai.platform.common.api.cachekey.model.SysDomain;
import com.ai.platform.common.api.cachekey.model.SysDuad;
import com.ai.platform.common.api.cachekey.model.SysPurpose;
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
import com.sun.corba.se.spi.legacy.connection.GetEndPointInfoAgainException;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.jni.Local;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

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
        SysDuad sysDuad = new SysDuad();
        sysDuad.setDuadId("1");
        sysDuad.setLanguage("zh");
        sysDuad.setSourceCn("中文");
        sysDuad.setSourceEn("zh");
        sysDuad.setTargetCn("英文");
        sysDuad.setTargetEn("en");
        sysDuad.setCurrency("rmb");
        sysDuad.setOrdinary("100");
        sysDuad.setOrdinaryUrgent("150");
        sysDuad.setProfessional("200");
        sysDuad.setProfessionalUrgent("250");
        sysDuad.setPublish("300");
        sysDuad.setPublishUrgent("350");
        duadList.add(sysDuad);
        duadList.add(sysDuad);
        
        SysDomain sysDomain = new SysDomain();
        sysDomain.setDomainId("1");
        sysDomain.setDomainCn("医学");
        sysDomain.setDomainEn("yixue");
        sysDomain.setLanguage("zh");
        domainList.add(sysDomain);
        domainList.add(sysDomain);
        
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
}
