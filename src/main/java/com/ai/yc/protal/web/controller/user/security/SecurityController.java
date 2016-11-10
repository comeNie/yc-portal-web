package com.ai.yc.protal.web.controller.user.security;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;

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
	@RequestMapping("seccenter")
	public ModelAndView init() {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------进入安全设置界面-------");
		}
		Map<String, Object> model = new HashMap<String, Object>();
		IYCUserServiceSV iYCUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
		SearchYCUserRequest request = new SearchYCUserRequest();
		request.setUserId("000000000000003211");
		YCUserInfoResponse response = iYCUserServiceSV.searchYCUserInfo(request);
		model.put("userinfo", response);
		
		// 登录密码exist
		model.put("isexistloginpassword", "true");
		// 邮箱exist
		model.put("isexistemail", "true");
		// 手机exist
		model.put("isexistphone", "true");
		// 支付密码exist
		model.put("isexistpaypassword", "true");
		// sec level 
		model.put("securitylevel", "85");
		
		ModelAndView modelView = new ModelAndView(INIT,model);
		return modelView;
	}
	@RequestMapping("updatePassword")
	public ModelAndView updatePassword() {
		ModelAndView modelView = new ModelAndView(UPDATE_PASSWORD);
		modelView.addObject("user",UserUtil.getSsoUser());
		return modelView;
	}
}
