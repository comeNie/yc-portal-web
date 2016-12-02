package com.ai.yc.protal.web.controller.order;

import com.ai.opt.base.exception.BusinessException;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.components.dss.DSSClientFactory;
import com.ai.opt.sdk.components.mcs.MCSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.dss.base.interfaces.IDSSClient;
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
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.model.pay.PayNotify;
import com.ai.yc.protal.web.service.CacheServcie;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.ai.yc.protal.web.utils.UserUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.io.File;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.axis2.databinding.types.soapencoding.Integer;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import static java.util.Locale.SIMPLIFIED_CHINESE;

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
    @Autowired
    CacheServcie cacheServcie;

    /**
     * 显示文本类下单页面
     * @return
     */
    @RequestMapping("/create/text")
    public String createTextView(Model uiModel, String selPurpose){
        uiModel.addAttribute("duadList", cacheServcie.getAllDuad(rb.getDefaultLocale(),CacheKey.OrderType.ORDER_TYPE_DOC));
        uiModel.addAttribute("domainList", cacheServcie.getAllDomain(rb.getDefaultLocale()));
        uiModel.addAttribute("purposeList", cacheServcie.getAllPurpose(rb.getDefaultLocale()));
        uiModel.addAttribute("selPurpose",selPurpose);

        return "order/createTextOrder";
    }

    /**
     * 显示口语类下单页面
     * @return
     */
    @RequestMapping("/create/oral")
    public String createOralView(Model uiModel){
        uiModel.addAttribute("duadList", cacheServcie.getAllDuad(rb.getDefaultLocale(),CacheKey.OrderType.ORDER_TYPE_ORAL));
        return "order/createOralOrder";
    }
    
    /**
     * 系统自动报价
     * @return
     */
    @RequestMapping(value = "/queryAutoOffer",method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<QueryAutoOfferRes> queryAutoOffer(String duadId,  String language,
            String purposeId, boolean isUrgent, String translateLevel,  int wordNum){
        ResponseData<QueryAutoOfferRes> resData = new ResponseData<QueryAutoOfferRes>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        try {
            IQueryAutoOfferSV iQueryAutoOfferSV = DubboConsumerFactory.getService(IQueryAutoOfferSV.class);
            QueryAutoOfferReq offerInfo =  new QueryAutoOfferReq();
            offerInfo.setDuadId(duadId);
            offerInfo.setLanguage(language);
            offerInfo.setPurposeId(purposeId);
            offerInfo.setUrgent(isUrgent);
            offerInfo.setTranslateLevel(translateLevel);
            offerInfo.setWordNum(wordNum);
            QueryAutoOfferRes offerRes = iQueryAutoOfferSV.queryAutoOffer(offerInfo);
            ResponseHeader resHeader = offerRes==null? null:offerRes.getResponseHeader();
            //如果返回值为空,或返回信息中包含错误信息,则抛出异常
            if (offerRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
                throw new Exception("返回信息错误");
            }
            resData.setData(offerRes);
        } catch(Exception e) {
            LOGGER.error("系统自动报价:",e);
            resData = new ResponseData<QueryAutoOfferRes>(ResponseData.AJAX_STATUS_FAILURE,rb.getMessage(""));
        }
        return resData;
    }

    /**
     * 缓存页面页面提交过来的订单
     * @return
     */
    @RequestMapping(value = "/add",method = RequestMethod.POST)
    @ResponseBody
    public ResponseData<String> addOrder(HttpServletRequest request, HttpSession session){
        ResponseData<String> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS,"OK");

        //取到订单的信息，缓存到 session中
        String productInfoStr = request.getParameter("productInfo");
        String baseInfoStr = request.getParameter("baseInfo");
        String orderSummaryStr = request.getParameter("orderSummary");
        String fileInfoListStr = request.getParameter("fileInfoList");

        try {
            JSONObject orderSummary = JSON.parseObject(orderSummaryStr);
            JSONArray fileInfoList = JSONArray.parseArray(fileInfoListStr);
            OrderSubmissionRequest subReq = new OrderSubmissionRequest();
            subReq.setBaseInfo(JSON.parseObject(baseInfoStr, BaseInfo.class));
            subReq.setProductInfo(JSON.parseObject(productInfoStr, ProductInfo.class));

            //设置费用信息
            FeeInfo feeInfo = new FeeInfo();
            if ( "0".equals(subReq.getBaseInfo().getTranslateType()) ) { //快速翻译，查询报价
                ProductInfo pro = subReq.getProductInfo();
                IQueryAutoOfferSV iQueryAutoOfferSV = DubboConsumerFactory.getService(IQueryAutoOfferSV.class);
                QueryAutoOfferReq offerInfo =  new QueryAutoOfferReq();

                boolean isUrgent = false;
                if ("Y".equals(pro.getIsUrgent())){
                    isUrgent = true;
                }
                String language = Locale.SIMPLIFIED_CHINESE.equals(rb.getDefaultLocale()) ? "zh_CN":"us_EN";

                offerInfo.setDuadId(pro.getLanguagePairInfoList().get(0).getLanguagePairId());
                offerInfo.setPurposeId(pro.getUseCode());
                offerInfo.setUrgent(isUrgent);
                offerInfo.setLanguage(language);
                offerInfo.setTranslateLevel(pro.getTranslateLevelInfoList().get(0).getTranslateLevel());
                offerInfo.setWordNum(pro.getTranslateSum().intValue());
                QueryAutoOfferRes offerRes = iQueryAutoOfferSV.queryAutoOffer(offerInfo);
                ResponseHeader resHeader = offerRes==null? null:offerRes.getResponseHeader();
                //如果返回值为空,或返回信息中包含错误信息,则抛出异常
                if (offerRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
                    resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,"FAIL");
                }

                //订单设置费用信息
                feeInfo.setTotalFee(offerRes.getPrice().longValue());
                feeInfo.setCurrencyUnit(offerRes.getCurrencyUnit());
            } else {
                //"1：RMB 2：$"
                String currencyUnit = Locale.SIMPLIFIED_CHINESE.equals(rb.getDefaultLocale()) ? "1":"0";
                feeInfo.setCurrencyUnit(currencyUnit);
            }
            subReq.setFeeInfo(feeInfo);


            //订单存到session中
            session.setAttribute("orderInfo", subReq);
            session.setAttribute("orderSummary", orderSummary);
            if (fileInfoList != null) {
                session.setAttribute("fileInfoList", fileInfoList);
            }
            if (StringUtils.isEmpty(UserUtil.getUserId())) {
                resData.setData("-2");
            } else {
                resData.setData("-1");
            }
            LOGGER.info("缓存的订单信息:", subReq);
        } catch(Exception e) {
            LOGGER.error("系统自动报价:",e);
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,rb.getMessage(""));
        }
        return resData;
    }

    /**
     * 目前是单文件上传，返回文件id
     * @param request
     * @throws IllegalStateException
     * @throws IOException
     * @author mimw
     */
    @RequestMapping("/uploadFile")
    @ResponseBody
    public ResponseData<String> uploadFile(HttpServletRequest request) throws IOException {
        ResponseData<String> resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,
                "OK");

        LOGGER.info("文件上传");
        try {
            IDSSClient client = DSSClientFactory.getDSSClient(Constants.IPAAS_ORDER_FILE_DSS);
            // 文件上传的请求
            MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;
            // 获取请求的参数
            Map<String, MultipartFile> fileMap = mRequest.getFileMap();
            String fileId = "";
            Iterator<Map.Entry<String, MultipartFile>> it = fileMap.entrySet().iterator();
            while (it.hasNext()) {
                Map.Entry<String, MultipartFile> entry = it.next();
                MultipartFile mFile = entry.getValue();

                if (mFile.getSize() != 0 && !"".equals(mFile.getName())) {
                    fileId = client.save(mFile.getBytes(), mFile.getOriginalFilename());
                    LOGGER.info(mFile.getOriginalFilename() + mFile.getSize() + fileId);
                }
            }

            resData.setData(fileId);
        } catch (Exception e) {
            LOGGER.error("上传文件出错:", e);
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
        }

        return resData;
    }

}
