package com.ai.yc.protal.web.controller.user.company;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.sdk.components.idps.IDPSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.UUIDUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.image.IImageClient;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.user.api.usercompany.interfaces.IYCUserCompanySV;
import com.ai.yc.user.api.usercompany.param.UserCompanyInfoRequest;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.UpdateYCUserRequest;

@RequestMapping("/p/company")
@RestController
public class CompanyController {
	
	private static final Logger LOGGER = LoggerFactory
			.getLogger(CompanyController.class);
	@Autowired
	ResWebBundle rb;
	
	@RequestMapping("/companyPager")
	public ModelAndView toCompanyFirstPager(HttpServletRequest request){
		String source = request.getParameter("source");
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("source", "user");
		return new ModelAndView("/user/company/create_company_info",model);
	}
	
	@RequestMapping("/insertCompanyInfo")
	@ResponseBody
	public ModelAndView insertCompanyInfo(MultipartHttpServletRequest request,UserCompanyInfoRequest companyInfo){
		MultipartHttpServletRequest file = (MultipartHttpServletRequest) request;
		MultipartFile multiLicenseFile = file.getFile("attacid");
		MultipartFile multiEntpAttacidFile = file.getFile("entpId");
		String idpsns = "yc-portal-web";
		String source = request.getParameter("source");
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("source",  "user");
		try {
			IImageClient im = IDPSClientFactory.getImageClient(idpsns);
			String idpsLicenseId = im.upLoadImage(multiLicenseFile.getBytes(),
					UUIDUtil.genId32() + ".png");
			String idpsEntpId = null;
			if(multiEntpAttacidFile.getSize()!=0){
				idpsEntpId = im.upLoadImage(multiEntpAttacidFile.getBytes(),
						UUIDUtil.genId32() + ".png");
				companyInfo.setEntpAttacid(idpsEntpId);
			}
			companyInfo.setLicenseAttacid(idpsLicenseId);
			companyInfo.setAdminUserId(UserUtil.getUserId());
			IYCUserCompanySV companySV = DubboConsumerFactory.getService(IYCUserCompanySV.class);
			companySV.insertCompanyInfo(companyInfo);
			IYCUserServiceSV userServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
			UpdateYCUserRequest userrequest = new UpdateYCUserRequest();
			userrequest.setUserId(UserUtil.getUserId());
			userrequest.setCountry(companyInfo.getCountry());
			userrequest.setProvince(companyInfo.getProvince());
			userrequest.setCnCity(companyInfo.getCnCity());
			userrequest.setAddress(companyInfo.getAddress());
			userServiceSV.updateYCUserInfo(userrequest);
		} catch (Exception e) {
			LOGGER.error("注册企业信息失败");
			return new ModelAndView("/user/company/create_company_fail",model);
		}
		return new ModelAndView("/user/company/create_company_success",model);
	}
	
	
	@RequestMapping("/checkCompanyName")
	@ResponseBody
	public ResponseData<Boolean> checkCompanyName(HttpServletRequest request,String companyName){
		ResponseData<Boolean> responseData = new  ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,"", true);;
		try{
			IYCUserCompanySV companySV = DubboConsumerFactory.getService(IYCUserCompanySV.class);
			UserCompanyInfoRequest companyInfoRequest = new UserCompanyInfoRequest();
			companyInfoRequest.setCompanyName(companyName);
			BaseResponse response = companySV.checkCompanyName(companyInfoRequest);
			/**
			 * 0代表企业名称已经存在
			 */
			if("0".equals(response.getResponseHeader().getResultCode())){
				responseData = new  ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,rb.getMessage("yccompanyinfo.companyname.exists.msg"), false);
			}
		}catch(Exception e){
			responseData = new  ResponseData<Boolean>(ResponseData.AJAX_STATUS_FAILURE,"error", false);
		}
		return responseData;
	}
	
	
}
