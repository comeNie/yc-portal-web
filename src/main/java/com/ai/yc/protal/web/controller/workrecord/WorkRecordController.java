package com.ai.yc.protal.web.controller.workrecord;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.BeanUtils;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.yc.order.api.orderquery.interfaces.IOrderQuerySV;
import com.ai.yc.order.api.orderquery.param.RecoedCountInfo;
import com.ai.yc.order.api.orderquery.param.RecordOrderRequest;
import com.ai.yc.order.api.orderquery.param.RecordOrderResponse;
import com.ai.yc.order.api.orderquery.param.RecordOrderVo;
import com.ai.yc.protal.web.controller.order.CustomerOrderController;
import com.ai.yc.protal.web.model.OrderPageResParam;

public class WorkRecordController {
	private static final Logger LOGGER = LoggerFactory.getLogger(CustomerOrderController.class);
	
	
	/**
	 * 工作记录页面
	 * 
	 * @return
	 */
	@RequestMapping("/workRecord")
	public String orderOffer() {
		return "workrecord/interperWorkRecord";
	}
	
	
	/**
     * 工作记录信息查询
     */
    @RequestMapping("/getRecordPageData")
    @ResponseBody
    public ResponseData<PageInfo<OrderPageResParam>> getList(HttpServletRequest request,RecordOrderRequest ordReq)throws Exception{
    	ResponseData<PageInfo<OrderPageResParam>> responseData = null;
    	List<OrderPageResParam> resultList = new ArrayList<OrderPageResParam>();
    	PageInfo<OrderPageResParam> resultPageInfo  = new PageInfo<OrderPageResParam>();
	    try{
	    
			String strPageNo=(null==request.getParameter("pageNo"))?"1":request.getParameter("pageNo");
		    String strPageSize=(null==request.getParameter("pageSize"))?"10":request.getParameter("pageSize");
		    ordReq.setPageNo(Integer.parseInt(strPageNo));
		    ordReq.setPageSize(Integer.parseInt(strPageSize));
		    IOrderQuerySV orderQuerySV = DubboConsumerFactory.getService(IOrderQuerySV.class);
		    RecordOrderResponse orderListResponse = orderQuerySV.queryRecordOrder(ordReq);
			if (orderListResponse != null && orderListResponse.getResponseHeader().isSuccess()) {
				PageInfo<RecordOrderVo> pageInfo = orderListResponse.getPageInfo();
				//获取汇总信息
				RecoedCountInfo countInfo = orderListResponse.getCountInfo();
				BeanUtils.copyProperties(resultPageInfo, pageInfo);
				List<RecordOrderVo> orderList = pageInfo.getResult();
				if(!CollectionUtil.isEmpty(orderList)){
					for(RecordOrderVo vo:orderList){
						OrderPageResParam resParam = new OrderPageResParam();
						BeanUtils.copyProperties(resParam, vo);
						resParam.setPlatFeePage(countInfo.getSumPlatFee());
						resParam.setIterperFeePage(countInfo.getSumInterperFee());
						resParam.setTotalFeePage(countInfo.getSumTotalFee());
						resultList.add(resParam);
					}
				}
				resultPageInfo.setResult(resultList);
				responseData = new ResponseData<PageInfo<OrderPageResParam>>(ResponseData.AJAX_STATUS_SUCCESS, "查询成功",resultPageInfo);
			} else {
				responseData = new ResponseData<PageInfo<OrderPageResParam>>(ResponseData.AJAX_STATUS_FAILURE, "查询失败", null);
			}
		} catch (Exception e) {
			LOGGER.error("查询工作记录列表失败：", e);
			responseData = new ResponseData<PageInfo<OrderPageResParam>>(ResponseData.AJAX_STATUS_FAILURE, "查询信息异常", null);
		}
	    return responseData;
    }
}
