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
import org.springframework.web.servlet.ModelAndView;

import com.ai.yc.protal.web.constants.Constants.PictureVerify;
import com.ai.yc.protal.web.constants.Constants.Register;
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
}
