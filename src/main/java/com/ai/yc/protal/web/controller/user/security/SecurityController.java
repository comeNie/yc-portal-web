package com.ai.yc.protal.web.controller.user.security;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.StringUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.model.sso.GeneralSSOClientUser;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
import com.ai.yc.ucenter.api.members.param.base.ResponseCode;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckEmailRequest;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckeMobileRequest;
import com.ai.yc.ucenter.api.members.param.editemail.UcMembersEditEmailRequest;
import com.ai.yc.ucenter.api.members.param.editmobile.UcMembersEditMobileRequest;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.alibaba.fastjson.JSON;

/**
 * 帐号安全设置<br>
 * Date: 2016年11月7日 <br>
 * Copyright (c) 2016 asiainfo.com <br>
 * 
 * @author xuyw
 */
@RequestMapping("p/security")
@Controller
public class SecurityController {
	private static final Logger LOG = LoggerFactory
			.getLogger(SecurityController.class);
	private static final String INIT = "user/security/seccenter";
	private static final String UPDATE_PASSWORD = "user/security/updatePassword";
	private static final String ERROR_PAGE = "user/error";

	@RequestMapping("seccenter")
	public ModelAndView init() {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------进入安全设置界面-------");
		}
		Map<String, Object> model = new HashMap<String, Object>();
		// IYCUserServiceSV iYCUserServiceSV =
		// DubboConsumerFactory.getService(IYCUserServiceSV.class);
		SearchYCUserRequest request = new SearchYCUserRequest();
		// request.setUserId("000000000000003211");
		GeneralSSOClientUser userSSOInfo = UserUtil.getSsoUser();
		Boolean isexistemail = true;
		Boolean isexistphone = true;
		Boolean isexistloginpassword = true;
		Boolean isexistpaypassword = true;
		int securitylevel = 0;
		if (StringUtil.isBlank(userSSOInfo.getEmail())) {
			isexistemail = false;
		}

		if (StringUtil.isBlank(userSSOInfo.getMobile())) {
			isexistphone = false;
		}
		if (StringUtil.isBlank(userSSOInfo.getUserId())) {
			ModelAndView modelView = new ModelAndView(ERROR_PAGE);
			return modelView;
		}
		request.setUserId(userSSOInfo.getUserId());
		// YCUserInfoResponse response =
		// iYCUserServiceSV.searchYCUserInfo(request);
		model.put("userinfo", userSSOInfo);

		// 登录密码exist
		model.put("isexistloginpassword", isexistpaypassword);
		// 邮箱exist
		model.put("isexistemail", isexistemail);
		// 手机exist
		model.put("isexistphone", isexistphone);
		// 支付密码exist
		model.put("isexistpaypassword", isexistloginpassword);

		if (isexistemail == true) {
			securitylevel += 25;
		}
		if (isexistphone == true) {
			securitylevel += 25;
		}
		if (isexistloginpassword == true) {
			securitylevel += 25;
		}
		if (isexistpaypassword == true) {
			securitylevel += 25;
		}

		// sec level
		model.put("securitylevel", securitylevel);

		ModelAndView modelView = new ModelAndView(INIT, model);
		return modelView;
	}

	@RequestMapping("updatePassword")
	public ModelAndView updatePassword() {
		ModelAndView modelView = new ModelAndView(UPDATE_PASSWORD);
		modelView.addObject("user", UserUtil.getSsoUser());
		return modelView;
	}

	@RequestMapping("bindEmail")
	public ModelAndView bindEmail() {
		return new ModelAndView("user/security/bindEmail");
	}

	@RequestMapping("bindEmailSuccess")
	public ModelAndView bindEmailSuccess() {
		return new ModelAndView("user/security/bindEmailSuccess");
	}

	@RequestMapping("editEmail")
	public ModelAndView editEmail() {
		Map<String, Object> model = new HashMap<String, Object>();
		UcMembersEditEmailRequest emailRequest = new UcMembersEditEmailRequest();
		emailRequest.setEmail("178070754@qq.com");
		model.put("ucMembersEditEmail", emailRequest);
		return new ModelAndView("user/security/updateEmail", model);
	}

	@RequestMapping("bindPhone")
	public ModelAndView bindPhone() {
		return new ModelAndView("user/security/bindPhone");
	}

	@RequestMapping("editPhone")
	public ModelAndView editPhone() {
		Map<String, Object> model = new HashMap<String, Object>();
		UcMembersEditEmailRequest emailRequest = new UcMembersEditEmailRequest();
		emailRequest.setEmail("178070754@qq.com");
		model.put("UcMembersEditEmail", emailRequest);
		return new ModelAndView("user/security/updateMobilePhone");
	}

	@RequestMapping("updateEmail")
	@ResponseBody
	public String updateEmail() {
		ResponseData<String> responseData = null;
		responseData = new ResponseData<String>(
				ResponseData.AJAX_STATUS_SUCCESS, "修改密码成功", "修改密码成功");
		// IUcMembersSV ucMembersSV =
		// DubboConsumerFactory.getService(IUcMembersSV.class);
		ResponseHeader header = new ResponseHeader();
		header.setIsSuccess(true);
		header.setResultCode(Constants.SUCCESS_CODE);
		responseData.setResponseHeader(header);
		return JSON.toJSONString(responseData);
	}

	@RequestMapping("updatePhone")
	@ResponseBody
	public ResponseData<Boolean> updatePhone(@RequestParam("phone") String phone,
			@RequestParam("code") String code, @RequestParam("type") String type) {
		String msg = "error";
		boolean isOK = false;
		try {
			UcMembersEditMobileRequest req = new UcMembersEditMobileRequest();
			req.setTenantId(Constants.DEFAULT_TENANT_ID);
			req.setOperationcode(code);
			req.setMobilephone(phone);
			req.setUid(Integer.parseInt(UserUtil.getUserId()));

			IUcMembersSV iUcMembersSV = DubboConsumerFactory
					.getService(IUcMembersSV.class);
			UcMembersResponse res = iUcMembersSV.ucEditMobilephone(req);
			ResponseCode responseCode = res == null ? null : res.getCode();
			Integer codeNumber = responseCode == null ? null : responseCode
					.getCodeNumber();
			LOG.info("--------绑定手机返回 :" + JSON.toJSONString(res));
			if (codeNumber != null && codeNumber == 1) {
				isOK = true;
				 msg = "ok";
			} else {
				msg = responseCode.getCodeMessage();
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		ResponseData<Boolean> responseData = new ResponseData<Boolean>(
				ResponseData.AJAX_STATUS_SUCCESS, msg, isOK);
		return responseData;
	}

	/**
	 * 校验邮箱或手机
	 */
	@RequestMapping("/checkPhoneOrEmail")
	@ResponseBody
	public ResponseData<Boolean> checkPhoneOrEmail(HttpServletRequest request) {
		try {
			String checkType = request.getParameter("checkType");
			String checkVal = request.getParameter("checkVal");
			String msg = "帐号已存在";
			Boolean canUse = checkPhoneOrEmail(checkType, checkVal);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					msg, canUse);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_FAILURE,
					"error");
		}
	}

	/**
	 * 校验手机或邮箱可用
	 */
	private Boolean checkPhoneOrEmail(String checkType, String checkVal) {
		UcMembersResponse res = null;
		try {
			IUcMembersSV sv = DubboConsumerFactory
					.getService(IUcMembersSV.class);
			if (Register.CHECK_TYPE_EMAIL.equals(checkType)) {// 邮箱校验
				UcMembersCheckEmailRequest emailReq = new UcMembersCheckEmailRequest();
				emailReq.setEmail(checkVal);
				emailReq.setTenantId(Constants.DEFAULT_TENANT_ID);
				res = sv.ucCheckeEmail(emailReq);
				LOG.info("校验邮箱返回：" + JSON.toJSONString(res));
			}
			if (Register.CHECK_TYPE_PHONE.equals(checkType)) {// 手机校验
				UcMembersCheckeMobileRequest phoneReq = new UcMembersCheckeMobileRequest();
				phoneReq.setTenantId(Constants.DEFAULT_TENANT_ID);
				phoneReq.setMobilephone(checkVal);
				res = sv.ucCheckeMobilephone(phoneReq);
				LOG.info("校验手机返回：" + JSON.toJSONString(res));
			}
		} catch (Exception e) {
			LOG.info(e.getMessage(), e);
		}
		if (res != null && res.getMessage() != null
				&& res.getMessage().isSuccess() && res.getCode() != null
				&& res.getCode().getCodeNumber() != null
				&& res.getCode().getCodeNumber() == 1) {
			return true;
		}
		return false;
	}

}
