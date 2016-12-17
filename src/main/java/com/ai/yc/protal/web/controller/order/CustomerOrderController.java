package com.ai.yc.protal.web.controller.order;

import java.io.OutputStream;
import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ai.opt.sdk.util.DateUtil;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.slp.balance.api.deduct.interfaces.IDeductSV;
import com.ai.slp.balance.api.deduct.param.DeductParam;
import com.ai.slp.balance.api.deduct.param.DeductResponse;
import com.ai.yc.order.api.orderdetails.param.QueryOrderDetailsRequest;
import com.ai.yc.order.api.orderfee.interfaces.IOrderFeeQuerySV;
import com.ai.yc.order.api.orderfee.param.*;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.OrderConstants;
import com.ai.yc.protal.web.model.pay.AccountBalanceInfo;
import com.ai.yc.protal.web.service.BalanceService;
import com.ai.yc.protal.web.service.OrderService;
import com.ai.yc.protal.web.utils.*;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.components.dss.DSSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.dss.base.interfaces.IDSSClient;
import com.ai.paas.ipaas.i18n.ZoneContextHolder;
import com.ai.yc.order.api.orderclose.interfaces.IOrderCancelSV;
import com.ai.yc.order.api.orderclose.param.OrderCancelRequest;
import com.ai.yc.order.api.orderdetails.interfaces.IQueryOrderDetailsSV;
import com.ai.yc.order.api.orderdetails.param.QueryOrderDetailsResponse;
import com.ai.yc.order.api.orderfee.param.OrderFeeInfo;
import com.ai.yc.order.api.orderfee.param.OrderFeeQueryResponse;
import com.ai.yc.order.api.orderquery.interfaces.IOrderQuerySV;
import com.ai.yc.order.api.orderquery.param.OrdOrderVo;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountResponse;
import com.ai.yc.order.api.orderquery.param.QueryOrderRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrderRsponse;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * 客户订单
 * Created by liutong on 16/11/3.
 */
@Controller
@RequestMapping("/p/customer/order")
public class CustomerOrderController {
    private static final Logger LOGGER = LoggerFactory.getLogger(CustomerOrderController.class);
    @Autowired
    BalanceService balanceService;
    @Autowired
    OrderService orderService;
    @Autowired
    ResWebBundle rb;

    /**
     * 我的订单,订单列表
     * @return
     */
    @RequestMapping("/list/view")
    public String orderListView(Model uiModel, String displayFlag){
        //查询 订单数量
        //待支付数量
        try {
            String userId = UserUtil.getUserId();
            IOrderQuerySV iOrderQuerySV = DubboConsumerFactory.getService(IOrderQuerySV.class);
            QueryOrdCountRequest ordCountReq = new QueryOrdCountRequest();
            ordCountReq.setUserId(userId);

            QueryOrdCountResponse ordCountRes = iOrderQuerySV.queryOrderCount(ordCountReq);

            LOGGER.info(JSONObject.toJSONString(ordCountRes));
            uiModel.addAttribute("CountMap", ordCountRes.getCountMap());

            Map<String,Integer> stateCount = ordCountRes.getCountMap();
            //待支付
            uiModel.addAttribute("UnPaidCount", stateCount.get(OrderConstants.DisplayState.UN_PAID));
            //翻译中
            uiModel.addAttribute("TranslateCount", stateCount.get(OrderConstants.DisplayState.TRANSLATING));
            //待确认
            uiModel.addAttribute("UnConfirmCount", stateCount.get(OrderConstants.DisplayState.UN_CONFIRM));
            //待评价
            uiModel.addAttribute("UnEvaluateCount", stateCount.get(OrderConstants.DisplayState.UN_EVALUATE));
            
            uiModel.addAttribute("userId", UserUtil.getUserId());
            uiModel.addAttribute("displayFlag", displayFlag);
        } catch (Exception e) {
            LOGGER.error("查询订单数量:",e);
        }
            
        return "customerOrder/orderList";
    }
    
    /**
     * 查询订单列表
     * @param request
     * @return
     * @author mimw
     */
    @RequestMapping("/orderList")
    @ResponseBody
    public ResponseData<PageInfo<OrdOrderVo> > orderList(HttpServletRequest request,  QueryOrderRequest orderReq){
        ResponseData<PageInfo<OrdOrderVo>> resData = new ResponseData<PageInfo<OrdOrderVo>>(ResponseData.AJAX_STATUS_SUCCESS,"OK");

        String orderTimeStart = request.getParameter("orderTimeStartStr");  //订单查询开始时间
        String orderTimeEnd = request.getParameter("orderTimeEndStr"); //订单查询结束时间
        String stateListStr = request.getParameter("stateListStr"); //后台、译员 订单状态
        String lspRole = request.getParameter("lspRole"); //译员角色
        try {
            //如果 译员id、用户id 都为null，返回空。一般不会出现
            if (StringUtils.isEmpty(orderReq.getUserId()) && StringUtils.isEmpty(orderReq.getInterperId())) {
                resData.setData(null);
                return resData;
            }
            //如果是LSP的管理员或项目经理
            if ("12".equals(lspRole) || "11".equals(lspRole)) {
                orderReq.setInterperId(null);
                orderReq.setUserId(null);
            }//如果不是LSP的管理员或项目经理,则清除LSP的标识
            else {
                orderReq.setLspId(null);
            }

            //获取当前用户所处时区
            TimeZone timeZone = TimeZone.getTimeZone(ZoneContextHolder.getZone());
            
            if (StringUtils.isNotEmpty(orderTimeStart)) {
                String dateTmp = orderTimeStart+" 00:00:00";
                Timestamp date =DateUtil.getTimestamp(dateTmp,DateUtil.DATETIME_FORMAT,timeZone);
                orderReq.setOrderTimeStart(date);
            }
            if (StringUtils.isNotEmpty(orderTimeEnd)) {
                String dateTmp = orderTimeEnd+" 23:59:59";
                Timestamp date =DateUtil.getTimestamp(dateTmp,DateUtil.DATETIME_FORMAT,timeZone);
                orderReq.setOrderTimeEnd(date);
            }
            if (StringUtils.isNotEmpty(stateListStr)) {
                List<Object> states = JSONArray.parseArray(stateListStr);
                orderReq.setStateList(states);
            }
            LOGGER.info("订单列表查询数据：" +JSONObject.toJSONString(orderReq));
            
            IOrderQuerySV iOrderQuerySV = DubboConsumerFactory.getService(IOrderQuerySV.class);
            QueryOrderRsponse orderRes = iOrderQuerySV.queryOrder(orderReq);
            ResponseHeader resHeader = orderRes.getResponseHeader();
            LOGGER.info("订单列表查询 ：" + JSONObject.toJSONString(orderRes));
            //如果返回值为空,或返回信息中包含错误信息,返回失败
            if (orderRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){

            } else {
                PageInfo<OrdOrderVo> pageInfo = orderRes.getPageInfo();
                //返回订单分页信息
                resData.setData(pageInfo);
            }
        } catch (Exception e) {
            LOGGER.error("查询订单分页失败:",e);
            resData = new ResponseData<PageInfo<OrdOrderVo>>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
        }
        return resData;
    }
    
    /**
     * 待报价页面
     * @return
     */
    @RequestMapping("/orderOffer")
    public String orderOffer(){
        return "order/orderOffer";
    }
    
    
    /**
     * 取消订单，在未支付的情况下取消
     * @param orderId
     * @return
     * @author mimw
     */
    @RequestMapping("/cancelOrder")
    @ResponseBody
    public ResponseData<String> cancelOrder(String orderId) {
        ResponseData<String> resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");

        try {
            IOrderCancelSV iOrderCancelSV = DubboConsumerFactory.getService(IOrderCancelSV.class);
            OrderCancelRequest cancelReq = new OrderCancelRequest();
            cancelReq.setOrderId(Long.valueOf(orderId));
            cancelReq.setOperId(UserUtil.getUserId()); //操作员id 传入的是用户id
            BaseResponse baseRes = iOrderCancelSV.handCancelNoPayOrder(cancelReq);
            ResponseHeader resHeader = baseRes.getResponseHeader();
            LOGGER.info("取消订单返回 ："+JSONObject.toJSONString(baseRes));
            //如果返回值为空,或返回信息中包含错误信息,返回失败
            if (baseRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
                resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
            }
        } catch(Exception e) {
            LOGGER.error("取消订单失败：", e);
            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, rb.getMessage(""));
        }
        
        return resData;
    }

     /**
     * 支付页面
     * @return
     */
    @RequestMapping("/payOrder/{orderId}")
    public String createTextView(
            @PathVariable("orderId") Long orderId, @RequestParam(value = "unit",required = false) String unit,
            Model uiModel){
        String resultView = "order/payOrder";//订单支付页面
        IOrderFeeQuerySV iOrderFeeQuerySV = DubboConsumerFactory.getService(IOrderFeeQuerySV.class);
        OrderFeeQueryRequest feeQueryRequest = new OrderFeeQueryRequest();
        feeQueryRequest.setOrderId(orderId);
        OrderFeeQueryResponse feeQueryResponse = iOrderFeeQuerySV.orderFeeQuery(feeQueryRequest);
        OrderFeeInfo orderFeeInfo = feeQueryResponse.getOrderFeeInfo();
        OrderFeeProdInfo orderPordInfo = feeQueryResponse.getOrderFeeProdInfo();

        //若订单金额等于0,则表示待报价
        if(orderFeeInfo.getTotalFee().equals(0)){
            resultView = "order/orderOffer";
        }
        //若是人民币,需要获取账户余额
        else if(Constants.CURRENCTY_UNIT_RMB.equals(orderFeeInfo.getCurrencyUnit())){
            AccountBalanceInfo balanceInfo = balanceService.queryOfUser(UserUtil.getUserId());
            //账户余额信息
            uiModel.addAttribute("balanceInfo",balanceInfo);
            //是否显示待充值信息
            uiModel.addAttribute("needPay",
                    (balanceInfo!=null&&balanceInfo.getBalance()<orderFeeInfo.getTotalFee())?true:false);
        }
        //订单编号
        uiModel.addAttribute("orderId",orderId);
        //订单信息
        uiModel.addAttribute("orderFee",feeQueryResponse.getOrderFeeInfo());
        //订单主题
        uiModel.addAttribute("translateName",orderPordInfo.getTranslateName());
        return resultView;
    }

    /**
     * 余额支付
     * @return
     */
    @RequestMapping("/payOrder/balance")
    public String balancePay(DeductParam deductParam,String orderType,Model uiModel){
        String userId = UserUtil.getUserId();
        //进行余额扣款,页面
        deductParam.setTenantId(Constants.DEFAULT_TENANT_ID);
        //中心产品或垂直产品的唯一编码,传balance
        deductParam.setSystemId("balance");
        deductParam.setBusinessCode("001");//目前无用,使用固定内容
        deductParam.setChannel("中译语通科技有限公司");
        deductParam.setBusiDesc("订单支付,订单号:"+deductParam.getExternalId());
        IDeductSV deductSV = DubboConsumerFactory.getService(IDeductSV.class);
        DeductResponse deductResponse = deductSV.deductFund(deductParam);
        ResponseHeader responseHeader = deductResponse.getResponseHeader();
        //支付结果,默认为失败
        boolean payResult = false;
        //扣款成功,同步订单状态
        if (responseHeader==null||responseHeader.isSuccess()){
            orderService.orderPayProcessResult(userId,deductParam.getAccountId(),
                    Long.parseLong(deductParam.getExternalId()),orderType,
                    deductParam.getTotalAmount(),"YE",deductResponse.getSerialNo(), DateUtil.getFutureTime());
            payResult = true;
        }
        //订单号
        uiModel.addAttribute("orderId",deductParam.getExternalId());
        //支付结果
        uiModel.addAttribute("payResult",payResult);
        //显示订单支付结果
        return "order/orderPayResult";
    }
     /**
     * 跳转支付页面,需要登录后才能进行支付
     * @param orderId
     * @param orderAmount
     * @param response
     * @throws Exception
     */
    @RequestMapping(value = "/gotoPay")
    public String gotoPay(
            String orderId,Long orderAmount,String currencyUnit,String merchantUrl,String payOrgCode,
            String orderType,String translateName,
            HttpServletResponse response,Model uiModel)
            throws Exception {
        //租户
        String tenantId= ConfigUtil.getProperty("TENANT_ID");
        //服务异步通知地址
        String notifyUrl= ConfigUtil.getProperty("NOTIFY_URL")+"/"+orderType+"/"+ UserUtil.getUserId();

        //异步通知地址,默认为用户
        //将订单金额直接转换为小数点后两位
        java.text.DecimalFormat df =new java.text.DecimalFormat("#0.00");
        String amount = String.valueOf(df.format(AmountUtil.changeLiToYuan(orderAmount)));
        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", tenantId);//租户ID
        map.put("orderId", orderId);//请求单号
        map.put("returnUrl", ConfigUtil.getProperty("RETURN_URL"));//页面跳转地址
        map.put("notifyUrl", notifyUrl);//服务异步通知地址
        map.put("merchantUrl",merchantUrl);//用户付款中途退出返回商户的地址
        map.put("requestSource", Constants.SELF_SOURCE);//终端来源
        map.put("currencyUnit",currencyUnit);//币种
        map.put("orderAmount", amount);//金额
        map.put("subject", translateName);//订单名称
        map.put("payOrgCode",payOrgCode);
        // 加密
        String infoStr = orderId+ VerifyUtil.SEPARATOR
                + amount + VerifyUtil.SEPARATOR
                + notifyUrl + VerifyUtil.SEPARATOR
                + tenantId;
        String infoMd5 = VerifyUtil.encodeParam(infoStr, ConfigUtil.getProperty("REQUEST_KEY"));
        map.put("infoMd5", infoMd5);
        LOGGER.info("开始前台通知:" + map);
        String htmlStr = PaymentUtil.generateAutoSubmitForm(ConfigUtil.getProperty("ACTION_URL"), map);
        uiModel.addAttribute("paramsMap",map);
        uiModel.addAttribute("actionUrl",ConfigUtil.getProperty("ACTION_URL"));
        LOGGER.info("发起支付申请:" + htmlStr);
//        response.setStatus(HttpServletResponse.SC_OK);
//        response.getWriter().write(htmlStr);
//        response.getWriter().flush();
        return "gotoPay";
    }

    /**
     * 显示订单详情
     * @param orderId
     * @param uiModel
     * @return
     */
    @RequestMapping("/{orderId}")
    public String orderInfoView(@PathVariable("orderId") String orderId, Model uiModel,HttpSession session){
        
        if (StringUtils.isEmpty(orderId)) {
            return "customerOrder/orderError";
        }
        LOGGER.info("customer order session "+session.getAttribute("USER_TIME_ZONE"));
        try {
            IQueryOrderDetailsSV iQueryOrderDetailsSV = DubboConsumerFactory.getService(IQueryOrderDetailsSV.class);

            QueryOrderDetailsRequest orderDetailsReq = new QueryOrderDetailsRequest();
            orderDetailsReq.setOrderId(Long.valueOf(orderId));
            orderDetailsReq.setChgStateFlag(OrderConstants.STATECHG_FLAG);

            QueryOrderDetailsResponse orderDetailsRes = iQueryOrderDetailsSV.queryOrderDetails(orderDetailsReq);
            ResponseHeader resHeader = orderDetailsRes.getResponseHeader();
            LOGGER.info("订单详细信息 ：" + JSONObject.toJSONString(orderDetailsRes));
            //如果返回值为空,或返回信息中包含错误信息,返回失败
            if (orderDetailsRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
                return "customerOrder/orderError";
            }
//  getProdLevels  返回的是id,前台把 id转成对应的 中英文文字。    
//          ("100110", "陪同翻译");("100120", "交替传译");("100130", "同声翻译");
//          ("100210", "标准级");("100220", "专业级");("100230", "出版级");
            uiModel.addAttribute("OrderDetails", orderDetailsRes);
        } catch (Exception e) {
            LOGGER.error("查询订单详情失败:",e);
            return "transOrder/orderError";
        }
        return "customerOrder/orderInfo";
    }
    
    /**
     * 文档订单详细页面 下载文件
     * @param fileId
     * @param request
     * @param response
     * @author mimw
     */
    @RequestMapping("/download")
    public void download(String fileId, String fileName, HttpServletRequest request,
            HttpServletResponse response) {
        IDSSClient client = DSSClientFactory.getDSSClient(Constants.IPAAS_ORDER_FILE_DSS);
        byte[] b = client.read(fileId);
    
        try {

            String agent = request.getHeader("User-Agent");
            //不是ie
            if (agent.indexOf("MSIE") == -1 && agent.indexOf("like Gecko")== -1) {
                String newFileName = java.net.URLDecoder.decode(fileName,"utf-8");
                fileName = new String(newFileName.getBytes("utf-8"), "ISO-8859-1");
            }

            OutputStream os = response.getOutputStream();
//            response.setCharacterEncoding("utf-8");
            response.setContentType("multipart/form-data");
            response.setHeader("Content-Disposition", "attachment;fileName="+fileName);
            response.setHeader("Content-Length", b.length+"");
            os.write(b);
            os.close();
        } catch (Exception e) {
           LOGGER.info("下载文件异常：", e);
        }
    }
}
