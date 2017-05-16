package com.ai.yc.protal.web.controller.user.interpreter;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.components.dss.DSSClientFactory;
import com.ai.opt.sdk.components.idps.IDPSClientFactory;
import com.ai.opt.sdk.components.mcs.MCSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.CollectionUtil;
import com.ai.opt.sdk.util.DateUtil;
import com.ai.opt.sdk.util.StringUtil;
import com.ai.opt.sdk.util.UUIDUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.dss.base.interfaces.IDSSClient;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.image.IImageClient;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.common.api.region.key.RegionCacheKey;
import com.ai.yc.common.api.region.model.RegionInfo;
import com.ai.yc.protal.web.model.sso.GeneralSSOClientUser;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.ucenter.api.members.interfaces.IUcMembersSV;
import com.ai.yc.ucenter.api.members.param.UcMembersResponse;
import com.ai.yc.ucenter.api.members.param.base.ResponseCode;
import com.ai.yc.ucenter.api.members.param.editusername.UcMembersEditUserNameRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetRequest;
import com.ai.yc.ucenter.api.members.param.get.UcMembersGetResponse;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.UpdateYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUpdateUserResponse;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

@RequestMapping("/p/interpreter")
@RestController
public class InterpreterController {

	private static final Logger LOGGER = LoggerFactory
			.getLogger(InterpreterController.class);
	@Autowired
	ResWebBundle rb;
	@RequestMapping("/interpreterInfoPager")
	public ModelAndView toInterpreterBaseInfo(HttpServletRequest request) {
		String source = request.getParameter("source");
		IYCUserServiceSV ucUserServiceSV = DubboConsumerFactory
				.getService(IYCUserServiceSV.class);
		SearchYCUserRequest userRequest = new SearchYCUserRequest();
		userRequest.setUserId(UserUtil.getUserId());
		YCUserInfoResponse response = ucUserServiceSV
				.searchYCUserInfo(userRequest);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("interpreterInfo", response);
		if (response.getBirthday() != null) {
			model.put("birthday", DateUtil.getDateString(
					response.getBirthday(), "yyyy-MM-dd"));
		} else {
			model.put("birthday", "");
		}
		model.put("source", source);
		return new ModelAndView("/user/authentication/interpreter_info", model);
	}

	@RequestMapping(value = "/uploadImage")
	@ResponseBody
	public String uploadImage(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		MultipartHttpServletRequest file = (MultipartHttpServletRequest) request;
		MultipartFile multiFile = file.getFile("file");
		String idpsns = "yc-portal-web";
		try {
			IImageClient im = IDPSClientFactory.getImageClient(idpsns);
			String idpsId = im.upLoadImage(multiFile.getBytes(),
					UUIDUtil.genId32() + ".png");
			String url = im.getImageUrl(idpsId, ".jpg", "100x100");
			map.put("isTrue", true);
			map.put("idpsId", idpsId);
			map.put("url", url);
		} catch (Exception e) {
			LOGGER.error("上传失败");
			map.put("isTrue", false);
		}
		return JSON.toJSONString(map);
	}

	@RequestMapping("/checkNickName")
	@ResponseBody
	public ResponseData<Boolean> checkNickName(HttpServletRequest request,
			@RequestParam("nickName") String nickName) {
		boolean isOk = true;
		String msg = "ok";
		try {
			IYCUserServiceSV ucUserServiceSV = DubboConsumerFactory
					.getService(IYCUserServiceSV.class);
			YCUserInfoResponse userInfoResponse = ucUserServiceSV
					.searchUserInfoByNickName(nickName);
			ResponseHeader responseHeader = userInfoResponse==null?null:userInfoResponse.getResponseHeader();
			if(responseHeader!=null&&responseHeader.isSuccess()
					&&nickName.equals(userInfoResponse.getNickname())){
				msg = rb.getMessage("ycinterpreterInfo.nickname.exists.msg");
				isOk = false;
			}
		} catch (Exception e) {
			isOk = false;
			msg = "error";
			LOGGER.error(e.getMessage(), e);
		}
		return new  ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,msg, isOk);
	}
	/**
	 * 校验用户名
	 * @param request
	 * @param userName
	 * @return
	 */
	@RequestMapping("/checkUserName")
	@ResponseBody
	public ResponseData<Boolean> checkUserName(HttpServletRequest request,
			@RequestParam("userName") String userName) {
		boolean isOk = false;
		String msg = "ok";
		try {
			IUcMembersSV ucMembersSV = DubboConsumerFactory
					.getService(IUcMembersSV.class);
			UcMembersGetRequest membersGetRequest = new UcMembersGetRequest();
			membersGetRequest.setUsername(userName);
			membersGetRequest.setGetmode("4");
			UcMembersGetResponse res = ucMembersSV
					.ucGetMember(membersGetRequest);
			ResponseCode responseCode = res == null ? null : res.getCode();
			Integer codeNumber = responseCode == null ? null : responseCode
					.getCodeNumber();
			if (codeNumber != null && codeNumber == 1) {// 成功
				isOk = false;
				msg= rb.getMessage("interpreter.userName.exist");
			} else {
				isOk = true;
				LOGGER.error(JSON.toJSONString(res));
			}
		 } catch (Exception e) {
			isOk = false;
			msg = rb.getMessage("interpreter.userName.exist");
			LOGGER.error(e.getMessage(), e);
		}
		return new  ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,msg, isOk);
	}
	@RequestMapping("/saveInfo")
	@ResponseBody
	public ResponseData<Boolean> saveInfo(HttpServletRequest request,
			UpdateYCUserRequest ucUserRequest) {
		//原始昵称
		String originalNickname = request.getParameter("originalNickname");
		//原始用户名
		String originalUsername = request.getParameter("originalUsername");
		String userName = request.getParameter("userName");
		boolean isOk = false;
		String  msg = rb.getMessage("interpreter.save.error.msg");
		//用户名是否修改
		boolean isChangeUserName = false;
		try {
			if(!StringUtil.isBlank(userName)&&!userName.equals(originalUsername)){//用户名发生改变
				ResponseData<Boolean> res= checkUserName(request,userName);
				if(!res.getData()){//用户名校验不通过
					return res;
				}
				res = updateUserName(userName);
				if(!res.getData()){//用户名保存失败
					return res;
				}
				isChangeUserName = true;
				//调用ucenter ok 更改状态
				ucUserRequest.setIsChange("1");
			}
			
			ucUserRequest.setUserId(UserUtil.getUserId());
			String nickname = ucUserRequest.getNickname();
			if(!originalNickname.equals(nickname) && !StringUtil.isBlank(nickname)){//昵称发生改变
				ResponseData<Boolean> res= checkNickName(request,nickname);
				if(!res.getData()){//昵称校验不通过
					//回滚用户名
					if(isChangeUserName){
					  updateUserName(originalUsername);
					}
					return res;
				}
			}
			String birthdayTmp = request.getParameter("birthdayTmp");
			if (!StringUtil.isBlank(birthdayTmp)) {
				ucUserRequest.setBirthday(DateUtil.getTimestamp(birthdayTmp));
			}
			IYCUserServiceSV ucUserServiceSV = DubboConsumerFactory
					.getService(IYCUserServiceSV.class);
			YCUpdateUserResponse res = ucUserServiceSV
					.updateYCUserInfo(ucUserRequest);
			ResponseHeader responseHeader =res==null?null:res.getResponseHeader();
			if(responseHeader!=null&&responseHeader.isSuccess()){
				msg =rb.getMessage("interpreter.save.success.msg");
				isOk = true;
				String userPortraitImg = request.getParameter("userPortraitImg");
				if(!StringUtil.isBlank(userPortraitImg)){
					request.getSession().setAttribute("userPortraitImg", userPortraitImg);
				}
				if(isChangeUserName){//更新会话信息
					GeneralSSOClientUser updateUser = UserUtil.getSsoUser();
					updateUser.setUsername(userName);
					UserUtil.saveSsoUser(updateUser);
				}
			}else{
				 //失败回滚用户名
				if(isChangeUserName){
				 updateUserName(originalUsername);
				}
				msg = responseHeader.getResultMessage();
			}
		} catch (Exception e) {
			//回滚用户名
			if(isChangeUserName){
			  updateUserName(originalUsername);
			}
			LOGGER.error(e.getMessage(),e);
		}

		return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,msg, isOk);
	}
	/**
	 * 修改用户名
	 * @param request
	 * @param userName
	 * @return
	 */
	private ResponseData<Boolean> updateUserName(String userName) {
		boolean isOk = false;
		String msg = "ok";
		try {
			IUcMembersSV ucMembersSV = DubboConsumerFactory
					.getService(IUcMembersSV.class);
			UcMembersEditUserNameRequest nameReq = new UcMembersEditUserNameRequest();
			nameReq.setUid(Integer.parseInt(UserUtil.getUserId()));
			nameReq.setUsername(userName);
			UcMembersResponse res = ucMembersSV.ucEditUserName(nameReq);
			ResponseCode responseCode = res == null ? null : res.getCode();
			Integer codeNumber = responseCode == null ? null : responseCode
					.getCodeNumber();
			if (codeNumber != null && codeNumber == 1) {// 成功
				isOk = true;
			} else {
				isOk = false;
				msg =responseCode.getCodeMessage();
			}
		 } catch (Exception e) {
			isOk = false;
			msg = "Ucenter System error";
			LOGGER.error(e.getMessage(), e);
		}
		return new  ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,msg, isOk);
	}
	
	@RequestMapping("/getAllCountry")
	@ResponseBody
	public ResponseData<List<RegionInfo>> getAllCountry(HttpServletRequest request){
		String msg = "ok";
		List<RegionInfo> regionInfos = new ArrayList<>();
		try{
			/**
			 * 查询国家地址库
			 */
	        ICacheClient cacheClient= MCSClientFactory.getCacheClient("com.ai.yc.common.default.cache");
	        Set<String> countryCodes = cacheClient.smembers(RegionCacheKey.GN_REGION_COUNTRY_KEY);
	        List<String> infoList = new ArrayList<String>();
	        if (!CollectionUtil.isEmpty(countryCodes)){
	        	infoList = cacheClient.hmget(RegionCacheKey.GN_REGION_INFO_KEY,
	                    countryCodes.toArray(new String[countryCodes.size()]));
	        	 for (String info:infoList){
	                 regionInfos.add(JSON.parseObject(info,RegionInfo.class));
	             }
	        }
		}catch(Exception e){
			msg = "Get provice data error";
			return new  ResponseData<List<RegionInfo>>(ResponseData.AJAX_STATUS_FAILURE,msg,regionInfos);
		}
		
		return new  ResponseData<List<RegionInfo>>(ResponseData.AJAX_STATUS_SUCCESS,msg,regionInfos);
	}
	
	@RequestMapping("/getProvice")
	@ResponseBody
	public ResponseData<List<RegionInfo>> getProvice(HttpServletRequest request,String regionCode){
		String msg = "ok";
		List<RegionInfo> regionInfos = new ArrayList<>();
		try{
	        ICacheClient cacheClient= MCSClientFactory.getCacheClient("com.ai.yc.common.default.cache");;
	        String childStr = cacheClient.hget(RegionCacheKey.GN_REGION_PARENT_KEY,regionCode);
	        if (StringUtils.isNotBlank(childStr)){
	            List<String> codeArray = JSON.parseArray(childStr,String.class);
	            if (!CollectionUtil.isEmpty(codeArray)){
	                List<String> infoList = cacheClient.hmget(RegionCacheKey.GN_REGION_INFO_KEY,
	                        codeArray.toArray(new String[codeArray.size()]));
	                for (String info:infoList){
	                    regionInfos.add(JSON.parseObject(info,RegionInfo.class));
	                }
	            }
	        }
		}catch(Exception e){
			msg = "Get provice data error";
			return new  ResponseData<List<RegionInfo>>(ResponseData.AJAX_STATUS_FAILURE,msg,regionInfos);
		}
		
		return new  ResponseData<List<RegionInfo>>(ResponseData.AJAX_STATUS_SUCCESS,msg,regionInfos);
	}
	
	@RequestMapping("/getCnCityInfo")
	@ResponseBody
	public ResponseData<List<RegionInfo>> getCnCityInfo(HttpServletRequest request,String Code){
		String msg = "ok";
		List<RegionInfo> regionInfos = new ArrayList<>();
		try{
	        ICacheClient cacheClient= MCSClientFactory.getCacheClient("com.ai.yc.common.default.cache");;
	        String childStr = cacheClient.hget(RegionCacheKey.GN_REGION_PARENT_KEY,Code);
	        if (StringUtils.isNotBlank(childStr)){
	            List<String> codeArray = JSON.parseArray(childStr,String.class);
	            if (!CollectionUtil.isEmpty(codeArray)){
	                List<String> infoList = cacheClient.hmget(RegionCacheKey.GN_REGION_INFO_KEY,
	                        codeArray.toArray(new String[codeArray.size()]));
	                for (String info:infoList){
	                    regionInfos.add(JSON.parseObject(info,RegionInfo.class));
	                }
	            }
	        }
		}catch(Exception e){
			msg = "Get provice data error";
			return new  ResponseData<List<RegionInfo>>(ResponseData.AJAX_STATUS_FAILURE,msg,regionInfos);
		}
		
		return new  ResponseData<List<RegionInfo>>(ResponseData.AJAX_STATUS_SUCCESS,msg,regionInfos);
	}
}
