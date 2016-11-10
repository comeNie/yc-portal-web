/**
 * 
 */
package com.ai.yc.protal.web.controller.user.common;

import java.awt.image.BufferedImage;
import java.io.IOException;
import java.util.List;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ai.opt.base.vo.ResponseHeader;
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
import com.ai.yc.protal.web.constants.Constants.PhoneVerify;
import com.ai.yc.protal.web.constants.Constants.PictureVerify;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.constants.Constants.UcenterOperation;
import com.ai.yc.protal.web.model.sms.SmsRequest;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.ai.yc.protal.web.utils.VerifyUtil;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersOperationSV;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersGetOperationcodeRequest;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersGetOperationcodeResponse;
import com.alibaba.fastjson.JSON;
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
	@Autowired
	ResWebBundle rb;

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
	 * 获取图片验证码
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
	 * 校验图片证码
	 */
	@RequestMapping("/checkImageVerifyCode")
	@ResponseBody
	public ResponseData<Boolean> checkImageVerifyCode(HttpServletRequest request) {
		String msg = rb.getMessage("ycregisterMsg.verificationCodeError");
		ResponseData<Boolean> result = VerifyUtil.checkImageVerifyCode(request,
				msg);
		return result;
	}

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
		if (StringUtil.isBlank(type)) {
			type = "1";
		}
		if ("1".equals(type)) {// 注册
			codeKey = PhoneVerify.REGISTER_PHONE_CODE + phone;
			codeOverTimeKey = PhoneVerify.REGISTER_PHONE_CODE_OVERTIME;
			nowCountKey = PhoneVerify.REGISTER_PHONE_CODE_COUNT + phone;
			maxCountKey = PhoneVerify.REGISTER_PHONE_CODE_MAX_COUNT;
			maxCountOverTimeKey = PhoneVerify.REGISTER_PHONE_CODE_MAX_COUNT_OVERTIME;
		} else if ("2".equals(type)) {// 修改资料
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
		req.setContent("短信验证码:" + randomStr);
		return sendSms(req, randomStr);

	}

	private ResponseData<Boolean> sendSms(SmsRequest req, String randomStr) {
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

		boolean sendOk = true;// SmsSenderUtil.sendMessage(phone,
								// req.getContent());
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

	/**
	 * 调用ucenter生成操作码
	 */
	@RequestMapping("/getUcenterOperationCode")
	@ResponseBody
	public ResponseData<Boolean> getUcenterOperationCode(
			HttpServletRequest request) {
		String operationtype = request.getParameter("type");
		String uid = request.getParameter("uid");
		String userinfo = request.getParameter("userinfo");// 移动电话/邮箱
		UcMembersGetOperationcodeRequest req = new UcMembersGetOperationcodeRequest();
		req.setTenantId(Constants.DEFAULT_TENANT_ID);
		req.setOperationtype(operationtype);
		if (!StringUtil.isBlank(uid)) {
			req.setUid(Integer.parseInt(uid));
		}
		if (!StringUtil.isBlank(userinfo)) {
			req.setUserinfo(userinfo);
		}
		UcMembersGetOperationcodeResponse res = DubboConsumerFactory
				.getService(IUcMembersOperationSV.class)
				.ucGetOperationcode(req);
		boolean isOk = false;
		String code=null;
		if (res != null && res.getMessage() != null
				&& res.getMessage().isSuccess() && res.getCode() != null
				&& res.getCode().getCode()==1) {
			isOk = true;
			code = String.valueOf(res.getOperationcode());
		}
		return null;
	}
}
