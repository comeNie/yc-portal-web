package com.ai.yc.protal.web.controller.order;

import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.components.dss.DSSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.dss.base.interfaces.IDSSClient;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.order.api.orderdetails.interfaces.IQueryOrderDetailsSV;
import com.ai.yc.order.api.orderdetails.param.*;
import com.ai.yc.order.api.orderquery.interfaces.IOrderQuerySV;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountResponse;
import com.ai.yc.order.api.orderstate.interfaces.IOrderStateUpdateSV;
import com.ai.yc.order.api.orderstate.param.OrderStateUpdateRequest;
import com.ai.yc.order.api.orderstate.param.OrderStateUpdateResponse;
import com.ai.yc.order.api.orderstate.param.UpdateStateChgInfo;
import com.ai.yc.order.api.translatesave.interfaces.ITranslateSaveSV;
import com.ai.yc.order.api.translatesave.param.SaveTranslateInfoRequest;
import com.ai.yc.order.api.translatesave.param.TranslateFileVo;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.OrderConstants;
import com.ai.yc.protal.web.constants.TranslatorConstants;
import com.ai.yc.protal.web.service.CacheServcie;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.translator.api.translatorservice.interfaces.IYCTranslatorServiceSV;
import com.ai.yc.translator.api.translatorservice.param.SearchYCTranslatorSkillListRequest;
import com.ai.yc.translator.api.translatorservice.param.YCTranslatorSkillListResponse;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * 译员订单处理
 * Created by liutong on 16/11/15.
 */
@Controller
@RequestMapping("/p/trans/order")
public class TransOrderController {
    private static final Logger LOGGER = LoggerFactory.getLogger(TransOrderController.class);
            
    @Autowired
    private CacheServcie cacheServcie;
    @Autowired
    private ResWebBundle rb;

    private static String TRANS_ERROR_PAGE = "transOrder/orderError";
    private static int FILE_MAX_SIZE = 104857600; //100*1024*1024 100M
    /**
     * 译员订单,订单列表
     * @return
     */
    @RequestMapping("/list/view")
    public String orderListView(Model uiModel, String state){

        uiModel.addAttribute("domainList", cacheServcie.getAllDomain(rb.getDefaultLocale())); //领域
        uiModel.addAttribute("purpostList", cacheServcie.getAllPurpose(rb.getDefaultLocale())); //用途

        IOrderQuerySV iOrderQuerySV = DubboConsumerFactory.getService(IOrderQuerySV.class);
        QueryOrdCountRequest ordCountReq = new QueryOrdCountRequest();

        String userId = UserUtil.getUserId();

        //查询译员信息
        IYCTranslatorServiceSV translatorServiceSV = DubboConsumerFactory.getService(IYCTranslatorServiceSV.class);
        SearchYCTranslatorSkillListRequest ycReq = new SearchYCTranslatorSkillListRequest();
        ycReq.setTenantId(Constants.DEFAULT_TENANT_ID);
        ycReq.setUserId(UserUtil.getUserId());
        YCTranslatorSkillListResponse ycRes = translatorServiceSV.getTranslatorSkillList(ycReq);
        LOGGER.info("译员信息: "+JSONObject.toJSONString(ycRes));
        //0：认证不通过，1：认证通过
        if(!"1".equals(ycRes.getApproveState()) ) {
            return "redirect:/p/security/interpreterIndex";
        }

        ordCountReq.setInterperId(userId);//设置译员编码
        //如果是LSP的管理员或项目经理
        if ("12".equals(ycRes.getLspRole()) || "11".equals(ycRes.getLspRole())) {
            ordCountReq.setLspId(ycRes.getLspId());
            ordCountReq.setInterperId(null);
        }

        //查询订单大厅数量
        QueryOrdCountResponse ordCountRes = iOrderQuerySV.queryOrderCount(ordCountReq);
        Map<String,Integer> stateCount = ordCountRes.getCountMap();

        // 21：已领取
        uiModel.addAttribute("ReceivedCount", stateCount.get(OrderConstants.State.RECEIVE));
        //211：已分配
        uiModel.addAttribute("AssignedCount", stateCount.get(OrderConstants.State.ASSIGNED));
        //23：翻译中
        uiModel.addAttribute("TranteCount", stateCount.get(OrderConstants.State.TRANSLATING));

        uiModel.addAttribute("interperInfo", ycRes);
        uiModel.addAttribute("state", state);

        return "transOrder/orderList";
    }
    
    /**
     * 译员订单 显示订单详情
     * @param operType 操作类型
     * @param orderId
     * @param uiModel
     * @return
     */
    @RequestMapping("/{orderId}")
    public String orderInfoView(@RequestParam(value = "operType",required = false)Integer operType,
            @PathVariable("orderId") String orderId, Model uiModel){
        if (StringUtils.isEmpty(orderId)) {
            return TRANS_ERROR_PAGE;
        }

        IQueryOrderDetailsSV iQueryOrderDetailsSV = DubboConsumerFactory.getService(IQueryOrderDetailsSV.class);
        QueryOrderDetailsRequest orderDetailsReq = new QueryOrderDetailsRequest();
        orderDetailsReq.setOrderId(Long.valueOf(orderId));
        orderDetailsReq.setChgStateFlag(null);
        //查询订单详情
        QueryOrderDetailsResponse orderDetailsRes = iQueryOrderDetailsSV.queryOrderDetails4Portal(orderDetailsReq);
        ResponseHeader resHeader = orderDetailsRes.getResponseHeader();
        LOGGER.info("订单详细信息 ：" + JSONObject.toJSONString(orderDetailsRes));
        //如果返回值为空,或返回信息中包含错误信息,返回失败
        if (orderDetailsRes.getOrderId()==null|| (resHeader!=null && (!resHeader.isSuccess()))){
            return TRANS_ERROR_PAGE;
        }
        //如果订单为待领取之前状态或为关闭状态，则不能查看
        if(OrderConstants.State.UN_RECEIVE.compareTo(orderDetailsRes.getState())>0
                || OrderConstants.State.CLOSE.equals(orderDetailsRes.getState())){
            return "httpError/403";
        }
        //查询译员信息
        IYCTranslatorServiceSV translatorServiceSV = DubboConsumerFactory.getService(IYCTranslatorServiceSV.class);
        SearchYCTranslatorSkillListRequest searchYCUserReq = new SearchYCTranslatorSkillListRequest();
        searchYCUserReq.setUserId(UserUtil.getUserId());
        YCTranslatorSkillListResponse userInfoResponse = translatorServiceSV.getTranslatorSkillList(searchYCUserReq);
        //包括译员的等级,是否为LSP译员,LSP中的角色,支持的语言对
        uiModel.addAttribute("lspId",userInfoResponse.getLspId());//lsp标识
        uiModel.addAttribute("lspRole",userInfoResponse.getLspRole());//lsp角色
        uiModel.addAttribute("vipLevel",userInfoResponse.getVipLevel());//译员等级
        //是否为lsp管理员
        boolean isLspAdmin = (TranslatorConstants.LSP_ADMIN_ROLE.equals(userInfoResponse.getLspRole())
                || TranslatorConstants.LSP_PM_ROLE.equals(userInfoResponse.getLspRole()))?true:false;
        //若是口译订单，但不是LSP管理员或项目经理，则不允许查看
        if(OrderConstants.TranslateType.ORAL.equals(orderDetailsRes.getTranslateType()) && !isLspAdmin){
            return "httpError/403";
        }
        //若为待领取，但译员级别不够
        if(OrderConstants.State.UN_RECEIVE.equals(orderDetailsRes.getState())
                && userInfoResponse.getVipLevel().compareTo(orderDetailsRes.getOrderLevel()) < 0){
            return "httpError/403";
        }
        //若订单为"待领取"之后，则进行权限检查
        if(OrderConstants.State.UN_RECEIVE.compareTo(orderDetailsRes.getState())<0) {
            //若不是LSP订单，且不是本人订单，则不允许查看
            if(StringUtils.isBlank(orderDetailsRes.getLspId())
                    && !UserUtil.getUserId().equals(orderDetailsRes.getInterperId())){
                return "httpError/403";
            }
            //若是LSP管理员，但不属于lsp订单
            if (isLspAdmin && !userInfoResponse.getLspId().equals(orderDetailsRes.getLspId())) {
                return "httpError/403";
            }
            //不是LSP管理员，且不是本人订单
            else if (!isLspAdmin && !allowUserOrderView(orderDetailsRes)) {
                return "httpError/403";
            }
        }
        boolean allowAssign = false;
        //判断所有步骤是否已经领取
        for (OrderFollowVo followVo:orderDetailsRes.getFollowInfoes()){
            if (OrderConstants.FollowVoReceiveState.UNCLAIMED.equals(followVo.getReceiveState())){
                allowAssign = true;
                break;
            }
        }
        //是否允许重新分配
        uiModel.addAttribute("allowAssign",allowAssign);
        //是否为lsp管理员
        uiModel.addAttribute("isLspAdmin",isLspAdmin);
        List<ProdFileVo> prodFileVos = orderDetailsRes.getProdFiles();
        int uUploadCount = 0; //可以上传文件的数量
        IDSSClient client = DSSClientFactory.getDSSClient(Constants.IPAAS_ORDER_FILE_DSS);
        Map<String, Long> fileSizeMap = new HashMap<>();
        for(ProdFileVo prodFileVo : prodFileVos) {
            String transId = prodFileVo.getFileTranslateId();
            if (StringUtils.isEmpty(transId)) {
                uUploadCount ++;
            } else {
                fileSizeMap.put(transId, client.getFileSize(transId));
            }
        }
        uiModel.addAttribute("operType", operType);
        uiModel.addAttribute("UUploadCount", uUploadCount);

        uiModel.addAttribute("orderDetails", orderDetailsRes);
        uiModel.addAttribute("fileSizeMap", fileSizeMap);

        return "transOrder/orderInfo";
    }

    /**
     * 译员提交订单
     * @param orderId
     * @return
     * @author mimw
     */
    @RequestMapping("/save")
    @ResponseBody
    public ResponseData<String> orderSubmit(@RequestParam("orderId") Long orderId) {
        ResponseData<String> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS, "OK");

        IQueryOrderDetailsSV iQueryOrderDetailsSV = DubboConsumerFactory.getService(IQueryOrderDetailsSV.class);

        QueryOrderDetailsRequest orderDetailsReq = new QueryOrderDetailsRequest();
        orderDetailsReq.setOrderId(orderId);
        orderDetailsReq.setChgStateFlag(OrderConstants.STATECHG_FLAG);

        QueryOrderDetailsResponse orderDetailsRes = iQueryOrderDetailsSV.queryOrderDetails4Portal(orderDetailsReq);
        ResponseHeader resHeader = orderDetailsRes.getResponseHeader();
        LOGGER.info("订单详细信息 ：" + JSONObject.toJSONString(orderDetailsRes));
        //如果返回值为空,或返回信息中包含错误信息,返回失败
        if (orderDetailsRes.getOrderId()==null|| (resHeader!=null && (!resHeader.isSuccess()))){
            resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
            return resData;
        }


        String transferType = orderDetailsRes.getTranslateType();
        //文本翻译  翻译信息为空，则返回失败
        if ("0".equals(transferType) &&
                StringUtils.isEmpty(orderDetailsRes.getProd().getTranslateInfo())) {
            resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage("order.info.transNull"));
            return resData;
        }

        //文档翻译 上传文件为0，则返回失败
        if ("1".equals(transferType)) {
            List<ProdFileVo> files = orderDetailsRes.getProdFiles();
            int filesCount = 0; //上传文件个数
            for (ProdFileVo fileVo : files) {
                if (StringUtils.isNotEmpty(fileVo.getFileTranslateId())) {
                    filesCount ++;
                }
            }

            if (filesCount <= 0) {
                resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE,
                        rb.getMessage("order.info.uploadFileNull"));
                return resData;
            }
        }

        IOrderStateUpdateSV iOrderStateUpdateSV = DubboConsumerFactory.getService(IOrderStateUpdateSV.class);
        OrderStateUpdateRequest stateReq = new OrderStateUpdateRequest();
        stateReq.setOrderId(orderId);
        stateReq.setState(OrderConstants.State.UN_CHECK); //待审核
        stateReq.setDisplayFlag(OrderConstants.State.TRANSLATING);
        stateReq.setUserId(UserUtil.getUserId());

        UpdateStateChgInfo stateChgInfo = new UpdateStateChgInfo();
        stateChgInfo.setOperName(UserUtil.getUserName());
        stateReq.setStateChgInfo(stateChgInfo);

        OrderStateUpdateResponse stateRes = iOrderStateUpdateSV.updateState(stateReq);
        resHeader = stateRes.getResponseHeader();
        //如果返回值为空,或返回信息中包含错误信息
        if (stateRes.getOrderId()==null|| (resHeader!=null && (!resHeader.isSuccess()))){
            resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
        }

        return resData;
    }
    
    /**
     * 修改订单信息,保存译文
     * @return
     * @author mimw
     */
    @RequestMapping("/updateInfo")
    @ResponseBody
    public ResponseData<String> updateOrderInfo(HttpServletRequest request) {
        ResponseData<String> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS, "OK");
        
        String orderId = request.getParameter("orderId");
        String translateInfo = request.getParameter("translateInfo");
        

        ITranslateSaveSV iTranslateSaveSV = DubboConsumerFactory.getService(ITranslateSaveSV.class);
        SaveTranslateInfoRequest updateReq = new SaveTranslateInfoRequest();
        updateReq.setOrderId(Long.valueOf(orderId));

        if (StringUtils.isNotEmpty(translateInfo)) {
            updateReq.setTranslateInfo(translateInfo);
        }
        updateReq.setOrderId(Long.valueOf(orderId));

        BaseResponse updateRes = iTranslateSaveSV.saveTranslateInfo(updateReq);
        //如果返回值为空,或返回信息中包含错误信息
        if (!updateRes.getResponseHeader().isSuccess()){
            resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
        }

        return resData;
    }
    
    /**
     * 修改订单状态
     * @param orderId
     * @param state
     * @return
     * @author mimw
     */
    @RequestMapping("/updateState")
    @ResponseBody
    public ResponseData<String> updateOrderState(@RequestParam("orderId") Long orderId, @RequestParam("state") String state
            ,@RequestParam("displayFlag") String displayFlag) {
        ResponseData<String> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS, "OK");

        IOrderStateUpdateSV iOrderStateUpdateSV = DubboConsumerFactory.getService(IOrderStateUpdateSV.class);
        OrderStateUpdateRequest stateReq = new OrderStateUpdateRequest();
        stateReq.setOrderId(orderId);
        stateReq.setState(state);
        stateReq.setDisplayFlag(displayFlag);
        stateReq.setUserId(UserUtil.getUserId());

        UpdateStateChgInfo stateChgInfo = new UpdateStateChgInfo();
        stateChgInfo.setOperName(UserUtil.getUserName());
        stateReq.setStateChgInfo(stateChgInfo);

        OrderStateUpdateResponse stateRes = iOrderStateUpdateSV.updateState(stateReq);
        ResponseHeader resHeader = stateRes.getResponseHeader();
        //如果返回值为空,或返回信息中包含错误信息
        if (stateRes.getOrderId()==null|| (resHeader!=null && (!resHeader.isSuccess()))){
            resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
        }

        return resData;
    }
    
    /**
     * 删除译员上传的文件
     * @param orderId
     * @param fileId
     * @return
     * @author mimw
     */
    @RequestMapping(value="/deleteFile", method=RequestMethod.POST)
    @ResponseBody 
    public ResponseData<String> deleteFile(@RequestParam("orderId") Long orderId, @RequestParam("fileId") String fileId){
        ResponseData<String> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS, "OK");

        //查询订单
        IQueryOrderDetailsSV iQueryOrderDetailsSV = DubboConsumerFactory.getService(IQueryOrderDetailsSV.class);

        QueryOrderDetailsRequest orderDetailsReq = new QueryOrderDetailsRequest();
        orderDetailsReq.setOrderId(orderId);
        orderDetailsReq.setChgStateFlag(OrderConstants.STATECHG_FLAG);

        QueryOrderDetailsResponse orderDetailsRes = iQueryOrderDetailsSV.queryOrderDetails4Portal(orderDetailsReq);
        List<ProdFileVo> prodFiles = orderDetailsRes.getProdFiles();

        //更新订单信息
        for(ProdFileVo prodFile : prodFiles) {
            if (fileId.equals(prodFile.getFileTranslateId())) {
                prodFile.setFileTranslateId(null);
                prodFile.setFileTranslateName(null);
                break;
            }
        }

        //保存文件信息到订单中
        ITranslateSaveSV iTranslateSaveSV = DubboConsumerFactory.getService(ITranslateSaveSV.class);

        SaveTranslateInfoRequest updateReq = new SaveTranslateInfoRequest();
        updateReq.setOrderId(orderId);
        List<TranslateFileVo> uProdFileVo = JSONArray.parseArray(JSONObject.toJSONString(prodFiles), TranslateFileVo.class)  ;
        updateReq.setFileVos(uProdFileVo);

        BaseResponse updateRes = iTranslateSaveSV.saveTranslateInfo(updateReq);
        //如果返回值为空,或返回信息中包含错误信息
        if (!updateRes.getResponseHeader().isSuccess()){
            resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
        }

        return resData;
    }
    
    
    /**
     * 译员文件上传
     * 
     * @param request
     * @return
     * @author mimw
     */
    @RequestMapping(value="/upload", method=RequestMethod.POST)
    @ResponseBody 
    public String fileUpload(HttpServletRequest request){
        String retRes;
        ResponseData<String> resData = new ResponseData<>(ResponseData.AJAX_STATUS_SUCCESS, "OK");
        
        String orderId = request.getParameter("orderId");
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        CommonsMultipartFile file = (CommonsMultipartFile) multipartRequest.getFile("file"); 
        
        try {
            IDSSClient client = DSSClientFactory.getDSSClient(Constants.IPAAS_ORDER_FILE_DSS);
            
            //查询订单
            IQueryOrderDetailsSV iQueryOrderDetailsSV = DubboConsumerFactory.getService(IQueryOrderDetailsSV.class);

            QueryOrderDetailsRequest orderDetailsReq = new QueryOrderDetailsRequest();
            orderDetailsReq.setOrderId(Long.valueOf(orderId));
            orderDetailsReq.setChgStateFlag(OrderConstants.STATECHG_FLAG);

            QueryOrderDetailsResponse orderDetailsRes = iQueryOrderDetailsSV.queryOrderDetails4Portal(orderDetailsReq);
            List<ProdFileVo> prodFiles = orderDetailsRes.getProdFiles();
            String fileId;
            boolean isUpload = false; //是否能上传
            long allFileSize = file.getSize(); //文件总大小
            String errInfo = rb.getMessage("order.info.fileMaxNum", new Object[]{prodFiles.size()});

            for(ProdFileVo prodFile : prodFiles) {
                String transId = prodFile.getFileTranslateId();
                //是否有上传位置
                if (StringUtils.isEmpty(transId)) {
                    isUpload = true;
                    break;
                } else {
                    allFileSize += client.getFileSize(transId);
                }
            }

            if (allFileSize > FILE_MAX_SIZE) {
                isUpload = false;
                errInfo = rb.getMessage("order.info.fileMaxSize");
            }

            //不能上传了,返回失败
            if (!isUpload) {
                resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, errInfo);
                retRes = JSONObject.toJSONString(resData);
                return retRes;
            }
            
            //把文件保存到DSS中
            fileId = client.save(file.getBytes(), file.getOriginalFilename());
            
            //更新 文件列表信息
            for(ProdFileVo prodFile : prodFiles) {
                //是否有上传位置
                if (StringUtils.isEmpty(prodFile.getFileTranslateId())) {
                    prodFile.setFileTranslateId(fileId);
                    prodFile.setFileTranslateName(file.getOriginalFilename());
                    break;
                }
            }
            
            //保存文件信息到订单中
            ITranslateSaveSV iTranslateSaveSV = DubboConsumerFactory.getService(ITranslateSaveSV.class);
            
            SaveTranslateInfoRequest updateReq = new SaveTranslateInfoRequest();
            updateReq.setOrderId(Long.valueOf(orderId));
            List<TranslateFileVo> uProdFileVo = JSONArray.parseArray(JSONObject.toJSONString(prodFiles), TranslateFileVo.class)  ;
            updateReq.setFileVos(uProdFileVo);
            
            BaseResponse updateRes = iTranslateSaveSV.saveTranslateInfo(updateReq);
            //如果返回值为空,或返回信息中包含错误信息
            if (!updateRes.getResponseHeader().isSuccess()){
                resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
            }
        } catch (Exception e) {
            LOGGER.error("上传译文失败:", e);
            resData = new ResponseData<>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
        }
        retRes = JSONObject.toJSONString(resData);
        return retRes;
    }

    /**
     * 是否允许非管理员/项目经理译员查看订单
     * @param orderDetailsRes
     * @return
     */
    private boolean allowUserOrderView(QueryOrderDetailsResponse orderDetailsRes){
        boolean isAllow = false;
        //若订单为LSP订单
        if (StringUtils.isNotBlank(orderDetailsRes.getLspId())){
            if(!CollectionUtil.isEmpty(orderDetailsRes.getFollowInfoes())){
                //获取订单的当前步骤,待领取状态
                OrderFollowVo nowFollow = null;
                //订单当前步骤
                for(OrderFollowVo followVo: orderDetailsRes.getFollowInfoes()){
                    if(followVo.getReceiveFollowId().equals(orderDetailsRes.getCurrentReceiveFollowId())){
                        nowFollow = followVo;
                        break;
                    }
                }
                //若当前步骤不为空，已领取，且领取人和当前用户一直
                if(nowFollow!=null
                        && OrderConstants.FollowVoReceiveState.RECEIVE.equals(nowFollow.getReceiveState())
                        && UserUtil.getUserId().equals(nowFollow.getReceiveInfos().getInterperId())){
                    isAllow = true;
                }else if(nowFollow!=null
                        && OrderConstants.FollowVoReceiveState.UNCLAIMED.equals(nowFollow.getReceiveState())
                        && !CollectionUtil.isEmpty(nowFollow.getPersonInfos())){
                    for (PersonInfoVo personInfoVo:nowFollow.getPersonInfos()){
                        if (personInfoVo.getInterperId().equals(UserUtil.getUserId())){
                            isAllow = true;
                            break;
                        }
                    }
                }
            }

        }
        else if(UserUtil.getUserId().equals(orderDetailsRes.getInterperId())){
            isAllow = true;
        }
        return isAllow;
    }
    
}
