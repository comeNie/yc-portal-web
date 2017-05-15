package com.ai.yc.protal.web.controller.user.security;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.ai.yc.user.api.usercompany.interfaces.IYCUserCompanySV;
import com.ai.yc.user.api.usercompany.param.UserCompanyInfoRequest;
import com.ai.yc.user.api.usercompany.param.UserCompanyInfoResponse;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.StringUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.slp.balance.api.accountmaintain.interfaces.IAccountMaintainSV;
import com.ai.slp.balance.api.accountmaintain.param.AccountUpdateParam;
import com.ai.slp.balance.api.integrals.interfaces.IIntegralsSV;
import com.ai.slp.balance.api.integrals.param.IntegralsResponse;
import com.ai.yc.common.api.cachekey.key.CacheKey;
import com.ai.yc.common.api.country.param.CountryVo;
import com.ai.yc.order.api.orderquery.interfaces.IOrderQuerySV;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountRequest;
import com.ai.yc.order.api.orderquery.param.QueryOrdCountResponse;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.constants.Constants.Register;
import com.ai.yc.protal.web.model.pay.AccountBalanceInfo;
import com.ai.yc.protal.web.model.sso.GeneralSSOClientUser;
import com.ai.yc.protal.web.service.BalanceService;
import com.ai.yc.protal.web.utils.PasswordMD5Util.Md5Utils;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.translator.api.translatorservice.interfaces.IYCTranslatorServiceSV;
import com.ai.yc.translator.api.translatorservice.param.SearchYCTranslatorRequest;
import com.ai.yc.translator.api.translatorservice.param.YCLSPInfoReponse;
import com.ai.yc.translator.api.translatorservice.param.YCTranslatorInfoResponse;
import com.ai.yc.translator.api.translatorservice.param.searchYCLSPInfoRequest;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
import com.ai.yc.ucenter.api.members.param.base.ResponseCode;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckEmailRequest;
import com.ai.yc.ucenter.api.members.param.checke.UcMembersCheckeMobileRequest;
import com.ai.yc.ucenter.api.members.param.editemail.UcMembersEditEmailRequest;
import com.ai.yc.ucenter.api.members.param.editmobile.UcMembersEditMobileRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetResponse;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/**
 * 帐号安全设置<br>
 * Date: 2016年11月7日 <br>
 * Copyright (c) 2016 asiainfo.com <br>
 * 
 * @author xuyw
 */
@RequestMapping("/p/security")
@Controller
public class SecurityController {
	private static final Logger LOG = LoggerFactory
			.getLogger(SecurityController.class);
	private static final String INIT = "user/security/seccenter";
	private static final String UPDATE_PASSWORD = "user/security/updatePassword";
	private static final String ERROR_PAGE = "user/error";
	private static final String UPDATE_PAY_PASSWORD = "user/security/updatePayPassword";
	private static final String INDEX = "user/userIndex";
	private static final String INTERPRETER_INDEX = "user/interpreterIndex";
	@Autowired
	BalanceService balanceService;
	@Autowired
	ResWebBundle rb;

	/**
	 * 译员首页
	 * @param showCert 是否弹出认证提示框，目前只有订单大厅弹出。
	 * @return
	 */
	@RequestMapping("/interpreterIndex")
	@ResponseBody
	public ModelAndView toRegister(Boolean showCert) {
		ModelAndView modelView = new ModelAndView(INTERPRETER_INDEX);
		long balance = 0;
		AccountBalanceInfo balanceInfo = queryBalanceInfo();
		if (balanceInfo != null) {
			balance = balanceInfo.getBalance();
		}
		//是否弹出未认证提示信息
		modelView.addObject("showCert",showCert);
		modelView.addObject("balance", balance);
        String userId = UserUtil.getUserId();
        modelView.addObject("userId", userId);
		//查询积分信息
		IntegralsResponse integralsResponse = null;
		IIntegralsSV iIntegralsSV = DubboConsumerFactory.getService(IIntegralsSV.class);
		integralsResponse = iIntegralsSV.queryIntegrals(userId);
		Integer nowIntegral = 0;
		if(true==integralsResponse.getResponseHeader().isSuccess()){
			modelView.addObject("integration", integralsResponse.getNowIntegral());
		}
		if ("0001".equals(integralsResponse.getResponseHeader().getResultCode())){
			modelView.addObject("integration", nowIntegral);
		}
		// 查询译员信息
        IYCTranslatorServiceSV iycTranslatorServiceSV = DubboConsumerFactory
				.getService(IYCTranslatorServiceSV.class);
		SearchYCTranslatorRequest ycReq = new SearchYCTranslatorRequest();
		ycReq.setUserId(userId);
		YCTranslatorInfoResponse ycRes = null;
		try {
			ycRes = iycTranslatorServiceSV.searchYCTranslatorInfo(ycReq);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		ResponseHeader resHeader = ycRes == null ? null : ycRes
				.getResponseHeader();
		if (resHeader != null && resHeader.isSuccess()) {
			modelView.addObject("interperInfo", ycRes);
		} else {
			LOG.error("获取译员信息: " + JSON.toJSONString(ycRes));

		}
		modelView.addObject("securitylevel", UserUtil.getUserSecurityLevel());
		return modelView;
	}
	@RequestMapping("/queryLspInfo")
	@ResponseBody
	public ResponseData<Object> queryLspInfo(@RequestParam("lspId") String lspId) {
		searchYCLSPInfoRequest req = new searchYCLSPInfoRequest();
		Object data = null;
		req.setLspId(lspId);
		YCLSPInfoReponse res =null;
		String status = ResponseData.AJAX_STATUS_SUCCESS;
		String msg ="ok";
		try {
			res= DubboConsumerFactory.getService(IYCTranslatorServiceSV.class).searchLSPInfo(req);
			ResponseHeader responseHeader =res==null?null:res.getResponseHeader();
			if(responseHeader!=null&&responseHeader.isSuccess()){
				data = res.getUsrLspList();
			}else{
				msg = responseHeader==null?"ok":responseHeader.getResultMessage();
			}
		} catch (Exception e) {
			status = ResponseData.AJAX_STATUS_FAILURE;
			 msg ="error";
			 LOG.error("获取lsp信息: " ,e);
		}
		
		return new ResponseData<Object>(status, msg, data);
	}

	/**
	 * 显示客户首页
	 * @return
	 */
	@RequestMapping("/index")
	@ResponseBody
	public ModelAndView toIndex(Model uiModel) {
		ModelAndView modelView = new ModelAndView(INDEX);
		long balance = 0;
		AccountBalanceInfo balanceInfo = queryBalanceInfo();
		if (balanceInfo != null) {
			balance = balanceInfo.getBalance();
		}
		modelView.addObject("balance", balance);
		//查询当前用户是否为企业管理员
		IYCUserCompanySV userCompanySV = DubboConsumerFactory.getService(IYCUserCompanySV.class);
		UserCompanyInfoRequest request = new UserCompanyInfoRequest();
		request.setUserId(UserUtil.getUserId());
		//只能查询到已认证企业
		UserCompanyInfoResponse response = userCompanySV.queryCompanyInfo(request);
		//是否为管理员
		if(response != null ){
			//是否为管理员
			boolean isManager = UserUtil.getUserId().equals(response.getAdminUserId());
			uiModel.addAttribute("isManager",isManager);
			uiModel.addAttribute("corporaId",isManager?response.getCompanyId():"");
		}
        // sec level
		modelView.addObject("securitylevel", UserUtil.getUserSecurityLevel());
		return modelView;
	}

	@RequestMapping("/queryBalanceInfo")
	@ResponseBody
	public AccountBalanceInfo queryBalanceInfo() {
		AccountBalanceInfo balanceInfo = null;

		try {
			balanceInfo = balanceService.queryOfUser(UserUtil.getUserId());
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}
		return balanceInfo;
	}

	@RequestMapping("/orderStatusCount")
	@ResponseBody
	public Map<String, Integer> orderStatusCount(HttpServletRequest request) {
		//String statusList = request.getParameter("statusList");
		String isInterpreter = request.getParameter("isInterpreter");
		QueryOrdCountResponse ordCountRes = null;
		Map<String,Integer> stateCount =null;
		try {
			String userId = UserUtil.getUserId();
            IOrderQuerySV iOrderQuerySV = DubboConsumerFactory.getService(IOrderQuerySV.class);
            QueryOrdCountRequest ordCountReq = new QueryOrdCountRequest();
            if("true".equals(isInterpreter)){
            	String lspRole = request.getParameter("lspRole");
            	if("11".equals(lspRole)||"12".equals(lspRole)){//lsp管理员
            		ordCountReq.setLspId(userId);
            	}else{//译员
            		ordCountReq.setInterperId(userId);
            	}
            }else{
            	ordCountReq.setUserId(userId);
            }
            ordCountRes = iOrderQuerySV.queryOrderCount(ordCountReq);
            stateCount = ordCountRes.getCountMap();
        } catch (Exception e) {
			LOG.error("查询订单数量失败:", e);
			if (ordCountRes != null) {
				LOG.error("查询订单数量失败:", JSON.toJSONString(ordCountRes));
			}
		}
		return stateCount;
	}

	@RequestMapping("/seccenter")
	@ResponseBody
	public ModelAndView init(HttpServletRequest request) {
		if (LOG.isDebugEnabled()) {
			LOG.debug("-------进入安全设置界面-------");
		}
		String source = request.getParameter("source");//区分来源
		Map<String, Object> model = new HashMap<String, Object>();
		GeneralSSOClientUser userSSOInfo = UserUtil.getSsoUser();
		Boolean isexistemail = true;
		Boolean isexistphone = true;
		Boolean isexistloginpassword = true;
		Boolean isexistpaypassword = true;
		AccountBalanceInfo accountBalanceInfo =queryBalanceInfo();
		if(accountBalanceInfo==null
				|| StringUtil.isBlank(accountBalanceInfo.getPayPassword())){
			isexistpaypassword = false;
		}
		int securitylevel = 0;
		if (StringUtil.isBlank(userSSOInfo.getEmail())) {
			isexistemail = false;
		}

		if (StringUtil.isBlank(userSSOInfo.getMobile())) {
			isexistphone = false;
		}
		if (StringUtil.isBlank(userSSOInfo.getUserId())) {
			ModelAndView modelView = new ModelAndView(ERROR_PAGE);
			return modelView;
		}
		model.put("userinfo", userSSOInfo);

		// 登录密码exist
		model.put("isexistloginpassword", true);
		// 邮箱exist
		model.put("isexistemail", isexistemail);
		// 手机exist
		model.put("isexistphone", isexistphone);
		// 支付密码exist
		model.put("isexistpaypassword", isexistpaypassword);

		if (isexistemail == true) {
			securitylevel += 33;
		}
		if (isexistphone == true) {
			securitylevel += 33;
		}
		if (isexistloginpassword == true) {
			securitylevel += 33;
		}
		
		if(isexistemail&&isexistphone&&isexistloginpassword){
			securitylevel=100;
		}
		// sec level
		model.put("securitylevel", securitylevel);
		
		model.put("source", source);
		ModelAndView modelView = new ModelAndView(INIT, model);
		return modelView;
	}

	@RequestMapping("/updatePassword")
	@ResponseBody
	public ModelAndView updatePassword(HttpServletRequest request) {
		ModelAndView modelView = new ModelAndView(UPDATE_PASSWORD);
		modelView.addObject("user", UserUtil.getSsoUser());
		String source = request.getParameter("source");//区分来源
		modelView.addObject("source", source);
		return modelView;
	}

	@RequestMapping("/updatePayPassword")
	public ModelAndView updatePayPassword(HttpServletRequest request) {
		ModelAndView modelView = new ModelAndView(UPDATE_PAY_PASSWORD);
		modelView.addObject("user", UserUtil.getSsoUser());
		String source = request.getParameter("source");//区分来源
		modelView.addObject("source", source);
		return modelView;
	}

	@RequestMapping(value = "/sendPayPassword", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData<Boolean> sendPayPassword(HttpServletRequest request) {
		String msg = "error";
		boolean isOK = false;
		String payPwd = request.getParameter("payPwd");
		if (StringUtil.isBlank(payPwd)) {
			msg = "param is null";
			ResponseData<Boolean> responseData = new ResponseData<Boolean>(
					ResponseData.AJAX_STATUS_SUCCESS, msg, isOK);
			return responseData;
		}
		try {
			IUcMembersSV ucMembersSV = DubboConsumerFactory
					.getService(IUcMembersSV.class);
			UcMembersGetRequest membersGetRequest = new UcMembersGetRequest();
			membersGetRequest.setUsername(UserUtil.getUserId());
			membersGetRequest.setGetmode("1");
			UcMembersGetResponse getResponse = ucMembersSV
					.ucGetMember(membersGetRequest);
			ResponseCode responseCode = getResponse == null ? null : getResponse.getCode();
			Integer codeNumber = responseCode == null ? null : responseCode
					.getCodeNumber();
			if (codeNumber == null || codeNumber != 1) {// 成功
				msg = responseCode.getCodeMessage();
				ResponseData<Boolean> responseData = new ResponseData<Boolean>(
						ResponseData.AJAX_STATUS_SUCCESS, msg, isOK);
				return responseData;
			}
			payPwd = Md5Utils.md5(payPwd);
			String password =getResponse.getDate().get("password").toString();
			String salt =getResponse.getDate().get("salt").toString();
			if(Md5Utils.md5(payPwd.concat(salt)).equals(password)){
				msg = rb.getMessage("ycaccountcenter.updatePayPassword.info1");
				ResponseData<Boolean> responseData = new ResponseData<Boolean>(
						ResponseData.AJAX_STATUS_SUCCESS, msg, isOK);
				LOG.error(msg);
				return responseData;
			}
			AccountBalanceInfo balanceInfo =queryBalanceInfo();
			if(balanceInfo==null){
				ResponseData<Boolean> responseData = new ResponseData<Boolean>(
						ResponseData.AJAX_STATUS_SUCCESS, "accountBalanceInfo is null", isOK);
				LOG.error("accountBalanceInfo is null");
				return responseData;
			}
			String nowPayPassword =balanceInfo.getPayPassword();
			//设置支付密码后修改需要校验先前支付密码
			if(!Md5Utils.md5(Constants.DEFAULT_PAY_PASSWORD).equals(nowPayPassword)&&nowPayPassword!=""&&nowPayPassword!=null){
				String oldPwd = request.getParameter("oldPwd");//旧支付密码
				oldPwd= Md5Utils.md5(oldPwd);
				//校验支付密码
				if(!oldPwd.equals(nowPayPassword)){
					msg = rb.getMessage("ycaccountcenter.updatePayPassword.currentPasswordError");
					ResponseData<Boolean> responseData = new ResponseData<Boolean>(
							ResponseData.AJAX_STATUS_SUCCESS, msg, isOK);
					LOG.error(msg);
					return responseData;
				}
			}
			AccountUpdateParam req = new AccountUpdateParam();
			req.setTenantId(Constants.DEFAULT_TENANT_ID);
			req.setAcctId(balanceInfo.getAccountId());
			req.setPayPassword(payPwd);
			IAccountMaintainSV iAccountMaintainSV = DubboConsumerFactory
					.getService(IAccountMaintainSV.class);
			iAccountMaintainSV.updateAccount(req);
			isOK = true;
			msg = "ok";
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		ResponseData<Boolean> responseData = new ResponseData<Boolean>(
				ResponseData.AJAX_STATUS_SUCCESS, msg, isOK);
		return responseData;
	}

	@RequestMapping("/bindEmail")
	public ModelAndView bindEmail(HttpServletRequest request) {
		String source = request.getParameter("source");//区分来源
		ModelAndView modelView =new ModelAndView("user/security/bindEmail");
		modelView.addObject("source", source);
		return modelView;
	}

	@RequestMapping("/bindEmailSuccess")
	public ModelAndView bindEmailSuccess(HttpServletRequest request) {
		String source = request.getParameter("source");//区分来源
		ModelAndView modelView =new ModelAndView("user/security/bindEmailSuccess");
		modelView.addObject("source", source);
		return modelView;
	}

	@RequestMapping("/editEmail")
	public ModelAndView editEmail(HttpServletRequest request) {
		String source = request.getParameter("source");//区分来源
		ModelAndView modelView =new ModelAndView("user/security/updateEmail");
		modelView.addObject("source", source);
		return modelView;
    }

	@RequestMapping("/bindPhone")
	public ModelAndView bindPhone(HttpServletRequest request) {
		String source = request.getParameter("source");//区分来源
		ModelAndView modelView =new ModelAndView("user/security/bindPhone");
		modelView.addObject("source", source);
		return modelView;
	}

	@RequestMapping("/editPhone")
	public ModelAndView editPhone(HttpServletRequest request) {
		String source = request.getParameter("source");//区分来源
		ModelAndView modelView =new ModelAndView("user/security/updateMobilePhone");
		modelView.addObject("source", source);
		return modelView;
	}
	@RequestMapping("/bindPhoneSuccess")
	public ModelAndView bindPhoneSuccess(HttpServletRequest request) {
		String source = request.getParameter("source");//区分来源
		ModelAndView modelView =new ModelAndView("user/security/bindPhoneSuccess");
		modelView.addObject("source", source);
		return modelView;
   }


	/**
	 * 验证邮箱是否存在
	 * @param email
	 * @param
	 * @return
	 */

	@RequestMapping(value = "/isExitEmail", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData<Boolean> isExitEmail(
			@RequestParam("email") String email) {
		String msg = "error";
		boolean isOK = false;
		try {
			UcMembersCheckEmailRequest req = new UcMembersCheckEmailRequest();
			req.setTenantId(Constants.DEFAULT_TENANT_ID);
			req.setEmail(email);
			req.setUid(Integer.parseInt(UserUtil.getUserId()));

			IUcMembersSV iUcMembersSV = DubboConsumerFactory
					.getService(IUcMembersSV.class);
			UcMembersResponse res = iUcMembersSV.ucCheckeEmail(req);
			ResponseCode responseCode = res == null ? null : res.getCode();
			Integer codeNumber = responseCode == null ? null : responseCode
					.getCodeNumber();
			LOG.info("--------验证邮箱是否存在返回 :" + JSON.toJSONString(res));
			if (codeNumber != null && codeNumber == 1) {
				isOK = true;
				msg = "ok";
			} else {
				msg = responseCode.getCodeMessage();
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		ResponseData<Boolean> responseData = new ResponseData<Boolean>(
				ResponseData.AJAX_STATUS_SUCCESS, msg, isOK);
		return responseData;
	}


	@RequestMapping(value = "/updateEmail", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData<Boolean> updateEmail(
			@RequestParam("email") String email,
			@RequestParam("code") String code) {
		String msg = "error";
		boolean isOK = false;
		try {
			UcMembersEditEmailRequest req = new UcMembersEditEmailRequest();
			req.setTenantId(Constants.DEFAULT_TENANT_ID);
			req.setEmail(email);
			req.setOperationcode(code);
			req.setUid(Integer.parseInt(UserUtil.getUserId()));

			IUcMembersSV iUcMembersSV = DubboConsumerFactory
					.getService(IUcMembersSV.class);
			UcMembersResponse res = iUcMembersSV.ucEditEmail(req);
			ResponseCode responseCode = res == null ? null : res.getCode();
			Integer codeNumber = responseCode == null ? null : responseCode
					.getCodeNumber();
			LOG.info("--------修改邮箱返回 :" + JSON.toJSONString(res));
			if (codeNumber != null && codeNumber == 1) {
				isOK = true;
				msg = "ok";
				GeneralSSOClientUser user = UserUtil.getSsoUser();
				user.setEmail(email);
				UserUtil.saveSsoUser(user);
			} else {
				msg = responseCode.getCodeMessage();
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		ResponseData<Boolean> responseData = new ResponseData<Boolean>(
				ResponseData.AJAX_STATUS_SUCCESS, msg, isOK);
		return responseData;
	}

	@RequestMapping(value = "/updatePhone", method = RequestMethod.POST)
	@ResponseBody
	public ResponseData<Boolean> updatePhone(
			@RequestParam("phone") String phone,
			@RequestParam("code") String code, @RequestParam("type") String type,
			@RequestParam("countryValue") String countryValue) {
		String msg = "error";
		boolean isOK = false;
		try {
			UcMembersEditMobileRequest req = new UcMembersEditMobileRequest();
			req.setTenantId(Constants.DEFAULT_TENANT_ID);
			req.setOperationcode(code);
			req.setMobilephone(phone);
			req.setUid(Integer.parseInt(UserUtil.getUserId()));
			req.setDomainname(countryValue);
			IUcMembersSV iUcMembersSV = DubboConsumerFactory
					.getService(IUcMembersSV.class);
			UcMembersResponse res = iUcMembersSV.ucEditMobilephone(req);
			ResponseCode responseCode = res == null ? null : res.getCode();
			Integer codeNumber = responseCode == null ? null : responseCode
					.getCodeNumber();
			LOG.info("--------绑定手机返回 :" + JSON.toJSONString(res));
			GeneralSSOClientUser user = UserUtil.getSsoUser();
			if (codeNumber != null && codeNumber == 1) {
				ICacheClient iCacheClient = AiPassUitl.getCommonCacheClient();
	        	String str = iCacheClient.hget(CacheKey.COUNTRY_D_KEY,countryValue);
	        	 if(StringUtils.isNotBlank(str)) {
	             	CountryVo country = JSONObject.parseObject(str, CountryVo.class);
	             	user.setFullMobile("+"+country.getCountryCode()+phone);
	             }
				isOK = true;
				msg = "ok";
				user.setMobile(phone);
				UserUtil.saveSsoUser(user);
			} else {
				msg = responseCode.getCodeMessage();
			}
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
		}

		ResponseData<Boolean> responseData = new ResponseData<Boolean>(
				ResponseData.AJAX_STATUS_SUCCESS, msg, isOK);
		return responseData;
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
			String msg = (String) result[1];
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,
					msg, canUse);
		} catch (Exception e) {
			LOG.error(e.getMessage(), e);
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_FAILURE,
					"error");
		}
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
		boolean falg = false;
		String msg = "ok";
		if (codeNumber != null && codeNumber == 1) {
			falg = true;
		} else {
			msg = responseCode.getCodeMessage();
		}
		return new Object[] { falg, msg };
	}
	@RequestMapping("/userLevel")
	@ResponseBody
	public Map<String, String> userLevel(HttpServletRequest request) {
		YCUserInfoResponse userInfoResponse = null;
		Map<String, String> map = new HashMap<String,String>();
		try {
			String userId = UserUtil.getUserId();
			IYCUserServiceSV userServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
			SearchYCUserRequest userReq = new SearchYCUserRequest();
			userReq.setUserId(userId);
			userInfoResponse = userServiceSV.searchYCUserInfo(userReq);
			if(true==userInfoResponse.getResponseHeader().isSuccess()){
				map.put("ZH", userInfoResponse.getGriwthLevelZH());
				map.put("EN", userInfoResponse.getGriwthLevelEN());
			}
		} catch (Exception e) {
			LOG.error("查询会员级别失败:", e);
			if (userInfoResponse != null) {
				LOG.error("查询会员级别失败:", JSON.toJSONString(userInfoResponse));
			}
		}
		return map;
	}
	/**
	 * 获取积分
	 */
	@RequestMapping("/getIntegration")
	@ResponseBody
	public Map<String, Integer> getIntegration(HttpServletRequest request) {
		IntegralsResponse integralsResponse = null;
		Map<String, Integer> map = new HashMap<String,Integer>();
		try {
			String userId = UserUtil.getUserId();
			IIntegralsSV iIntegralsSV = DubboConsumerFactory.getService(IIntegralsSV.class);
			integralsResponse = iIntegralsSV.queryIntegrals(userId);
			if(true==integralsResponse.getResponseHeader().isSuccess()){
				map.put("integration", integralsResponse.getNowIntegral());
			}else if("0001".equals(integralsResponse.getResponseHeader().getResultCode())){
				map.put("integration",0);
			}else{
				map.put("integration",0);
			}
		} catch (Exception e) {
			LOG.error("查询积分失败:", e);
			if (integralsResponse != null) {
				LOG.error("查询积分失败:", JSON.toJSONString(integralsResponse));
			}
		}
		return map;
	}
}
