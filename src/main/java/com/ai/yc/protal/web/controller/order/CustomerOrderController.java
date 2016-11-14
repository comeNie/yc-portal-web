package com.ai.yc.protal.web.controller.order;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ai.opt.sdk.util.DateUtil;
import com.ai.slp.balance.api.deduct.interfaces.IDeductSV;
import com.ai.slp.balance.api.deduct.param.DeductParam;
import com.ai.slp.balance.api.deduct.param.DeductResponse;
import com.ai.slp.balance.api.deduct.param.ForegiftDeduct;
import com.ai.yc.order.api.orderfee.param.OrderFeeInfo;
import com.ai.yc.order.api.orderfee.param.OrderFeeQueryResponse;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.model.pay.AccountBalanceInfo;
import com.ai.yc.protal.web.service.BalanceService;
import com.ai.yc.protal.web.service.OrderService;
import com.ai.yc.protal.web.utils.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.hadoop.fs.DF;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.yc.order.api.orderclose.interfaces.IOrderCancelSV;
import com.ai.yc.order.api.orderclose.param.OrderCancelRequest;
import com.ai.yc.order.api.orderdetails.interfaces.IQueryOrderDetailsSV;
import com.ai.yc.order.api.orderdetails.param.ContactsVo;
import com.ai.yc.order.api.orderdetails.param.OrderFeeVo;
import com.ai.yc.order.api.orderdetails.param.OrderStateChgVo;
import com.ai.yc.order.api.orderdetails.param.ProdExtendVo;
import com.ai.yc.order.api.orderdetails.param.ProdLevelVo;
import com.ai.yc.order.api.orderdetails.param.ProdVo;
import com.ai.yc.order.api.orderdetails.param.QueryOrderDetailsResponse;
import com.ai.yc.order.api.orderfee.param.OrderFeeInfo;
import com.ai.yc.order.api.orderfee.param.OrderFeeQueryResponse;
import com.ai.yc.order.api.orderquery.interfaces.IOrderQuerySV;
import com.ai.yc.order.api.orderquery.param.OrdOrderVo;
import com.ai.yc.order.api.orderquery.param.OrdProdExtendVo;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountResponse;
import com.ai.yc.order.api.orderquery.param.QueryOrderRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrderRsponse;
import com.ai.yc.order.api.ordersubmission.interfaces.IOrderSubmissionSV;
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
    /**
     * 我的订单,订单列表
     * @return
     */
    @RequestMapping("/list/view")
    public String orderListView(Model uiModel){
        //查询 订单数量
        //待支付数量
        try {
            String userId = UserUtil.getUserId();
            IOrderQuerySV iOrderQuerySV = DubboConsumerFactory.getService(IOrderQuerySV.class);
            QueryOrdCountRequest ordCountReq = new QueryOrdCountRequest();
            ordCountReq.setUserId(userId);
            
            //待支付
            ordCountReq.setDisplayFlag("11");
            QueryOrdCountResponse ordCountRes = iOrderQuerySV.queryOrderCount(ordCountReq);
            uiModel.addAttribute("UnPaidCount", ordCountRes.getCountNumber());
            
            //翻译中
            ordCountReq.setDisplayFlag("23");
            ordCountRes = iOrderQuerySV.queryOrderCount(ordCountReq);
            uiModel.addAttribute("TranslateCount", ordCountRes.getCountNumber());
            
            //待确认
            ordCountReq.setDisplayFlag("50");
            ordCountRes = iOrderQuerySV.queryOrderCount(ordCountReq);
            uiModel.addAttribute("UnConfirmCount", ordCountRes.getCountNumber());
            
            //待评价
            ordCountReq.setDisplayFlag("52");
            ordCountRes = iOrderQuerySV.queryOrderCount(ordCountReq);
            uiModel.addAttribute("UnEvaluateCount", ordCountRes.getCountNumber());
        } catch (Exception e) {
            LOGGER.error("查询订单数量:",e);
        }
            
        return "customerOrder/orderList";
    }
    
    @RequestMapping("/orderList")
    @ResponseBody
    public ResponseData<PageInfo<OrdOrderVo> > orderList(HttpServletRequest request){
        ResponseData<PageInfo<OrdOrderVo> > resData = new ResponseData<PageInfo<OrdOrderVo> >(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        String disFlag = request.getParameter("disFlag");
        String displayFlag = request.getParameter("displayFlag");
        String orderTimeStart = request.getParameter("orderTimeStart");
        String stateChgTimeEnd = request.getParameter("stateChgTimeEnd");
        String translateName = request.getParameter("translateName");
        String translateType = request.getParameter("translateType");
        String pageNo = request.getParameter("pageNo");
        String pageSize = request.getParameter("pageSize");
        
//        try {
//            QueryOrderRequest orderReq = new QueryOrderRequest();
//            IOrderQuerySV iOrderQuerySV = DubboConsumerFactory.getService(IOrderQuerySV.class);
//            QueryOrderRsponse orderRes = iOrderQuerySV.queryOrder(orderReq);
//            ResponseHeader resHeader = orderRes.getResponseHeader();
//            //如果返回值为空,或返回信息中包含错误信息,返回失败
//            if (orderRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
//            } else {
//                //返回订单分页信息
//                resData.setData(orderRes);
//            }
//        } catch (Exception e) {
//            LOGGER.error("查询订单分页失败:",e);
//            resData = new ResponseData<QueryOrderRsponse>(ResponseData.AJAX_STATUS_FAILURE, "查询订单失败");
//        }
        
        QueryOrderRsponse orderRes = new QueryOrderRsponse();
        PageInfo<OrdOrderVo> pageInfo = new  PageInfo<OrdOrderVo>();
        pageInfo.setCount(8);
        pageInfo.setPageCount(1);
        pageInfo.setPageNo(1);
        pageInfo.setPageSize(10);
        
        List<OrdOrderVo> orderLisst = new ArrayList<>();
        
        OrdOrderVo order = new OrdOrderVo();
        order.setOrderId((long) 20141111);
        order.setBusiType("0");
        order.setOrderTime(new Timestamp(System.currentTimeMillis()));
        order.setTranslateName("翻译主题");
        order.setUserName("王五");
        order.setTotalFee(1001);
        /**
         * 客户端显示状态
         * 11：待支付
         *13：待报价
         *23：翻译中
         *50：待确认
         *52：待评价
         *90：完成
         *91：关闭（取消）
         *92：已退款
         */
        order.setDisplayFlag(displayFlag); 
        List<OrdProdExtendVo> ordProdExtendList = new ArrayList<>();
        OrdProdExtendVo ordProdExtendVo = new OrdProdExtendVo();
        ordProdExtendVo.setLangungePair("1");
        ordProdExtendVo.setLangungePairChName("中-英");
        ordProdExtendVo.setLangungePairEnName("en-ch");
        ordProdExtendList.add(ordProdExtendVo);
        order.setOrdProdExtendList(ordProdExtendList);
        
        orderLisst.add(order);
        pageInfo.setResult(orderLisst);
        orderRes.setPageInfo(pageInfo);
        resData.setData(orderRes.getPageInfo());
        
        return resData;
    }
    
    @RequestMapping("/cancelOrder")
    @ResponseBody
    public ResponseData<String> cancelOrder(String orderId) {
        ResponseData<String> resData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,"OK");

//        try {
//            IOrderCancelSV iOrderCancelSV = DubboConsumerFactory.getService(IOrderCancelSV.class);
//            OrderCancelRequest cancelReq = new OrderCancelRequest();
//            cancelReq.setOrderId(Long.valueOf(orderId));
//            BaseResponse baseRes = iOrderCancelSV.handCancelNoPayOrder(cancelReq);
//            ResponseHeader resHeader = baseRes.getResponseHeader();
//            //如果返回值为空,或返回信息中包含错误信息,返回失败
//            if (baseRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
//                resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,"取消订单失败");
//            } else {
//                resData.setData("取消成功");
//             }
//        } catch(Exception e) {
//            LOGGER.error("取消订单失败：", e);
//            resData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE,"取消订单失败");
//        }
        
        return resData;
    }

     /**
     * 支付页面
     * @return
     */
    @RequestMapping("/payOrder/{orderId}")
    public String createTextView(@PathVariable("orderId") Long orderId,String unit,Model uiModel){
        //TODO... 模拟数据
//        IOrderFeeQuerySV iOrderFeeQuerySV = DubboConsumerFactory.getService(IOrderFeeQuerySV.class);
//        OrderFeeQueryRequest feeQueryRequest = new OrderFeeQueryRequest();
//        feeQueryRequest.setOrderId(orderId);
//        OrderFeeQueryResponse feeQueryResponse = iOrderFeeQuerySV.orderFeeQuery(feeQueryRequest);


        OrderFeeQueryResponse feeQueryResponse = new OrderFeeQueryResponse();
        OrderFeeInfo orderFeeInfo = new OrderFeeInfo();
        //获取订单价格,币种
        feeQueryResponse.setOrderFeeInfo(orderFeeInfo);
        //模拟币种
        orderFeeInfo.setCurrencyUnit(unit);
        //总费用
        orderFeeInfo.setTotalFee(100000l);

        //若是人民币,需要获取账户余额
        if(Constants.CURRENCTY_UNIT_RMB.equals(orderFeeInfo.getCurrencyUnit())){
            AccountBalanceInfo balanceInfo = balanceService.queryOfUser();
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
        return "order/payOrder";
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
        //TODO... 模拟数据
//        IDeductSV deductSV = DubboConsumerFactory.getService(IDeductSV.class);
//        DeductResponse deductResponse = deductSV.deductFund(deductParam);
        DeductResponse deductResponse = new DeductResponse();
        deductResponse.setSerialNo("123123");
        ResponseHeader responseHeader = deductResponse.getResponseHeader();
        //支付结果,默认为失败
        boolean payResult = false;
        //扣款成功,同步订单状态
        if (responseHeader==null||responseHeader.isSuccess()){
            orderService.orderPayProcessResult(userId,Long.parseLong(deductParam.getExternalId()),orderType,
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
    public void gotoPay(
            String orderId,Long orderAmount,String currencyUnit,String merchantUrl,String payOrgCode,
            String orderType,
            HttpServletResponse response)
            throws Exception {
        //租户
        String tenantId= ConfigUtil.getProperty("TENANT_ID");
        //服务异步通知地址
        String notifyUrl= ConfigUtil.getProperty("NOTIFY_URL")+"/"+orderType+"/"+ UserUtil.getUserId();

        //异步通知地址,默认为用户
        String amount = String.valueOf(AmountUtil.changeLiToYuan(orderAmount));
        Map<String, String> map = new HashMap<String, String>();
        map.put("tenantId", tenantId);//租户ID
        map.put("orderId", orderId);//请求单号
        map.put("returnUrl", ConfigUtil.getProperty("RETURN_URL"));//页面跳转地址
        map.put("notifyUrl", notifyUrl);//服务异步通知地址
        map.put("merchantUrl",merchantUrl);//用户付款中途退出返回商户的地址
        map.put("requestSource", Constants.SELF_SOURCE);//终端来源
        map.put("currencyUnit",currencyUnit);//币种
        map.put("orderAmount", amount);//金额
        map.put("subject", "orderPay");//订单名称
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
        LOGGER.info("发起支付申请:" + htmlStr);
        response.setStatus(HttpServletResponse.SC_OK);
        response.getWriter().write(htmlStr);
        response.getWriter().flush();
    }

    /**
     * 显示订单详情
     * @param orderId
     * @param uiModel
     * @return
     */
    @RequestMapping("/{orderId}")
    public String orderInfoView(@PathVariable("orderId") String orderId,String displayFlag, Model uiModel){
        
        //返回失败
        if (StringUtils.isEmpty(orderId)) {
        }
        
//        try {
//            IQueryOrderDetailsSV iQueryOrderDetailsSV = DubboConsumerFactory.getService(IQueryOrderDetailsSV.class);
//            QueryOrderDetailsResponse orderDetailsRes = iQueryOrderDetailsSV.queryOrderDetails(Long.valueOf(orderId));
//            
//            ResponseHeader resHeader = orderDetailsRes.getResponseHeader();
//            //如果返回值为空,或返回信息中包含错误信息,返回失败
//            if (orderDetailsRes==null|| (resHeader!=null && (!resHeader.isSuccess()))){
//            }
//            uiModel.addAttribute("OrderDetails", orderDetailsRes);
//        } catch (Exception e) {
//            LOGGER.error("查询订单详情失败:",e);
//        }
        QueryOrderDetailsResponse orderDetailsRes = new QueryOrderDetailsResponse();
        ProdVo prod = new ProdVo();
        prod.setNeedTranslateInfo("需要翻译的内容");
        prod.setTranslateInfo("翻译结果");
        prod.setUseCn("用途名");
        prod.setFieldCn("领域名");
        prod.setTakeTime("20"); //预计翻译耗时 小时
        prod.setIsUrgent("1"); //加急
        prod.setIsSetType("1"); //排版
        orderDetailsRes.setProd(prod);
        
        orderDetailsRes.setRemark("速度翻译");//备注
        orderDetailsRes.setOrderId(Long.valueOf(orderId));
        orderDetailsRes.setTranslateName("翻译主题");
        orderDetailsRes.setOrderTime(new Timestamp(System.currentTimeMillis()));//下单时间
        orderDetailsRes.setDisplayFlag(displayFlag);
        
        List<ProdExtendVo> prodExtendVos = new ArrayList<>();
        ProdExtendVo prodExtendVo =  new ProdExtendVo();
        prodExtendVo.setLangungePair("1");
        prodExtendVo.setLangungeNameEn("en-ch");
        prodExtendVo.setLangungePairName("英-中");
        prodExtendVos.add(prodExtendVo);
        orderDetailsRes.setProdExtends(prodExtendVos);
        
        List<ProdLevelVo> prodLevels = new ArrayList<>();
        ProdLevelVo prodLevelVo = new ProdLevelVo();
        prodLevelVo.setTranslateLevel("1");
        prodLevels.add(prodLevelVo);
        orderDetailsRes.setProdLevels(prodLevels);
        
        OrderFeeVo orderFeeVo = new OrderFeeVo();
        orderFeeVo.setCurrencyUnit("1");//1：RMB 2：$
        orderFeeVo.setPaidFee((long) 100);
        orderFeeVo.setDiscountFee((long) 10);
        orderDetailsRes.setOrderFee(orderFeeVo);
      
        ContactsVo contact = new ContactsVo();
        contact.setContactName("王五");
        contact.setContactTel("+86 13844987323");
        contact.setContactEmail("1231@qq.com");
        orderDetailsRes.setContacts(contact);
        
        List<OrderStateChgVo> chgList = new ArrayList<>();
        OrderStateChgVo stateChgVo = new OrderStateChgVo();
        stateChgVo.setStateChgTime(new Timestamp(System.currentTimeMillis()));
        stateChgVo.setChgDesc("订单已被译员领取，正在翻译中，请耐心等待");
        chgList.add(stateChgVo);
        orderDetailsRes.setOrderStateChgs(chgList);
       
        uiModel.addAttribute("OrderDetails", orderDetailsRes);
        return "customerOrder/orderInfo";
    }
}
