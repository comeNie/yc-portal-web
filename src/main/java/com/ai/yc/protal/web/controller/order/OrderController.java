package com.ai.yc.protal.web.controller.order;

import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.components.dss.DSSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.dss.base.interfaces.IDSSClient;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.common.api.cachekey.key.CacheKey;
import com.ai.yc.order.api.autooffer.interfaces.IQueryAutoOfferSV;
import com.ai.yc.order.api.autooffer.param.QueryAutoOfferReq;
import com.ai.yc.order.api.autooffer.param.QueryAutoOfferRes;
import com.ai.yc.order.api.ordersubmission.param.BaseInfo;
import com.ai.yc.order.api.ordersubmission.param.FeeInfo;
import com.ai.yc.order.api.ordersubmission.param.OrderSubmissionRequest;
import com.ai.yc.order.api.ordersubmission.param.ProductInfo;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.service.CacheServcie;
import com.ai.yc.protal.web.utils.UserUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

import java.io.IOException;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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


/**
 * 通用订单
 * Created by liutong on 16/11/2.
 */
@Controller
@RequestMapping("/order")
public class OrderController {
    private static final Logger LOGGER = LoggerFactory.getLogger(OrderController.class);
    @Autowired
    private ResWebBundle rb;
    @Autowired
    private CacheServcie cacheServcie;

    /**
     * 显示文本类下单页面
     * @return
     */
    @RequestMapping("/create/text")
    public String createTextView(Model uiModel, String selPurpose, String flag, HttpSession session){
        uiModel.addAttribute("duadList", cacheServcie.getAllDuad(rb.getDefaultLocale(),CacheKey.OrderType.ORDER_TYPE_DOC));
        uiModel.addAttribute("domainList", cacheServcie.getAllDomain(rb.getDefaultLocale()));
        uiModel.addAttribute("purposeList", cacheServcie.getAllPurpose(rb.getDefaultLocale()));
        uiModel.addAttribute("selPurpose",selPurpose);

        String newFlag = StringUtils.isEmpty(flag) ? "": flag;
        if (!"return".equals(newFlag)) {
            session.removeAttribute("writeOrderInfo");
            session.removeAttribute("writeOrderSummary");
            session.removeAttribute("fileInfoList");
        }

        return "order/createTextOrder";
    }

    /**
     * 显示口语类下单页面
     * @return
     */
    @RequestMapping("/create/oral")
    public String createOralView(Model uiModel, String flag, HttpSession session){
        uiModel.addAttribute("duadList", cacheServcie.getAllDuad(rb.getDefaultLocale(),CacheKey.OrderType.ORDER_TYPE_ORAL));

        String newFlag = StringUtils.isEmpty(flag) ? "": flag;
        if (!"return".equals(newFlag)) {
            session.removeAttribute("oralOrderInfo");
            session.removeAttribute("oralOrderSummary");
        }
        return "order/createOralOrder";
    }

    /**
     * 提交订单信息，用于判断用户是否登录
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
            //调用服务计算订单价格
            QueryAutoOfferRes offerRes = iQueryAutoOfferSV.queryAutoOffer(offerInfo);
            ResponseHeader resHeader = offerRes==null? null:offerRes.getResponseHeader();
            //如果返回值为空,或返回信息中包含错误信息,则抛出异常
            if (offerRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
                LOGGER.error("系统自动报价失败:", JSONObject.toJSONString(offerRes));
                resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE,"FAIL");
            }

            //订单设置费用信息
            if (!offerRes.getPrice().equals(null)) {
                feeInfo.setTotalFee(offerRes.getPrice().longValue());
            } else {
                resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE,"FAIL");
                LOGGER.error("系统自动报价失败: 订单金额为空");
            }

            feeInfo.setCurrencyUnit(offerRes.getCurrencyUnit());
        } else {
            //"1：RMB 2：$"
            String currencyUnit = Locale.SIMPLIFIED_CHINESE.equals(rb.getDefaultLocale()) ? "1":"2";
            feeInfo.setCurrencyUnit(currencyUnit);
        }
        subReq.setFeeInfo(feeInfo);

        //订单存到session中
        if ("2".equals(subReq.getBaseInfo().getTranslateType())) {
            session.setAttribute("oralOrderInfo", subReq);
            session.setAttribute("oralOrderSummary", orderSummary);
        } else {
                session.setAttribute("writeOrderInfo", subReq);
            session.setAttribute("writeOrderSummary", orderSummary);
        }

        if (fileInfoList != null) {
            session.setAttribute("fileInfoList", fileInfoList);
        }
        if (StringUtils.isEmpty(UserUtil.getUserId())) {
            resData.setData("-2");
        } else {
            resData.setData("-1");
        }

        LOGGER.info("缓存的订单信息:", subReq);

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
    public String uploadFile(HttpServletRequest request) throws IOException {
        ResponseData<String> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS,
                "OK");

        LOGGER.info("文件上传");

        IDSSClient client = DSSClientFactory.getDSSClient(Constants.IPAAS_ORDER_FILE_DSS);
        // 文件上传的请求
        MultipartHttpServletRequest mRequest = (MultipartHttpServletRequest) request;
        // 获取请求的参数
        MultipartFile mFile = mRequest.getFile("file");
        String fileId = "";
        if (mFile.getSize() != 0 && !"".equals(mFile.getName())) {
            fileId = client.save(mFile.getBytes(), mFile.getOriginalFilename());
            LOGGER.info(mFile.getOriginalFilename() + mFile.getSize() + fileId);

        }
        resData.setData(fileId);
//            Map<String, MultipartFile> fileMap = mRequest.getFileMap();
//            String fileId = "";
//            Iterator<Map.Entry<String, MultipartFile>> it = fileMap.entrySet().iterator();
//            while (it.hasNext()) {
//                Map.Entry<String, MultipartFile> entry = it.next();
//                MultipartFile mFile = entry.getValue();
//
//                if (mFile.getSize() != 0 && !"".equals(mFile.getName())) {
//                    fileId = client.save(mFile.getBytes(), mFile.getOriginalFilename());
//                    LOGGER.info(mFile.getOriginalFilename() + mFile.getSize() + fileId);
//                }
//            }

        String tmp =  JSONObject.toJSONString(resData);
        return tmp;
    }

    /**
     * 显示订单错误页面
     * @return
     */
    @RequestMapping("/error")
    public String orderSysError(){
        return "sysError";
    }

}
