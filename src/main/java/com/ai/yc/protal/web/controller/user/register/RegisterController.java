package com.ai.yc.protal.web.controller.user.register;

import java.awt.image.BufferedImage;
import java.io.IOException;
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
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.util.RandomUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.yc.common.api.country.interfaces.IGnCountrySV;
import com.ai.yc.common.api.country.param.CountryRequest;
import com.ai.yc.common.api.country.param.CountryResponse;
import com.ai.yc.common.api.country.param.CountryVo;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.Constants.PictureVerify;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.model.mail.SendEmailRequest;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.ai.yc.protal.web.utils.MD5Util;
import com.ai.yc.protal.web.utils.SmsSenderUtil;
import com.ai.yc.protal.web.utils.VerifyUtil;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckEmailRequest;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckeMobileRequest;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.InsertYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCInsertUserResponse;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

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
	 * 加载国家
	 */
	@RequestMapping("/loadCountry")
	@ResponseBody
	public ResponseData<List<CountryVo>> loadCountry() {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------加载国家-------");
		}
		String msg = "ok";
		List<CountryVo> result = null;
		ICacheClient iCacheClient = AiPassUitl.getCacheClient();
		String countryList = iCacheClient
				.get(Register.REGISTER_COUNTRY_LIST_KEY);
		if (!StringUtil.isBlank(countryList)) {
			result = JSON.parseArray(countryList, CountryVo.class);
			return new ResponseData<List<CountryVo>>(
					ResponseData.AJAX_STATUS_SUCCESS, msg, result);
		}
		CountryResponse res = null;
		try {
			res = DubboConsumerFactory.getService(IGnCountrySV.class)
					.queryCountry(new CountryRequest());
		} catch (Exception e) {
			msg = "error";
			LOG.error(e.getMessage(), e);
			return new ResponseData<List<CountryVo>>(
					ResponseData.AJAX_STATUS_FAILURE, msg);
		}
		if (res != null && res.getResponseHeader() != null
				&& res.getResponseHeader().isSuccess()) {
			result = res.getResult();
		}
		if (!CollectionUtil.isEmpty(result)) {
			iCacheClient.setex(Register.REGISTER_COUNTRY_LIST_KEY,
					Register.REGISTER_COUNTRY_LIST_KEY_OVERTIME,
					JSON.toJSONString(result));
		}
		return new ResponseData<List<CountryVo>>(
				ResponseData.AJAX_STATUS_SUCCESS, msg, result);
	}

	/**
	 * 提交注册
	 */
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
			String msg = "";
			if (resHeader != null)
				msg = resHeader.getResultMessage();

			if (resHeader != null && resHeader.isSuccess()) {
				sendRegisterEmaial(req.getEmail());
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
		ICacheClient iCacheClient = AiPassUitl.getCacheClient();
		// 发送次数count key
		String sendCountKey = Register.REGISTER_SEND_PHONE_CODE_COUNT_KEY
				+ phone;

		JSONObject config = AiPassUitl.getVerificationCodeConfig();
		// 最多发送次数 key
		int maxCount = config
				.getIntValue(Register.REGISTER_SEND_PHONE_CODE_MAX_COUNT_KEY);
		// 当前发送次数
		Integer nowCount = 0;
		String sendCount = iCacheClient.get(sendCountKey);
		if (!StringUtil.isBlank(sendCount)) {
			nowCount = Integer.parseInt(sendCount);
		}

		if (nowCount > maxCount) {
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					"超过20次", false);
		}
		String randomStr = RandomUtil.randomNum(6);
		boolean sendOk = true;//SmsSenderUtil.sendMessage(phone, "随机数为：" + randomStr);
		if (sendOk) {
			// 最多发送次数超时时间
			int overTimeCount = config
					.getIntValue(Register.REGISTER_SEND_PHONE_CODE_MAX_COUNT_OVERTIME_KEY);
			nowCount = nowCount + 1;
			iCacheClient.setex(sendCountKey, overTimeCount,
					String.valueOf(nowCount));
			// 手机验证码超时时间
			int overTime = config
					.getIntValue(Register.REGISTER_PHONE_CODE_OVERTIME_KEY);
			// 手机验证码 key
			String phoneCodeKey = Register.REGISTER_SEND_PHONE_CODE_KEY + phone;
			iCacheClient.setex(phoneCodeKey, overTime, randomStr);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					"发送成功", true);
		}
		return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
				"发送失败", false);

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
				&& res.getCode().getCode() != null) {
			if (Register.CHECK_TYPE_SUCCESS.equals(res.getCode().getCode())) {
				return true;
			}
		}
		return false;
	}
	@RequestMapping("test")
	public String test(){
    	return EMAIL;
    }
	/**
	 * 发送验证邮件
	 */
	private boolean sendRegisterEmaial(String email) {
		if (!StringUtil.isBlank(email)) {
			SendEmailRequest emailRequest = new SendEmailRequest();
			emailRequest.setTomails(new String[] {email});
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
		return VerifyUtil.sendEmail(emailRequest);
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
		req.setUserName("yiyun"+RandomUtil.randomNum(10));
		req.setNickname("译粉_" + RandomUtil.randomNum(8));
		String password = request.getParameter("password");
		if (!StringUtil.isBlank(password)) {
			req.setPassword(MD5Util.MD5(password));
		}
		req.setRegip("0");
		return req;
	}
}
