package com.ai.yc.protal.web.controller.user.interpreter;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.base.vo.ResponseHeader;
import com.ai.opt.sdk.components.idps.IDPSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.DateUtil;
import com.ai.opt.sdk.util.StringUtil;
import com.ai.opt.sdk.util.UUIDUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.image.IImageClient;
import com.ai.yc.protal.web.constants.Constants;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.UpdateYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUpdateUserResponse;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import com.alibaba.fastjson.JSON;

@RequestMapping("/p/interpreter")
@RestController
public class InterpreterController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(InterpreterController.class);
	
	@RequestMapping("/interpreterInfoPager")
	public ModelAndView toInterpreterBaseInfo(HttpServletRequest request){
		String source = request.getParameter("source");
		IYCUserServiceSV ucUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
		SearchYCUserRequest userRequest = new SearchYCUserRequest();
		userRequest.setUserId(UserUtil.getUserId());
		YCUserInfoResponse response = ucUserServiceSV.searchYCUserInfo(userRequest);
		Map<String, Object> model = new HashMap<String, Object>();
		String idpsns = "yc-portal-web";
		IImageClient im = IDPSClientFactory.getImageClient(idpsns);
		String url = im.getImageUrl(response.getPortraitId(), ".jpg", "100x100");
		model.put("interpreterInfo", response);
		if(response.getBirthday()!=null){
			model.put("birthday", DateUtil.getDateString(response.getBirthday(),"yyyy-MM-dd"));
		}else{
			model.put("birthday", "");
		}
		model.put("portraitId", url);
		model.put("source", source);
		return new ModelAndView("/user/authentication/interpreter_info",model);
	}
	
	
	@RequestMapping(value = "/uploadImage", produces = "text/html;charset=utf-8")
    @ResponseBody
    public String uploadImage(HttpServletRequest request) {
    	
    	Map<String, Object> map = new HashMap<String, Object>();
        MultipartHttpServletRequest file = (MultipartHttpServletRequest) request;
        MultipartFile multiFile = file.getFile("uploadImg");
        String idpsns = "yc-portal-web";
        try{
        	IImageClient im = IDPSClientFactory.getImageClient(idpsns);
        	String idpsId = im.upLoadImage(multiFile.getBytes(), UUIDUtil.genId32() + ".png");
        	String url = im.getImageUrl(idpsId, ".jpg", "100x100");
    		map.put("isTrue", true);
    		map.put("idpsId", idpsId);
    		map.put("url", url);
        }catch(Exception e){
        	 LOGGER.error("上传失败");
             map.put("isTrue", false);
        }
        return JSON.toJSONString(map);
       }
	
	@RequestMapping("/checkNickName")
	@ResponseBody
	 public String checkNickName(HttpServletRequest request,@RequestParam("userId") String userId,@RequestParam("nickName") String nickName){
		ResponseData<String> responseData = null;
        ResponseHeader header = null;
        try{
        	IYCUserServiceSV ucUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
        	YCUserInfoResponse userInfoResponse = ucUserServiceSV.searchUserInfoByNickName(nickName);
        	if(userInfoResponse!=null){
        		/**
        		 * 查出来的昵称和前台传过来的一样，表示已经注册过
        		 */
        		if(userInfoResponse.getUserId()!=null&&!userId.equals(userInfoResponse.getUserId())&&userInfoResponse.getNickname().equals(nickName)){
        			 header = new ResponseHeader(false, Constants.ERROR_CODE, "失败");
                     responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, "失败", null);
                     responseData.setResponseHeader(header);
        		}else{
        			 header = new ResponseHeader(true, Constants.SUCCESS_CODE, "成功");
                     responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "成功", null);
                     responseData.setResponseHeader(header); 
        		}
        	}
        }catch(Exception e){
        	e.printStackTrace();
        }
        return JSON.toJSONString(responseData);
	}
	
	
	@RequestMapping("/saveInfo")
	@ResponseBody
	 public ResponseData<String> saveInfo(HttpServletRequest request,UpdateYCUserRequest ucUserRequest){
		ResponseData<String> responseData = null;
        ResponseHeader header = null;
        try{
        	if(request.getParameter("birthdayTmp")!=null){
        		ucUserRequest.setBirthday(DateUtil.getTimestamp(request.getParameter("birthdayTmp")));
        	}
			IYCUserServiceSV ucUserServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
			YCUpdateUserResponse response = ucUserServiceSV.updateYCUserInfo(ucUserRequest);
			 if (response != null&&response.getResponseHeader().getResultCode().equals(Constants.SUCCESS_CODE)) {
				 header = new ResponseHeader(true, Constants.SUCCESS_CODE, "成功");
                 responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_SUCCESS, "成功", null);
                 responseData.setResponseHeader(header); 
	          }else{
	        	  header = new ResponseHeader(false, Constants.ERROR_CODE, "成功");
                  responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, "失败", null);
                  responseData.setResponseHeader(header);
	          }
		}catch(Exception e){
			 header = new ResponseHeader(false, Constants.ERROR_CODE, "失败");
             responseData = new ResponseData<String>(ResponseData.AJAX_STATUS_FAILURE, "失败", null);
             responseData.setResponseHeader(header);
		}
		
		return responseData;
	}
}
