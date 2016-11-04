package com.ai.yc.protal.web.controller.user.register;

import java.awt.image.BufferedImage;
import java.io.IOException;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.sdk.components.mcs.MCSClientFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.yc.protal.web.constants.Constants.PictureVerify;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.model.mail.SendEmailRequest;
import com.ai.yc.protal.web.utils.VerifyUtil;

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
	private static final String REGISTER = "user/register/register";

	@RequestMapping("/toRegister")
	public ModelAndView register() {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------进入注册界面-------");
		}
		ModelAndView modelView = new ModelAndView(REGISTER);
		return modelView;
	}

	/**
	 * 获取注册验证码
	 */
	@RequestMapping("/imageVerifyCode")
	public void getImageVerifyCode(HttpServletRequest request,
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
	 * 校验注册验证码
	 */
	@RequestMapping("/checkImageVerifyCode")
	@ResponseBody
	public ResponseData<Boolean> checkImageVerifyCode(
			HttpServletRequest request) {
		try {
			ICacheClient cacheClient = MCSClientFactory
					.getCacheClient(Register.CACHE_NAMESPACE);
			String cacheKey = PictureVerify.VERIFY_IMAGE_KEY
					+ request.getSession().getId();
			String code = cacheClient.get(cacheKey);
			String imgCode = request.getParameter("imgCode");
			Boolean isRight = false;
			String msg ="验证码错误";
			if (!StringUtil.isBlank(code) && !StringUtil.isBlank(imgCode)
					&& imgCode.equalsIgnoreCase(code)) {
				isRight = true;
				msg ="验证码正确";
			}
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS, msg, isRight);
			
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_FAILURE, "验证码校验失败");
		}
	}
	/**
	 * 校验邮箱或手机
	 */
	@RequestMapping("/checkPhoneOrEmail")
	@ResponseBody
	public ResponseData<Boolean> checkPhoneOrEmail(
			HttpServletRequest request) {
		try {
			String checkType = request.getParameter("checkType");
			String checkVal = request.getParameter("checkVal");
			Boolean canUse = false;
			String msg ="此邮箱已注册";
			if("email".equals(checkType)){//邮箱校验
				canUse = false;
			}if("phone".equals(checkType)){//手机校验
				msg ="此手机已注册";
				canUse = false;
			}
			
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS, msg, canUse);
		} catch (Exception e) {
			LOG.error(e.getMessage(),e);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_FAILURE, "校验失败");
		}
	}
	private void sendMail(){
		String[] data = new String[] { };
		SendEmailRequest emailRequest = new SendEmailRequest();
		emailRequest.setSubject("");
		emailRequest.setTemplateRUL("");
		//emailRequest.setTomails("");
		emailRequest.setData(data);
		VerifyUtil.sendEmail(emailRequest);
	}
}
