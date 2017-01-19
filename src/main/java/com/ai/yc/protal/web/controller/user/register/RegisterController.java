package com.ai.yc.protal.web.controller.user.register;

import java.util.Locale;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.paas.ipaas.util.StringUtil;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.Constants.PhoneVerify;
import com.ai.yc.protal.web.constants.Constants.PictureVerify;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.constants.Constants.UcenterOperation;
import com.ai.yc.protal.web.model.mail.SendEmailRequest;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.ai.yc.protal.web.utils.PasswordMD5Util.Md5Utils;
import com.ai.yc.protal.web.utils.VerifyUtil;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersOperationSV;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
import com.ai.yc.ucenter.api.members.param.base.ResponseCode;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckEmailRequest;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckeMobileRequest;
import com.ai.yc.ucenter.api.members.param.opera.UcMembersActiveRequest;
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
	private static final String ERROR = "user/register/failure";

	@RequestMapping("/toRegister")
	public ModelAndView toRegister() {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------进入注册界面-------");
		}
		ModelAndView modelView = new ModelAndView(REGISTER);
		return modelView;
	}
	
	/**
	 *协议页面
	 */
	@RequestMapping("/toUserAgreement")
	public ModelAndView toUserAgreement(String language){
		String jspUrl = Locale.SIMPLIFIED_CHINESE.equals(rb.getDefaultLocale())?"/user/register/registrationAgreement_ZH_CN":"/user/register/registrationAgreement_EN_US";
		return new ModelAndView(jspUrl);
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
		 Object [] checkResult =null;
		 boolean isPhone = false;
		if (!StringUtil.isBlank(req.getMobilePhone())) {
			isPhone = true;
			checkResult =checkPhoneOrEmail(Register.CHECK_TYPE_PHONE,req.getMobilePhone());
		}
		if (!StringUtil.isBlank(req.getEmail())) {
			checkResult =checkPhoneOrEmail(Register.CHECK_TYPE_EMAIL, req.getEmail());
			
		}
		if(!CollectionUtil.isEmpty(checkResult)&&!(boolean)checkResult[0]){
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					(String) checkResult[1], false);
		}
		try {
			// 用户名 手机 邮箱校验 昵称 校验
			YCInsertUserResponse res = DubboConsumerFactory.getService(
					IYCUserServiceSV.class).insertYCUser(req);
			ResponseHeader resHeader = res == null ? null : res
					.getResponseHeader();
			/**
			 * 手机短信验证码输入错误
			 */
			if ("-1".equals(resHeader.getResultCode())){
				msg = rb.getMessage("ycregisterMsg.phoneDynamicCodeError");
			}
			/**
			 * 手机短信验证码失效
			 */
			if ("0".equals(resHeader.getResultCode())){
				msg = rb.getMessage("ycregisterMsg.phoneDynamicCodeExpired");
			}	
			/**
			 * 手机号注册，并且没有在页面点击获取动态码
			 */
			if(StringUtil.isBlank(req.getUserId())&&!StringUtil.isBlank(req.getMobilePhone())){
				msg = rb.getMessage("ycregisterMsg.enterPhoneDynamicCode");
			}
			if (resHeader != null && resHeader.isSuccess()) {
				String cacheKey = PictureVerify.VERIFY_IMAGE_KEY
						+ request.getSession().getId();
				VerifyUtil.delRedisValue(cacheKey);//清除验证码
				if(isPhone){//清除手机动态码
					VerifyUtil.delRedisValue( PhoneVerify.REGISTER_PHONE_CODE + req.getMobilePhone());//清除验证码
				}
				sendRegisterEmaial(req,res);
				return new ResponseData<Boolean>(
						ResponseData.AJAX_STATUS_SUCCESS, msg, true);
			}
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					msg, false);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					"System error", false);
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
			Object[] result = checkPhoneOrEmail(checkType, checkVal);
			Boolean canUse = (Boolean) result[0];
			String msg =  (String) result[1];
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
		String newEmail = email.substring(0,1)+"*****"+email.substring(email.indexOf("@")-1,email.length());
		modelView.addObject("email", newEmail);
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
	private Object[] checkPhoneOrEmail(String checkType, String checkVal) {
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
		ResponseCode responseCode = res == null ? null : res.getCode();
		Integer codeNumber = responseCode == null ? null : responseCode
				.getCodeNumber();
		boolean falg =false;
		String msg ="ok";
		if (codeNumber != null && codeNumber == 1) {
			falg = true;
		} else if(codeNumber == -10){
			msg = rb.getMessage("ycregisterMsg.accountError");
		}else{
			msg = rb.getMessage("ycregisterMsg.accountExists");
		}
		return new Object[]{falg,msg};
	}
	@RequestMapping("emailActivate/{uuid}")
	public String emailActivate(@PathVariable("uuid") String uuid) {
		String value = VerifyUtil.getRedisValue(uuid);
		if(StringUtil.isBlank(value)){
			return ERROR;
		}
		String[] codes = value.split(",");
		UcMembersActiveRequest req = new UcMembersActiveRequest();
		req.setUid(Integer.parseInt(codes[0]));
		req.setOperationcode(codes[1]);
		req.setOperationtype(UcenterOperation.OPERATION_TYPE_EMAIL_ACTIVATE);
		req.setUserinfo(codes[2]);
		UcMembersResponse res =DubboConsumerFactory.getService(IUcMembersOperationSV.class).ucActiveMember(req);
		if (value.equals(VerifyUtil.getRedisValue(codes[2]))
				&&res != null && res.getMessage() != null
				&& res.getMessage().isSuccess() && res.getCode() != null
				&& res.getCode().getCodeNumber() != null
				&& res.getCode().getCodeNumber() == 1) {
			VerifyUtil.delRedisValue(uuid);
			return SUCCESS;
		}
		LOG.info("邮箱激活返回参数："+JSON.toJSONString(res));
		return ERROR;
	}
	@RequestMapping("test")
	
	public String test() {
		InsertYCUserRequest req = new InsertYCUserRequest();
		req.setEmail("");
		YCInsertUserResponse res = new YCInsertUserResponse();
		res.setUsername("");
		res.setUserId("1");
		res.setOperationcode("222333");
		sendRegisterEmaial(req,res);
		return ERROR;
	}

	/**
	 * 发送验证邮件
	 */
	private boolean sendRegisterEmaial(InsertYCUserRequest req,YCInsertUserResponse res) {
		ICacheClient iCacheClient = AiPassUitl.getCacheClient();
		if (!StringUtil.isBlank(req.getEmail())) {
			String key = UUID.randomUUID().toString().replace("-", "");
			String value = res.getUserId()+","+res.getOperationcode()+","+req.getEmail();
			VerifyUtil.addRedisValue(key, 24*60*60,value);
			iCacheClient.del(req.getEmail());
			iCacheClient.set(req.getEmail(),value);
			JSONObject config = AiPassUitl.getVerificationCodeConfig();
			String  baseUrl = config.getString("base_url");
			String url = baseUrl+"/reg/emailActivate/"+key;
			String logoUrl = baseUrl+"/resources/template/images/logo.jpg";
			String phoneUrl = baseUrl+"/resources/template/images/phone.jpg";
			String ermaUrl = baseUrl+"/resources/template/images/erma.jpg";
			Locale locale = rb.getDefaultLocale();
			String _template = Register.REGISTER_EMAIL_ZH_CN_TEMPLATE;
			String subject=Register.REGISTER_EMAIL_ZH_CN_SUBJECT;
			if (Locale.US.toString().equals(locale.toString())) {
				_template = Register.REGISTER_EMAIL_EN_US_TEMPLATE;
				subject=Register.REGISTER_EMAIL_EN_US_SUBJECT;
			}
			SendEmailRequest emailRequest = new SendEmailRequest();
			emailRequest.setTomails(new String[] { req.getEmail() });
			emailRequest.setData(new String[] {subject,res.getUsername(),url,logoUrl,phoneUrl,ermaUrl});
			emailRequest.setTemplateURL(_template);
			emailRequest.setSubject(subject);
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
			String key = PhoneVerify.REGISTER_PHONE_CODE + phone+PhoneVerify.PHONE_CODE_REGISTER_UID;
		    String uid = (String) request.getSession().getAttribute(key);
            req.setUserId(uid);
        }
		String email = request.getParameter("email");
		if (!StringUtil.isBlank(email)) {
			req.setEmail(email);
			req.setLoginway("1");
		}
		//req.setUserName("yiyun" + RandomUtil.randomNum(10));
		//req.setNickname("译粉_" + RandomUtil.randomNum(8));
		String password = request.getParameter("password");
		if (!StringUtil.isBlank(password)) {
			req.setPassword(Md5Utils.md5(password));
		}
		req.setRegip(getIpAddr(request));
		return req;
	}
	
	private String getIpAddr(HttpServletRequest request) {
		// 获取请求主机IP地址,如果通过代理进来，则透过防火墙获取真实IP地址  
		  
        String ip = request.getHeader("X-Forwarded-For");  
        if (LOG.isInfoEnabled()) {  
        	LOG.info("getIpAddress(HttpServletRequest) - X-Forwarded-For - String ip=" + ip);  
        }  
  
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip.trim())) {  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip.trim())) {  
                ip = request.getHeader("Proxy-Client-IP");  
                if (LOG.isInfoEnabled()) {  
                	LOG.info("getIpAddress(HttpServletRequest) - Proxy-Client-IP - String ip=" + ip);  
                }  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip.trim())) {  
                ip = request.getHeader("WL-Proxy-Client-IP");  
                if (LOG.isInfoEnabled()) {  
                	LOG.info("getIpAddress(HttpServletRequest) - WL-Proxy-Client-IP - String ip=" + ip);  
                }  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip.trim())) {  
                ip = request.getHeader("HTTP_CLIENT_IP");  
                if (LOG.isInfoEnabled()) {  
                	LOG.info("getIpAddress(HttpServletRequest) - HTTP_CLIENT_IP - String ip=" + ip);  
                }  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip.trim())) {  
                ip = request.getHeader("HTTP_X_FORWARDED_FOR");  
                if (LOG.isInfoEnabled()) {  
                	LOG.info("getIpAddress(HttpServletRequest) - HTTP_X_FORWARDED_FOR - String ip=" + ip);  
                }  
            }  
            if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip.trim())) {  
                ip = request.getRemoteAddr();  
                if (LOG.isInfoEnabled()) {  
                	LOG.info("getIpAddress(HttpServletRequest) - getRemoteAddr - String ip=" + ip);  
                }  
            }  
        } else if (ip.length() > 15) {  
            String[] ips = ip.split(",");  
            for (int index = 0; index < ips.length; index++) {  
                String strIp = ((String) ips[index]).trim();  
                if (!("unknown".equalsIgnoreCase(strIp))) {  
                    ip = strIp;  
                    break;  
                }  
            }  
        }  
        return ip; 
	}
	
	
	/**
	 * 校验邮箱或手机
	 *//*
	@RequestMapping("/createAccount")
	@ResponseBody
	public ResponseData<String> createAccount() {
		ResponseData<String> responseData = null;
		IYCUserServiceSV usSV = DubboConsumerFactory.getService(
				IYCUserServiceSV.class);
		List<YCUserInfoResponse> list = usSV.getAllUserInfo();
		for(int i=0;i<list.size();i++){
			YCUserInfoResponse response = list.get(i);
			response.setIsChange("1");
			IAccountMaintainSV iAccountMaintainSV = DubboConsumerFactory.getService(IAccountMaintainSV.class);
			RegAccReq vo = new RegAccReq();
			vo.setExternalId(UUIDUtil.genId32());// 外部流水号ID
			vo.setSystemId("Cloud-UAC_WEB");// 系统ID
			vo.setTenantId("yeecloud");// 租户ID
			vo.setRegCustomerId(response.getUserId());
			vo.setAcctName("迁移数据");
			vo.setAcctType("1");//1预付费
	        try {
	        	UpdateYCUserRequest request = new UpdateYCUserRequest();
	        	long accountId = iAccountMaintainSV.createAccount(vo);
	            response.setAccountId(accountId);
	            BeanUtils.copyProperties(request,response);
	            LOG.info(JSON.toJSONString(request));
	            usSV.updateYCUserInfo(request);
	            responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS,
						"用户创建账号成功", "ok");
	            LOG.info("param:"+JSON.toJSONString(vo));
	            LOG.info("账户ID:"+accountId);
	        } catch (Exception e) {
	            e.printStackTrace();
	            LOG.error("出错：" + e.getMessage());
	        }
	        LOG.info(JSON.toJSONString(response));
		}
		return responseData;
	}
	*/
	
	
}
