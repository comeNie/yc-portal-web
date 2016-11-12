package com.ai.yc.protal.web.controller.user.password;


import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.components.ccs.CCSClientFactory;
import com.ai.opt.sdk.components.mcs.MCSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.StringUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.ccs.IConfigClient;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.model.mail.SendEmailRequest;
import com.ai.yc.protal.web.utils.IPUtil;
import com.ai.yc.protal.web.utils.MD5Util;
import com.ai.yc.protal.web.utils.VerifyUtil;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.editpass.UcMembersEditPassRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetResponse;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetResponse.UcMembersGetDate;
import com.alibaba.fastjson.JSON;
import org.apache.commons.lang.ObjectUtils;

@RequestMapping("/password")
@RestController
public class PasswordController {
	
private static final Logger LOGGER = LoggerFactory.getLogger(PasswordController.class);
	@Autowired
	ResWebBundle rb;
	@RequestMapping("/passwordPager")
	public ModelAndView toInterpreterBaseInfo(){
		 IUcMembersSV ucMembersSV = DubboConsumerFactory.getService(IUcMembersSV.class);
         UcMembersGetRequest membersGetRequest = new UcMembersGetRequest();
         membersGetRequest.setUsername("18518162319");
         membersGetRequest.setGetmode("0");
         UcMembersGetResponse getResponse = ucMembersSV.ucGetMember(membersGetRequest);
         Map<String, Object> model = new HashMap<String, Object>();
         model.put("data", getResponse);
		 return new ModelAndView("/user/password/password-start",model);
	}
	
	@RequestMapping("/checkAccountInfo")
	public String checkAccountInfo(String account){
		ResponseData<String> responseData = null;
        ResponseHeader header = null;
        IUcMembersSV ucMembersSV = DubboConsumerFactory.getService(IUcMembersSV.class);
        UcMembersGetRequest membersGetRequest = new UcMembersGetRequest();
        membersGetRequest.setUsername(account);
        membersGetRequest.setGetmode("0");
        UcMembersGetResponse getResponse = ucMembersSV.ucGetMember(membersGetRequest);
//        UcMembersGetDate getDate = getResponse.getDate();
//        if(getDate==null){
//        	 header = new ResponseHeader(false, Constants.ERROR_CODE, "失败");
//             responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, "失败", null);
//             responseData.setResponseHeader(header);
//        }else{
//        	 header = new ResponseHeader(true, Constants.SUCCESS_CODE, "成功");
//             responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "成功", null);
//             responseData.setResponseHeader(header);
//        }
        header = new ResponseHeader(true, Constants.SUCCESS_CODE, "成功");
        responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "成功", null);
        responseData.setResponseHeader(header);
//        responseData.setData(JSON.toJSONString(getDate));
        return JSON.toJSONString(responseData);
	}
	
    
    /**
     * 修改密码
     */
    @RequestMapping("/updatePassword")
    @ResponseBody
    public ResponseData<String> updatePassword(HttpServletRequest request, UcMembersEditPassRequest passRequest) { 
    	 ResponseData<String> responseData = null;
    	 responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "修改密码成功", "修改密码成功");
    	 IUcMembersSV ucMembersSV = DubboConsumerFactory.getService(IUcMembersSV.class);
    	 passRequest.setNewpw(MD5Util.MD5(passRequest.getNewpw()));
    	 ucMembersSV.ucEditPassword(passRequest);
    	 ResponseHeader header = new ResponseHeader();
         header.setIsSuccess(true);
         header.setResultCode(Constants.SUCCESS_CODE);
         responseData.setResponseHeader(header);
         
    	 return responseData;
    }
}
