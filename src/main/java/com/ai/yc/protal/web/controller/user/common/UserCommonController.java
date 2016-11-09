/**
 * 
 */
package com.ai.yc.protal.web.controller.user.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.opt.sdk.util.RandomUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.yc.protal.web.constants.Constants.PhoneVerify;
import com.ai.yc.protal.web.model.sms.SmsRequest;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.alibaba.fastjson.JSONObject;

/**
 * 用户公共Controller<br>
 * Date: 2016年11月9日 <br>
 * Copyright (c) 2016 asiainfo.com <br>
 * 
 * @author xuyw
 */
@RequestMapping("/userCommon")
@Controller
public class UserCommonController {
	private static final Logger LOG = LoggerFactory
			.getLogger(UserCommonController.class);

	/**
	 * 发送短信验证码
	 */
	@RequestMapping("/sendSmsCode")
	@ResponseBody
	public ResponseData<Boolean> sendSmsCode(HttpServletRequest request,
			HttpServletResponse response) {
		String phone = request.getParameter("phone");
		String type = request.getParameter("type");
		SmsRequest req = new SmsRequest();
		req.setPhone(phone);
		/** 手机验证码key **/
		String codeKey = null;
		/** 手机验证码超时时间 **/
		String codeOverTimeKey = null;
		/** 最多发送次数key **/
		String maxCountKey = null;
		/** 最多发送次数超时时间key **/
		String maxCountOverTimeKey = null;
		/** 当前发送次数key **/
		String nowCountKey = null;
		if ("1".equals(type)) {//注册
			codeKey = PhoneVerify.REGISTER_PHONE_CODE + phone;
			codeOverTimeKey = PhoneVerify.REGISTER_PHONE_CODE_OVERTIME;
			nowCountKey = PhoneVerify.REGISTER_PHONE_CODE_COUNT + phone;
			maxCountKey = PhoneVerify.REGISTER_PHONE_CODE_MAX_COUNT;
			maxCountOverTimeKey = PhoneVerify.REGISTER_PHONE_CODE_MAX_COUNT_OVERTIME;
		} else if ("2".equals(type)) {//修改资料
			codeKey = PhoneVerify.UPDATE_DATA_PHONE_CODE + phone;
			codeOverTimeKey = PhoneVerify.UPDATE_DATA_PHONE_CODE_OVERTIME;
			nowCountKey = PhoneVerify.UPDATE_DATA_PHONE_CODE_COUNT + phone;
			maxCountKey = PhoneVerify.UPDATE_DATA_PHONE_CODE_MAX_COUNT;
			maxCountOverTimeKey = PhoneVerify.UPDATE_DATA_PHONE_CODE_MAX_COUNT_OVERTIME;
		}
		req.setCodeKey(codeKey);
		req.setCodeOverTimeKey(codeOverTimeKey);
		req.setMaxCountKey(maxCountKey);
		req.setMaxCountOverTimeKey(maxCountOverTimeKey);
		req.setNowCountKey(nowCountKey);
		String randomStr = RandomUtil.randomNum(6);
		req.setContent("短信验证码:"+randomStr);
		return sendSms(req,randomStr);

	}

	private ResponseData<Boolean> sendSms(SmsRequest req,String randomStr) {
		ICacheClient iCacheClient = AiPassUitl.getCacheClient();
		JSONObject config = AiPassUitl.getVerificationCodeConfig();
		// 最多发送次数 key
		int maxCount = config.getIntValue(req.getMaxCountKey());
		// 当前发送次数
		Integer nowCount = 0;
		String sendCount = iCacheClient.get(req.getNowCountKey());
		if (!StringUtil.isBlank(sendCount)) {
			nowCount = Integer.parseInt(sendCount);
		}

		if (nowCount > maxCount) {
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					"超过" + maxCount + "次", false);
		}
		
		boolean sendOk = true;// SmsSenderUtil.sendMessage(phone, req.getContent());
		if (sendOk) {
			// 最多发送次数超时时间
			int maxOverTimeCount = config.getIntValue(req
					.getMaxCountOverTimeKey());
			nowCount = nowCount + 1;
			iCacheClient.setex(req.getNowCountKey(), maxOverTimeCount,
					String.valueOf(nowCount));
			// 手机验证码超时时间
			int overTime = config.getIntValue(req.getCodeOverTimeKey());
			iCacheClient.setex(req.getCodeKey(), overTime, randomStr);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					"发送成功", true);
		}
		return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
				"发送失败", false);
	}
}
