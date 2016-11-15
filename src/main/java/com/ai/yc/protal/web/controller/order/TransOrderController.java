package com.ai.yc.protal.web.controller.order;

import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.order.api.orderquery.param.OrdOrderVo;
import com.ai.yc.order.api.orderquery.param.OrdProdExtendVo;
import com.ai.yc.order.api.orderquery.param.QueryOrderRsponse;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.service.CacheServcie;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by liutong on 16/11/15.
 */
@Controller
@RequestMapping("/p/trans/order")
public class TransOrderController {
    @Autowired
    private CacheServcie cacheServcie;
    @Autowired
    ResWebBundle rb;
    /**
     * 订单大厅页面
     * @return
     */
    @RequestMapping("/taskCenter/view")
    public String taskCenterView(Model uiModel){
        //获取译员信息
        String userId = UserUtil.getUserId();
        /* TODO... 模拟数据 */
//        IYCUserServiceSV userServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
//        SearchYCTranslatorSkillListRequest searchYCUserReq = new SearchYCTranslatorSkillListRequest();
//        searchYCUserReq.setTenantId(Constants.DEFAULT_TENANT_ID);
//        searchYCUserReq.setUserId(userId);
//        YCTranslatorSkillListResponse userInfoResponse = userServiceSV.getTranslatorSkillList(searchYCUserReq);
        //包括译员的等级,是否为LSP译员,LSP中的角色,支持的语言对
//        uiModel.addAttribute("lspId",userInfoResponse.getLspId());//lsp标识
//        uiModel.addAttribute("lspRole",userInfoResponse.getLspRole());//lsp角色
//        uiModel.addAttribute("vipLevel",userInfoResponse.getVipLevel());//译员等级
        uiModel.addAttribute("lspId","123");//lsp标识
        uiModel.addAttribute("lspRole","1");//lsp角色
        uiModel.addAttribute("vipLevel","4");//译员等级
        //获取领域,用途
        uiModel.addAttribute("domainList",cacheServcie.getAllDomain(rb.getDefaultLocale()));
        uiModel.addAttribute("purposeList",cacheServcie.getAllPurpose(rb.getDefaultLocale()));
        return "transOrder/taskCenter";
    }

    /**
     * 获得待领取订单信息
     * 领域,用途,订单时间(单位:天),输入内容
     * @param request
     * @return
     */
    @RequestMapping("/taskCenter/info")
    @ResponseBody
    public ResponseData<PageInfo<OrdOrderVo>> taskCenter(HttpServletRequest request){
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
        order.setCurrencyUnit("2");
        order.setRemainingTime(new Timestamp(1000)); //确认剩余时间
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
}
