package com.ai.yc.protal.web.controller.user.security;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ai.yc.protal.web.utils.UserUtil;

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
	private static final String INIT = "user/security/init";
	private static final String UPDATE_PASSWORD = "user/security/updatePassword";
	@RequestMapping("init")
	public ModelAndView init() {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------进入安全设置界面-------");
		}
		ModelAndView modelView = new ModelAndView(INIT);
		return modelView;
	}
	@RequestMapping("updatePassword")
	public ModelAndView updatePassword() {
		ModelAndView modelView = new ModelAndView(UPDATE_PASSWORD);
		modelView.addObject("user",UserUtil.getSsoUser());
		return modelView;
	}
}
