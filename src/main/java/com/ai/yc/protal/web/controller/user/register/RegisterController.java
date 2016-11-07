package com.ai.yc.protal.web.controller.user.register;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
import com.ai.opt.sdk.components.mcs.MCSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.RandomUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.platform.common.api.country.param.CountryResponse;
import com.ai.platform.common.api.country.param.CountryVo;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.Constants.PhoneVerify;
import com.ai.yc.protal.web.constants.Constants.PictureVerify;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.model.mail.SendEmailRequest;
import com.ai.yc.protal.web.utils.MD5Util;
import com.ai.yc.protal.web.utils.VerifyUtil;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckEmailRequest;
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

	@RequestMapping("/loadCountry")
	@ResponseBody
	public ResponseData<List<CountryVo>> loadCountry() {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------加载国家-------");
		}
		CountryResponse res = null;
		String msg = "ok";
		/*try {
			res = DubboConsumerFactory.getService(IGnCountrySV.class)
					.queryCountry(new CountryRequest());
		} catch (Exception e) {
			msg = "error";
			LOG.error(e.getMessage(), e);
			return new ResponseData<List<CountryVo>>(
					ResponseData.AJAX_STATUS_FAILURE, msg);
		}*/
		List<CountryVo> result = new ArrayList<>();
		for(int i=0;i<3;i++){
			CountryVo vo = new CountryVo();
			vo.setCountryNameCn("中国大陆");
			vo.setCountryNameEn("China");
			vo.setCountryCode("86");
			vo.setRegularExpression("^(86){0,1}1\\d{10}$");
			result.add(vo);
		}
		if (res != null && res.getResponseHeader() != null
				&& res.getResponseHeader().isSuccess()) {
			result = res.getResult();
		}
		return new ResponseData<List<CountryVo>>(
				ResponseData.AJAX_STATUS_SUCCESS, msg, result);
	}

	@RequestMapping(value = "/submitRegister", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData<Boolean> submitRegister(HttpServletRequest request) {
		ResponseData<Boolean> result = checkImageVerifyCode(request);
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
		try {
			// 用户名 手机 邮箱校验 昵称 校验
			YCInsertUserResponse res = DubboConsumerFactory.getService(
					IYCUserServiceSV.class).insertYCUser(req);
			ResponseHeader resHeader = res == null ? null : res
					.getResponseHeader();
			String msg = "";
			if (resHeader != null)
				msg = resHeader.getResultMessage();

			if (resHeader != null && resHeader.isSuccess()) {
				sendRegisterEmaial(req);
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
	 * 获取注册验证码
	 */
	@RequestMapping("/imageVerifyCode")
	public void imageVerifyCode(HttpServletRequest request,
			HttpServletResponse response) {
		String cacheKey = PictureVerify.VERIFY_IMAGE_KEY
				+ request.getSession().getId();
		BufferedImage image = VerifyUtil.getImageVerifyCode(
				Register.CACHE_NAMESPACE, cacheKey, 100, 38);
		try {
			ImageIO.write(image, "PNG", response.getOutputStream());
		} catch (IOException e) {
			LOG.error("生成图片验证码错误：" + e);
		}
	}
	/**
	 * 获取注册验证码
	 */
	@RequestMapping("/smsCode")
	@ResponseBody
	public ResponseData<Boolean> smsCode(HttpServletRequest request,
			HttpServletResponse response) {
		String phone = request.getParameter("phone");
		return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,"ok", true);
		
	}
	/**
	 * 校验注册验证码
	 */
	@RequestMapping("/checkImageVerifyCode")
	@ResponseBody
	public ResponseData<Boolean> checkImageVerifyCode(HttpServletRequest request) {
		try {
			ICacheClient cacheClient = MCSClientFactory
					.getCacheClient(Register.CACHE_NAMESPACE);
			String cacheKey = PictureVerify.VERIFY_IMAGE_KEY
					+ request.getSession().getId();
			String code = cacheClient.get(cacheKey);
			String imgCode = request.getParameter("imgCode");
			Boolean isRight = false;
			String msg = rb.getMessage("ycregisterMsg.verificationCodeError");
			if (!StringUtil.isBlank(code) && !StringUtil.isBlank(imgCode)
					&& imgCode.equalsIgnoreCase(code)) {
				isRight = true;
				msg = "ok";
			}
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					msg, isRight);

		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_FAILURE,
					"");
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
			String msg = "此邮箱已注册";
			Boolean canUse = checkPhoneOrEmail(checkType, checkVal);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					msg, canUse);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_FAILURE,
					"error");
		}
	}

	@RequestMapping("/toEmail")
	public ModelAndView toEmail(@RequestParam("email") String email) {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------进入邮箱界面-------");
		}
		ModelAndView modelView = new ModelAndView(EMAIL);
		modelView.addObject("email", email);
		return modelView;
	}

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
		Boolean canUse = false;
		if ("email".equals(checkType)) {// 邮箱校验
			UcMembersCheckEmailRequest emailReq = new UcMembersCheckEmailRequest();
			emailReq.setEmail(checkVal);
			emailReq.setTenantId(Constants.DEFAULT_TENANT_ID);
			UcMembersResponse res = DubboConsumerFactory.getService(
					IUcMembersSV.class).ucCheckeEmail(emailReq);
			LOG.info("校验邮箱返回：" + JSON.toJSONString(res));
			if (res != null && res.getResponseHeader() != null
					&& res.getResponseHeader().isSuccess()) {
				res.getResponseHeader().getResultCode();
			}
		}
		if ("phone".equals(checkType)) {// 手机校验
			canUse = false;
		}
		return canUse;
	}

	private void sendRegisterEmaial(InsertYCUserRequest req) {
		if (!StringUtil.isBlank(req.getEmail())) {// 手机为空
			SendEmailRequest emailRequest = new SendEmailRequest();
			emailRequest.setTomails(new String[] { req.getEmail() });
			emailRequest
					.setData(new String[] { "zhangsan", "111111", "22222" });
			Locale locale = rb.getDefaultLocale();
			String _template = "";
			if (Locale.SIMPLIFIED_CHINESE.toString().equals(locale.toString())) {
				_template = Register.REGISTER_EMAIL_ZH_CN_TEMPLATE;
			} else if (Locale.US.toString().equals(locale.toString())) {
				_template = Register.REGISTER_EMAIL_EN_US_TEMPLATE;
			}
			emailRequest.setTemplateRUL(_template);
			emailRequest.setSubject("注册成功");
			VerifyUtil.sendEmail(emailRequest);
		}
	}

	private InsertYCUserRequest bulidRegisterParam(HttpServletRequest request) {
		InsertYCUserRequest req = new InsertYCUserRequest();
		String phone = request.getParameter("phone");
		if (!StringUtil.isBlank(phone)) {
			req.setMobilePhone(phone);
			req.setUserName(phone);
			req.setLoginway("2");
		}
		String email = request.getParameter("email");
		if (!StringUtil.isBlank(email)) {
			req.setEmail(email);
			req.setUserName(email);
			req.setLoginway("1");
		}
		req.setNickname("译粉");
		String password = request.getParameter("password");
		if (!StringUtil.isBlank(password)) {
			req.setPassword(MD5Util.MD5(password));
		}
		req.setRegip("0");
		return req;
	}
}
