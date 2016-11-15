package com.ai.yc.protal.web.controller.user.password;

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
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.Constants.UcenterOperation;
import com.ai.yc.protal.web.utils.PasswordMD5Util.Md5Utils;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
import com.ai.yc.ucenter.api.members.param.base.ResponseCode;
import com.ai.yc.ucenter.api.members.param.editpass.UcMembersEditPassRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetResponse;
import com.alibaba.fastjson.JSON;

@RequestMapping("/password")
@RestController
public class PasswordController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(PasswordController.class);
	@Autowired
	ResWebBundle rb;

	@RequestMapping("/passwordPager")
	public ModelAndView toInterpreterBaseInfo() {
		/*
		 * IUcMembersSV ucMembersSV = DubboConsumerFactory
		 * .getService(IUcMembersSV.class); UcMembersGetRequest
		 * membersGetRequest = new UcMembersGetRequest();
		 * membersGetRequest.setUsername("18518162319");
		 * membersGetRequest.setGetmode("0"); UcMembersGetResponse getResponse =
		 * ucMembersSV .ucGetMember(membersGetRequest); Map<String, Object>
		 * model = new HashMap<String, Object>(); model.put("data",
		 * getResponse);
		 */
		return new ModelAndView("/user/password/password-start");
	}

	@RequestMapping("/checkAccountInfo")
	@ResponseBody
	public ResponseData<Map<Object,Object>> checkAccountInfo(String account) {
		ResponseData<Map<Object,Object>> responseData = null;
		ResponseHeader header = null;
		try {
			IUcMembersSV ucMembersSV = DubboConsumerFactory
					.getService(IUcMembersSV.class);
			UcMembersGetRequest membersGetRequest = new UcMembersGetRequest();
			membersGetRequest.setUsername(account);
			membersGetRequest.setGetmode("4");
			UcMembersGetResponse getResponse = ucMembersSV
					.ucGetMember(membersGetRequest);
			Map getDate = getResponse.getDate();
			if (getDate == null) {
				header = new ResponseHeader(false, Constants.ERROR_CODE, "失败");
				responseData = new ResponseData<Map<Object,Object>>(
						ResponseData.AJAX_STATUS_FAILURE, "失败", null);
				
			} else {
				header = new ResponseHeader(true, Constants.SUCCESS_CODE, "成功");
				responseData = new ResponseData<Map<Object,Object>>(
						ResponseData.AJAX_STATUS_SUCCESS, "成功", null);
			}
			responseData.setResponseHeader(header);
			responseData.setData(getDate);
		} catch (Exception e) {
			LOGGER.error(e.getMessage(),e);
			header = new ResponseHeader(false, Constants.ERROR_CODE, "失败");
			responseData = new ResponseData<Map<Object,Object>>(
					ResponseData.AJAX_STATUS_FAILURE, "失败", null);
			responseData.setResponseHeader(header);
		}
		return responseData;
	}

	/**
	 * 修改密码
	 */
	@RequestMapping("/updatePassword")
	@ResponseBody
	public ResponseData<Boolean> updatePassword(HttpServletRequest request,
			UcMembersEditPassRequest passRequest) {
		String msg = "error";
		boolean isOK = false;

		try {
			if (passRequest.getUid() == null) {// 修改密码uid无需传值
				passRequest.setUid(Integer.parseInt(UserUtil.getUserId()));
			}
			passRequest
					.setChecke_mode(UcenterOperation.OPERATION_TYPE_UPDATE_PWD_CODE);
			passRequest.setTenantId(Constants.DEFAULT_TENANT_ID);
			passRequest.setNewpw(Md5Utils.md5(passRequest.getNewpw()));
			IUcMembersSV ucMembersSV = DubboConsumerFactory
					.getService(IUcMembersSV.class);
			UcMembersResponse res = ucMembersSV.ucEditPassword(passRequest);
			ResponseCode responseCode = res == null ? null : res.getCode();
			Integer codeNumber = responseCode == null ? null : responseCode
					.getCodeNumber();
			if (codeNumber != null && codeNumber == 1) {// 成功
				msg = "ok";
				isOK = true;
			} else {
				msg = responseCode.getCodeMessage();
				LOGGER.error(JSON.toJSONString(res));
			}

		} catch (Exception e) {
			LOGGER.error(e.getMessage(), e);
		}
		ResponseData<Boolean> responseData = new ResponseData<Boolean>(
				ResponseData.AJAX_STATUS_SUCCESS, msg, isOK);
		return responseData;
	}
}
