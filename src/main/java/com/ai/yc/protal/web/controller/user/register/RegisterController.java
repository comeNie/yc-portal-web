package com.ai.yc.protal.web.controller.user.register;

import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.util.RandomUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.constants.Constants.UcenterOperation;
import com.ai.yc.protal.web.model.mail.SendEmailRequest;
import com.ai.yc.protal.web.utils.MD5Util;
import com.ai.yc.protal.web.utils.VerifyUtil;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckEmailRequest;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckeMobileRequest;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersGetOperationcodeRequest;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.InsertYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCInsertUserResponse;
import com.alibaba.fastjson.JSON;

/**
 * 译云注册Controller <br>
 * Date: 2016年11月2日 <br>
 * Copyright (c) 2016 asiainfo.com <br>
 * 
 * @author xuyw
 */
@RequestMapping("/reg")
@Controller
public class RegisterController {
	private static final Logger LOG = LoggerFactory
			.getLogger(RegisterController.class);
	@Autowired
	ResWebBundle rb;
	private static final String REGISTER = "user/register/register";
	private static final String EMAIL = "user/register/sendMail";
	private static final String SUCCESS = "user/register/success";

	@RequestMapping("/toRegister")
	public ModelAndView toRegister() {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------进入注册界面-------");
		}
		ModelAndView modelView = new ModelAndView(REGISTER);
		return modelView;
	}

	/**
	 * 提交注册
	 */
	@RequestMapping(value = "/submitRegister", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData<Boolean> submitRegister(HttpServletRequest request) {
		String msg = rb.getMessage("ycregisterMsg.verificationCodeError");
		ResponseData<Boolean> result = VerifyUtil.checkImageVerifyCode(request,
				msg);
		if (ResponseData.AJAX_STATUS_FAILURE.equals(result.getStatusCode())
				|| !result.getData()) {// 图片验证码校验
			return result;
		}
		InsertYCUserRequest req = bulidRegisterParam(request);
		if (StringUtil.isBlank(req.getMobilePhone())
				&& StringUtil.isBlank(req.getEmail())) {// 手机邮箱均为空
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					rb.getMessage("ycregisterMsg.accountEmpty"), false);
		}
		if (StringUtil.isBlank(req.getPassword())) {// 密码为空
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					rb.getMessage("ycregisterMsg.passwordEmpty"), false);
		}
		if (!StringUtil.isBlank(req.getMobilePhone())
				&& !checkPhoneOrEmail(Register.CHECK_TYPE_PHONE,
						req.getMobilePhone())) {
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					"帐号已存在", false);
		}
		if (!StringUtil.isBlank(req.getEmail())
				&& !checkPhoneOrEmail(Register.CHECK_TYPE_EMAIL, req.getEmail())) {
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					"帐号已存在", false);
		}
		try {
			// 用户名 手机 邮箱校验 昵称 校验
			YCInsertUserResponse res = DubboConsumerFactory.getService(
					IYCUserServiceSV.class).insertYCUser(req);
			ResponseHeader resHeader = res == null ? null : res
					.getResponseHeader();
			if (resHeader != null)
				msg = resHeader.getResultMessage();

			if (resHeader != null && resHeader.isSuccess()) {
				sendRegisterEmaial(res.getUserId(), req.getEmail());
				return new ResponseData<Boolean>(
						ResponseData.AJAX_STATUS_SUCCESS, msg, true);
			}
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					msg, false);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_FAILURE,
					"error", false);
		}

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
	 * 进入邮箱
	 */
	@RequestMapping("/toEmail")
	public ModelAndView toEmail(@RequestParam("email") String email) {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------进入邮箱界面-------");
		}
		ModelAndView modelView = new ModelAndView(EMAIL);
		modelView.addObject("email", email);
		return modelView;
	}

	/**
	 * 注册成功
	 */
	@RequestMapping("/toSuccess")
	public ModelAndView toSuccess(HttpServletRequest request) {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------进入注册成功-------");
		}
		ModelAndView modelView = new ModelAndView(SUCCESS);

		return modelView;
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
	@RequestMapping("emailActivate")
	public String emailActivate() {
		return EMAIL;
	}
	@RequestMapping("test")
	@ResponseBody
	public String test() {
		UcMembersGetOperationcodeRequest req = new UcMembersGetOperationcodeRequest();
		req.setTenantId(Constants.DEFAULT_TENANT_ID);
		req.setOperationtype(UcenterOperation.OPERATION_TYPE_EMAIL_ACTIVATE);
		req.setUid(100058);
		req.setUserinfo("1820025657@qq.com");
		Object[] result =VerifyUtil.getUcenterOperationCode(req);
		return JSON.toJSONString(result);
	}

	/**
	 * 发送验证邮件
	 */
	private boolean sendRegisterEmaial(String userId, String email) {
		if (!StringUtil.isBlank(email)) {
			UcMembersGetOperationcodeRequest req = new UcMembersGetOperationcodeRequest();
			req.setTenantId(Constants.DEFAULT_TENANT_ID);
			req.setUid(Integer.parseInt(userId));
			req.setUserinfo(email);
			req.setOperationtype(UcenterOperation.OPERATION_TYPE_EMAIL_ACTIVATE);
			Object[] result = VerifyUtil.getUcenterOperationCode(req);
			String code = "";
			boolean isOk = (boolean) result[0];
			String msg = "ok";
			if (!CollectionUtil.isEmpty(result) && result.length > 2) {
				code = result[2] + "";
			}
			if (isOk) {
				SendEmailRequest emailRequest = new SendEmailRequest();
				emailRequest.setTomails(new String[] { email });
				emailRequest.setData(new String[] { "zhangsan", code});
				Locale locale = rb.getDefaultLocale();
				String _template = "";
				if (Locale.SIMPLIFIED_CHINESE.toString().equals(
						locale.toString())) {
					_template = Register.REGISTER_EMAIL_ZH_CN_TEMPLATE;
				} else if (Locale.US.toString().equals(locale.toString())) {
					_template = Register.REGISTER_EMAIL_EN_US_TEMPLATE;
				}
				emailRequest.setTemplateURL(_template);
				emailRequest.setSubject("注册成功");
				VerifyUtil.sendEmail(emailRequest);
			}

			return true;
		}
		return false;
	}

	/**
	 * 构造注册参数
	 */
	private InsertYCUserRequest bulidRegisterParam(HttpServletRequest request) {
		InsertYCUserRequest req = new InsertYCUserRequest();
		String phone = request.getParameter("phone");
		if (!StringUtil.isBlank(phone)) {
			req.setMobilePhone(phone);
			req.setLoginway("2");
			req.setOperationcode(request.getParameter("smsCode"));
		}
		String email = request.getParameter("email");
		if (!StringUtil.isBlank(email)) {
			req.setEmail(email);
			req.setLoginway("1");
		}
		req.setUserName("yiyun" + RandomUtil.randomNum(10));
		req.setNickname("译粉_" + RandomUtil.randomNum(8));
		String password = request.getParameter("password");
		if (!StringUtil.isBlank(password)) {
			req.setPassword(MD5Util.MD5(password));
		}
		req.setRegip("0");
		return req;
	}
}
