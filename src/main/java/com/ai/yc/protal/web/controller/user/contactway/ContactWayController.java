package com.ai.yc.protal.web.controller.user.contactway;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.sdk.constants.ExceptCodeConstants;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.user.api.usercontact.interfaces.IYCUserContactSV;
import com.ai.yc.user.api.usercontact.param.UserContactInfo;
import com.ai.yc.user.api.usercontact.param.UserContactInfoRequest;
import com.ai.yc.user.api.usercontact.param.UserContactInfoRespose;
import com.ai.yc.user.api.usercontact.param.UserContactResponse;

@RequestMapping("/p/contactway")
@RestController
public class ContactWayController {
	private static final Logger LOGGER = LoggerFactory
			.getLogger(ContactWayController.class);
	@Autowired
	ResWebBundle rb;
	@RequestMapping("/contactwayPager")
	public ModelAndView toCompanyFirstPager(HttpServletRequest request){
		IYCUserContactSV contactSV = DubboConsumerFactory.getService(IYCUserContactSV.class);
		UserContactInfoRespose contactInfoResponse = contactSV.queryContactInfo(UserUtil.getUserId());
		List<UserContactInfo> list = contactInfoResponse.getUsrContactList();
		String source = request.getParameter("source");
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("source", source);
		model.put("contactList", list);
		return new ModelAndView("/user/contactway/contactway",model);
	}
	
	
	@RequestMapping("/editContactway")
	public ResponseData<UserContactResponse> editContactway(HttpServletRequest request,String contactId){
		IYCUserContactSV contactSV = DubboConsumerFactory.getService(IYCUserContactSV.class);
		ResponseData<UserContactResponse> responseData = null;
		UserContactResponse baseResponse = null;
		try{
			baseResponse = contactSV.queryContactByCid(contactId);
			if(baseResponse.getResponseHeader().getIsSuccess()){
				responseData = new ResponseData<UserContactResponse>(ExceptCodeConstants.Special.SUCCESS,"修改成功",baseResponse);
			}else{
				responseData = new ResponseData<UserContactResponse>(ExceptCodeConstants.Special.SYSTEM_ERROR,"修改失败",baseResponse);
			}
		}catch(Exception e){
			responseData = new ResponseData<UserContactResponse>(ExceptCodeConstants.Special.SYSTEM_ERROR,"修改失败",baseResponse);
			e.printStackTrace();
		}
		
		return responseData;
	}
	
	@RequestMapping("/updatecontactway")
	public ResponseData<Boolean> updateContactWay(HttpServletRequest request,UserContactInfoRequest contactInfoRequest){
		IYCUserContactSV contactSV = DubboConsumerFactory.getService(IYCUserContactSV.class);
		contactInfoRequest.setUserId(UserUtil.getUserId());
		ResponseData<Boolean> responseData = null;
		try{
			BaseResponse baseResponse = contactSV.updateContactInfo(contactInfoRequest);
			if(baseResponse.getResponseHeader().getIsSuccess()){
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SUCCESS,"修改成功",true);
			}else{
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"修改失败",false);
			}
		}catch(Exception e){
			responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"修改失败",false);
			e.printStackTrace();
		}
		
		return responseData;
	}
	
	@RequestMapping("/delcontactway")
	public ResponseData<Boolean> delContactWay(HttpServletRequest request,String contactId){
		IYCUserContactSV contactSV = DubboConsumerFactory.getService(IYCUserContactSV.class);
		ResponseData<Boolean> responseData = null;
		try{
			BaseResponse baseResponse = contactSV.deleteContactInfo(contactId);
			if(baseResponse.getResponseHeader().getIsSuccess()){
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SUCCESS,"删除成功",true);
			}else{
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"删除失败",false);
			}
		}catch(Exception e){
			responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"删除失败",false);
			e.printStackTrace();
		}
		
		return responseData;
	}
	
	@RequestMapping("/checkUserName")
	public ResponseData<Boolean> checkUserName(HttpServletRequest request,String userName,String contactId){
		IYCUserContactSV contactSV = DubboConsumerFactory.getService(IYCUserContactSV.class);
		ResponseData<Boolean> responseData = null;
		try{
			UserContactResponse baseResponse = contactSV.checkUserName(userName);
			if(baseResponse.getResponseHeader().getIsSuccess()||baseResponse.getContactId().equals(contactId)){
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SUCCESS,"成功",true);
			}else{
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"失败",false);
			}
		}catch(Exception e){
			responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"失败",false);
			e.printStackTrace();
		}
		
		return responseData;
	}
	
	@RequestMapping("/checkUserEmail")
	public ResponseData<Boolean> checkUserEmail(HttpServletRequest request,String userEmail,String contactId){
		IYCUserContactSV contactSV = DubboConsumerFactory.getService(IYCUserContactSV.class);
		ResponseData<Boolean> responseData = null;
		try{
			UserContactResponse baseResponse = contactSV.checkUserEmail(userEmail);
			if(baseResponse.getResponseHeader().getIsSuccess()||baseResponse.getContactId().equals(contactId)){
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SUCCESS,"成功",true);
			}else{
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"修改失败",false);
			}
		}catch(Exception e){
			responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"失败",false);
			e.printStackTrace();
		}
		
		return responseData;
	}
	
	@RequestMapping("/checkUserPhone")
	public ResponseData<Boolean> checkUserPhone(HttpServletRequest request,String telephone,String contactId){
		IYCUserContactSV contactSV = DubboConsumerFactory.getService(IYCUserContactSV.class);
		ResponseData<Boolean> responseData = null;
		try{
			UserContactResponse baseResponse = contactSV.checkUserPhone(telephone);
			if(baseResponse.getResponseHeader().getIsSuccess()||baseResponse.getContactId().equals(contactId)){
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SUCCESS,"成功",true);
			}else{
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"修改失败",false);
			}
		}catch(Exception e){
			responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"失败",false);
			e.printStackTrace();
		}
		
		return responseData;
	}
	
	@RequestMapping("/setDefault")
	public ResponseData<Boolean> setDefault(HttpServletRequest request,UserContactInfoRequest contactInfo){
		IYCUserContactSV contactSV = DubboConsumerFactory.getService(IYCUserContactSV.class);
		ResponseData<Boolean> responseData = null;
		try{
			contactInfo.setUserId(UserUtil.getUserId());
			BaseResponse baseResponse = contactSV.updateContactDefaultMode(contactInfo);
			if(baseResponse.getResponseHeader().getIsSuccess()){
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SUCCESS,"成功",true);
			}else{
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"修改失败",false);
			}
		}catch(Exception e){
			responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"失败",false);
			e.printStackTrace();
		}
		
		return responseData;
	}
	
	@RequestMapping("/saveContactInfo")
	public ResponseData<Boolean> saveContactInfo(HttpServletRequest request,UserContactInfoRequest contactInfo){
		IYCUserContactSV contactSV = DubboConsumerFactory.getService(IYCUserContactSV.class);
		ResponseData<Boolean> responseData = null;
		try{
			contactInfo.setUserId(UserUtil.getUserId());
			BaseResponse baseResponse = contactSV.insertContactInfo(contactInfo);
			if(baseResponse.getResponseHeader().getIsSuccess()){
				if("400001".equals(baseResponse.getResponseHeader().getResultCode())){
					responseData = new ResponseData<Boolean>(baseResponse.getResponseHeader().getResultCode(),rb.getMessage("yccontactway.add.fail"),true);
				}else{
					responseData = new ResponseData<Boolean>(baseResponse.getResponseHeader().getResultCode(),baseResponse.getResponseHeader().getResultMessage(),true);
				}
			}else{
				responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"报存失败",false);
			}
		}catch(Exception e){
			responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR,"失败",false);
			e.printStackTrace();
		}
		
		return responseData;
	}
	
}
