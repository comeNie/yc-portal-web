package com.ai.yc.protal.web.controller.lspbill;

import com.ai.opt.base.vo.PageInfo;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;

import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.slp.balance.api.incomeoutquery.interfaces.IncomeOutQuerySV;
import com.ai.slp.balance.api.incomeoutquery.param.FundBookQueryResponse;
import com.ai.slp.balance.api.incomeoutquery.param.IncomeDetail;
import com.ai.slp.balance.api.incomeoutquery.param.IncomeQueryRequest;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.model.pay.AccountBalanceInfo;
import com.ai.yc.protal.web.service.BalanceService;
import com.ai.yc.protal.web.utils.*;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 我的帐户
 * Created by lixiaokui on 16/11/14.
 */
@Controller
@RequestMapping("/p/lspbill")
public class LSPBillController {
    private static final Logger LOGGER = LoggerFactory.getLogger(LSPBillController.class);
    @Autowired
    BalanceService balanceService;
    @Autowired
    ResWebBundle rb;

    /**
     * 显示LSPBill账单页面
     * @return
     */
    @RequestMapping("/toLspBill")
    public String toLspBill(Model uiModel){

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date beginDate = new Date();
        beginDate.setMonth(beginDate.getMonth()-1);
        String date1 = formatter.format(beginDate);
        Date endDate = new Date();
        endDate.setMonth(endDate.getMonth());
        String date2 = formatter.format(endDate);

        uiModel.addAttribute("beginTime",date1);
        uiModel.addAttribute("endTime",date2);
        return "lspBill/lspBill";
    }

    @RequestMapping("/lspBillList")
    @ResponseBody
    public ResponseData<PageInfo<IncomeDetail>> lspBillList(IncomeQueryRequest incomeQueryRequest,
                                                            @RequestParam(value = "pageNo")int pageNO,
                                                            @RequestParam(value = "pageSize")int pageSize){
        ResponseData<PageInfo<IncomeDetail>> resData =
                new ResponseData<PageInfo<IncomeDetail>>(ResponseData.AJAX_STATUS_SUCCESS,"OK");
        AccountBalanceInfo balanceInfo =  balanceService.queryOfUser(UserUtil.getUserId());
        IncomeOutQuerySV incomeOutQuerySV =  DubboConsumerFactory.getService(IncomeOutQuerySV.class);
        incomeQueryRequest.setAccountId(12781);//TODO 调用lsp帐户即可

        incomeQueryRequest.setTenantId(Constants.DEFAULT_TENANT_ID);
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        try
        {
            if(StringUtils.isBlank(incomeQueryRequest.getBeginDate())){
                Date beginDate = new Date();
                beginDate.setMonth(beginDate.getMonth()-1);
                String date1 = formatter.format(beginDate);
                incomeQueryRequest.setBeginDate(date1+" 00:00:00");
            } else {
                incomeQueryRequest.setBeginDate(incomeQueryRequest.getBeginDate().toString()+" 00:00:00");
            }
            if(StringUtils.isBlank(incomeQueryRequest.getEndDate())){
                Date endDate = new Date();
                endDate.setMonth(endDate.getMonth());
                String date1 = formatter.format(endDate);
                incomeQueryRequest.setEndDate(date1+" 23:59:59");
            }else {
                incomeQueryRequest.setEndDate(incomeQueryRequest.getEndDate().toString()+" 23:59:59");
            }
            FundBookQueryResponse fundBookQueryResponse = new FundBookQueryResponse();
            PageInfo<IncomeDetail> pageInfo = new  PageInfo<IncomeDetail>();
            pageInfo.setPageNo(pageNO);
            pageInfo.setPageSize(pageSize);
            incomeQueryRequest.setPageInfo(pageInfo);
            fundBookQueryResponse = incomeOutQuerySV.incomeOutQuery(incomeQueryRequest);
            //总收支计算
            IncomeQueryRequest incomeQueryByDate = new IncomeQueryRequest();
            incomeQueryByDate.setTenantId(incomeQueryRequest.getTenantId());
            incomeQueryByDate.setAccountId(incomeQueryRequest.getAccountId());
            incomeQueryByDate.setBeginDate(incomeQueryRequest.getBeginDate());
            incomeQueryByDate.setEndDate(incomeQueryRequest.getEndDate());
            FundBookQueryResponse fundBookQueryResponseByDate = new FundBookQueryResponse();
            incomeQueryRequest.setPageInfo(pageInfo);
            fundBookQueryResponseByDate = incomeOutQuerySV.incomeOutQuery(incomeQueryByDate);
            Long incomeAmount = 0l;
            long outAmount = 0l;
            if (fundBookQueryResponse.getPageInfo()!=null){
                List<IncomeDetail> incomeDetails = fundBookQueryResponseByDate.getPageInfo().getResult();
                for (IncomeDetail incomeDetail:incomeDetails){
                    if (incomeDetail.getIncomeFlag().equals("1")){
                        incomeAmount = incomeAmount + incomeDetail.getTotalAmount();
                    }
                    if (incomeDetail.getIncomeFlag().equals("0")){
                        outAmount = outAmount + incomeDetail.getTotalAmount();
                    }
                }
                for (int i = 0;i<fundBookQueryResponse.getPageInfo().getResult().size();i++){
                    fundBookQueryResponse.getPageInfo().getResult().get(i).setIncomeBalance(incomeAmount);
                    fundBookQueryResponse.getPageInfo().getResult().get(i).setOutBalance(Math.abs(outAmount));
                }

            }else {
                IncomeDetail incomeDetail = new IncomeDetail();
                incomeDetail.setIncomeBalance(incomeAmount);
                incomeDetail.setOutBalance(outAmount);
                List<IncomeDetail> list = new ArrayList<>();
                list.add(incomeDetail);
                pageInfo.setResult(list);
                fundBookQueryResponse.setPageInfo(pageInfo);
            }
            resData.setData(fundBookQueryResponse.getPageInfo());
        } catch (Exception e) {
            LOGGER.error("查询收支分页失败:",e);
            resData = new ResponseData<PageInfo<IncomeDetail>>(ResponseData.AJAX_STATUS_FAILURE, "查询收支失败");
        }
        return resData;
    }





}
