package com.ai.yc.protal.web.controller.translator;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import net.sf.json.JSONArray;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import net.sf.json.JSONObject;

import com.ai.opt.base.vo.BaseListResponse;
import com.ai.opt.sdk.components.idps.IDPSClientFactory;
import com.ai.opt.sdk.constants.ExceptCodeConstants;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.BeanUtils;
import com.ai.opt.sdk.util.DateUtil;
import com.ai.opt.sdk.util.StringUtil;
import com.ai.opt.sdk.util.UUIDUtil;
import com.ai.opt.sdk.web.model.ResponseData;
import com.ai.paas.ipaas.i18n.ResWebBundle;
import com.ai.paas.ipaas.image.IImageClient;
import com.ai.yc.common.api.cachekey.model.SysDomain;
import com.ai.yc.common.api.cachekey.model.SysPurpose;
import com.ai.yc.common.api.sysduad.interfaces.IQuerySysDuadSV;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadDetailsRes;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListReq;
import com.ai.yc.common.api.sysduad.param.QuerySysDuadListRes;
import com.ai.yc.common.api.sysduad.param.SysDuadVo;
import com.ai.yc.common.api.sysitembank.param.ItemBankPageQueryRequest;
import com.ai.yc.common.api.sysquestions.interfaces.IQuerySysQuestionsSV;
import com.ai.yc.common.api.sysquestions.param.QuestionsPapersResponse;
import com.ai.yc.common.api.sysquestions.param.QuestionsPapersVo;
import com.ai.yc.protal.web.service.CacheServcie;
import com.ai.yc.protal.web.utils.UserUtil;
import com.ai.yc.translator.api.parentlanguage.interfaces.IYCParentLanguageSV;
import com.ai.yc.translator.api.parentlanguage.param.UsrParentLanguageInfo;
import com.ai.yc.translator.api.translatorservice.interfaces.IYCTranslatorServiceSV;
import com.ai.yc.translator.api.translatorservice.param.SearchYCTranslatorRequest;
import com.ai.yc.translator.api.translatorservice.param.TraslatorCertificateInfoRequest;
import com.ai.yc.translator.api.translatorservice.param.YCTranslatorInfoResponse;
import com.ai.yc.translator.api.translatorservice.param.newparam.InsertYCCertificationsRequest;
import com.ai.yc.translator.api.translatorservice.param.newparam.InsertYCEduHistoryRequest;
import com.ai.yc.translator.api.translatorservice.param.newparam.InsertYCTranslatorRequest;
import com.ai.yc.translator.api.translatorservice.param.newparam.InsertYCWorkExprienceRequest;
import com.ai.yc.translator.api.translatorservice.param.newparam.SearchYCCertificationsRequest;
import com.ai.yc.translator.api.translatorservice.param.newparam.SearchYCEduHistoryRequest;
import com.ai.yc.translator.api.translatorservice.param.newparam.SearchYCWorkExprienceRequest;
import com.ai.yc.translator.api.translatorservice.param.newparam.UsrCertificateMessage;
import com.ai.yc.translator.api.translatorservice.param.newparam.UsrEducationMessage;
import com.ai.yc.translator.api.translatorservice.param.newparam.UsrWorkMessage;
import com.ai.yc.translator.api.translatorservice.param.newparam.YCInsertTranslatorResponse;
import com.ai.yc.translator.api.translatorservice.param.newparam.YCSearchCertificationsResponse;
import com.ai.yc.translator.api.translatorservice.param.newparam.YCSearchEduHistoryResponse;
import com.ai.yc.translator.api.translatorservice.param.newparam.YCSearchWorkExprienceResponse;
import com.ai.yc.translator.api.userlanguage.interfaces.IYCUserLanguageSV;
import com.ai.yc.translator.api.userlanguage.param.UsrLanguageInfo;
import com.ai.yc.translator.api.userlanguage.param.UsrLanguageResponse;
import com.ai.yc.translator.api.usrextend.interfaces.IYCUsrExtendValueSV;
import com.ai.yc.translator.api.usrextend.param.UsrExtendInfo;
import com.ai.yc.translator.api.usrextend.param.UsrExtendRequest;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.UpdateYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import com.alibaba.fastjson.JSON;

@RequestMapping("/p/translator")
@RestController
public class TranslatorController {
	private static final Logger LOGGER = LoggerFactory
			.getLogger(TranslatorController.class);
	@Autowired
	ResWebBundle rb;
	
	@Autowired
    private CacheServcie cacheServcie;
	
	@RequestMapping("/translatorpager")
	public ModelAndView toCompanyFirstPager(HttpServletRequest request){
		String source = request.getParameter("source");
		Map<String, Object> model = new HashMap<String, Object>();
		/**
		 * 获取译员基本信息
		 */
		IYCUserServiceSV ucUserServiceSV = DubboConsumerFactory
				.getService(IYCUserServiceSV.class);
		SearchYCUserRequest userRequest = new SearchYCUserRequest();
		userRequest.setUserId(UserUtil.getUserId());
		YCUserInfoResponse response = ucUserServiceSV
				.searchYCUserInfo(userRequest);
		model.put("interpreterInfo", response);
		/**
		 * 获取译员信息
		 */
		IYCTranslatorServiceSV translatorServiceSV = DubboConsumerFactory.getService(IYCTranslatorServiceSV.class);
		SearchYCTranslatorRequest translatorRequest = new SearchYCTranslatorRequest();
		translatorRequest.setUserId(UserUtil.getUserId());
		YCTranslatorInfoResponse translatorResponse = translatorServiceSV.searchYCTranslatorInfo(translatorRequest);
		model.put("translatorResponse", translatorResponse);
		/**
		 * 获取擅长领域
		 */
		if(!StringUtil.isBlank(translatorResponse.getTranslatorId())){
			IYCUsrExtendValueSV extendValueSV = DubboConsumerFactory.getService(IYCUsrExtendValueSV.class);
			UsrExtendRequest extendRequest = new UsrExtendRequest();
			extendRequest.setTranslatorId(translatorResponse.getTranslatorId());
			extendRequest.setExtendType("1");
			BaseListResponse<UsrExtendInfo> fieldList = extendValueSV.queryExtendValue(extendRequest);
			model.put("fieldList", JSON.toJSONString(fieldList.getResult()));
			
			UsrExtendRequest extendRequest2 = new UsrExtendRequest();
			extendRequest2.setTranslatorId(translatorResponse.getTranslatorId());
			extendRequest2.setExtendType("2");
			BaseListResponse<UsrExtendInfo> userList = extendValueSV.queryExtendValue(extendRequest2);
			model.put("userList", JSON.toJSONString(userList.getResult()));
		}
		
		if (response.getBirthday() != null) {
			model.put("birthday", DateUtil.getDateString(
					response.getBirthday(), "yyyy-MM-dd"));
		} else {
			model.put("birthday", "");
		}
		model.put("source", source);
		return new ModelAndView("/translator/interpreter_certification",model);
	}
	
	@RequestMapping(value="/getLanguages")
	@ResponseBody
	public ResponseData<List<SysDuadVo>> getLanguages(HttpServletRequest request) {
		String msg = "ok";
		//获取语言对
		IQuerySysDuadSV querySysDuadSV = DubboConsumerFactory.getService("iQuerySysDuadSV");
		QuerySysDuadListReq duadListReq = new QuerySysDuadListReq();
		duadListReq.setLanguage(request.getParameter("language"));
		duadListReq.setOrderType(request.getParameter("translatorType"));
		List<SysDuadVo> duadList = new ArrayList<SysDuadVo>();
		ResponseData<List<SysDuadVo>> responseData = null;
		try{
			QuerySysDuadListRes duadListRes = querySysDuadSV.querySysDuadList(duadListReq);
			duadList = duadListRes.getDuads();
			responseData = new ResponseData<List<SysDuadVo>>(ResponseData.AJAX_STATUS_SUCCESS, msg, duadList);
		}catch(Exception e){
			e.printStackTrace();
			responseData = new ResponseData<List<SysDuadVo>>(ResponseData.AJAX_STATUS_FAILURE, msg, duadList);
		}
		
		return responseData;
	}
	/**
	 * 母语
	 * @param request
	 * @return
	 */
	@RequestMapping(value="/getParentLanguages")
	@ResponseBody
	public ResponseData<List<UsrParentLanguageInfo>> getParentLanguages(HttpServletRequest request) {
		String msg = "ok";
		//获取语言对
		IYCParentLanguageSV parentLanguageSV = DubboConsumerFactory.getService(IYCParentLanguageSV.class);
		ResponseData<List<UsrParentLanguageInfo>> responseData = null;
		try{
			BaseListResponse<UsrParentLanguageInfo> response = parentLanguageSV.queryLanguageValue();
			responseData = new ResponseData<List<UsrParentLanguageInfo>>(ResponseData.AJAX_STATUS_SUCCESS, msg, response.getResult());
		}catch(Exception e){
			e.printStackTrace();
			responseData = new ResponseData<List<UsrParentLanguageInfo>>(ResponseData.AJAX_STATUS_FAILURE, msg, null);
		}
		return responseData;
	}

	@RequestMapping(value="/getGoodUser")
	@ResponseBody
	public ResponseData<List<SysPurpose>> getGoodUser(HttpServletRequest request) {
		String msg = "ok";
		ResponseData<List<SysPurpose>> responseData = null;
		try{
			List<SysPurpose> list = cacheServcie.getAllPurpose(rb.getDefaultLocale());
			responseData = new ResponseData<List<SysPurpose>>(ResponseData.AJAX_STATUS_SUCCESS, msg, list);
		}catch(Exception e){
			e.printStackTrace();
			responseData = new ResponseData<List<SysPurpose>>(ResponseData.AJAX_STATUS_FAILURE, msg, null);
		}
		
		return responseData;
	}
	
	
	@RequestMapping(value="/getField")
	@ResponseBody
	public ResponseData<List<SysDomain>> getField(HttpServletRequest request) {
		String msg = "ok";
		ResponseData<List<SysDomain>> responseData = null;
		try{
			List<SysDomain> list = cacheServcie.getAllDomain(rb.getDefaultLocale());
			responseData = new ResponseData<List<SysDomain>>(ResponseData.AJAX_STATUS_SUCCESS, msg,list);
		}catch(Exception e){
			e.printStackTrace();
			responseData = new ResponseData<List<SysDomain>>(ResponseData.AJAX_STATUS_FAILURE, msg, null);
		}
		
		return responseData;
	}
	
	@RequestMapping(value = "/insertTranslatorInfo")
	@ResponseBody
	public ResponseData<Boolean> insertTranslatorInfo(HttpServletRequest request) {
		
		return new ResponseData<Boolean>("", "", true);
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
	
	@RequestMapping(value = "/toSaveFirstStep")
	@ResponseBody
	public ResponseData<Boolean> toSaveFirstStep(HttpServletRequest request,InsertYCTranslatorRequest insertTranslatorRequest){
		
		String translatorId = insertTranslatorRequest.getTranslatorId();
		
		try{
			IYCTranslatorServiceSV translatorSV = DubboConsumerFactory.getService(IYCTranslatorServiceSV.class);
			IYCUserServiceSV userServiceSV = DubboConsumerFactory.getService(IYCUserServiceSV.class);
			IYCUsrExtendValueSV extendValueSV = DubboConsumerFactory.getService(IYCUsrExtendValueSV.class);
			/**
			 * 插入译员基本信息
			 */
			insertTranslatorRequest.setUserId(UserUtil.getUserId());
			YCInsertTranslatorResponse translatorResponse = translatorSV.insertTranslator(insertTranslatorRequest);
			
			if(translatorResponse.getResponseHeader().isSuccess()){
				/**
				 * 更新usr_user表中的数据
				 */
				UpdateYCUserRequest updateUserParams = new UpdateYCUserRequest();
				updateUserParams.setUserId(UserUtil.getUserId());
				updateUserParams.setLastname(insertTranslatorRequest.getLastName());
				updateUserParams.setFirstname(insertTranslatorRequest.getFirstName());
				updateUserParams.setNickname(insertTranslatorRequest.getNickname());
				updateUserParams.setSex(insertTranslatorRequest.getSex());
				updateUserParams.setBirthday(DateUtil.getTimestamp(insertTranslatorRequest.getTmpBirthday()));
				updateUserParams.setCountry(insertTranslatorRequest.getCountry());
				updateUserParams.setProvince(insertTranslatorRequest.getProvince());
				updateUserParams.setCnCity(insertTranslatorRequest.getCnCity());
				updateUserParams.setAddress(insertTranslatorRequest.getAddress());
				updateUserParams.setPortraitId(insertTranslatorRequest.getPortraitId());
				userServiceSV.updateYCUserInfo(updateUserParams);
				/**
				 * 插入用途和领域
				 */
				String users = insertTranslatorRequest.getAreaOfUse();
				String[] userArray = null;
				String experise = insertTranslatorRequest.getAreaOfExperise();
				String[] experiseArray = null;
				if(!StringUtil.isBlank(users)){
					userArray = users.split(",");
				}
				if(!StringUtil.isBlank(experise)){
					experiseArray = experise.split(",");
				}
				
				for(int i=0;i<userArray.length;i++){
					UsrExtendRequest extendRequest = new UsrExtendRequest();
					extendRequest.setTranslatorId(translatorResponse.getTranslatorId());
					extendRequest.setExtendKey(userArray[i]);
					//1表示用途
					extendRequest.setExtendType("1");
					extendValueSV.insertExtendValue(extendRequest);
				}
				for(int i=0;i<experiseArray.length;i++){
					UsrExtendRequest extendRequest = new UsrExtendRequest();
					extendRequest.setTranslatorId(translatorResponse.getTranslatorId());
					extendRequest.setExtendKey(experiseArray[i]);
					//2表示领域
					extendRequest.setExtendType("2");
					extendValueSV.insertExtendValue(extendRequest);
				}
			}
			/**
			 * 删除之前插入的译员信息
			 */
			if(!StringUtil.isBlank(translatorId)){
				translatorSV.deleteTranslatorInfo(insertTranslatorRequest.getTranslatorId());
			}
			
			new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,"报存成功", true);
		}catch(Exception e){
			e.printStackTrace();
			return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,"报存失败", false);
		}
		
		return new ResponseData<Boolean>(ResponseData.AJAX_STATUS_SUCCESS,"报存成功", true);
	}
	
	@RequestMapping(value = "/toSecondStepPager")
	@ResponseBody
	public ModelAndView toSecondStepPager(HttpServletRequest request){
		String source = request.getParameter("source");
		IYCTranslatorServiceSV translatorService = DubboConsumerFactory.getService(IYCTranslatorServiceSV.class);
		/**
		 * 获取语言对信息
		 */
		IYCUserLanguageSV userLanguage = DubboConsumerFactory.getService(IYCUserLanguageSV.class);
		UsrLanguageResponse languageResponse = userLanguage.queryLanguageInfo(UserUtil.getUserId());
		
		/**
		 * 获取教育信息
		 */
		SearchYCEduHistoryRequest searchParams = new SearchYCEduHistoryRequest();
		searchParams.setTranslatorId(UserUtil.getUserId());
		YCSearchEduHistoryResponse educationList = translatorService.searchEduHistory(searchParams);
		/**
		 * 获取工作经验
		 */
		SearchYCWorkExprienceRequest workRequest = new SearchYCWorkExprienceRequest();
		workRequest.setTranslatorId(UserUtil.getUserId());
		YCSearchWorkExprienceResponse workResponse = translatorService.searchWorkExprience(workRequest);
		
		/**
		 * 获取资质信息
		 */
		SearchYCCertificationsRequest cerRequest = new SearchYCCertificationsRequest();
		cerRequest.setTranslatorId(UserUtil.getUserId());
		YCSearchCertificationsResponse cerResponse = translatorService.searchCertifications(cerRequest);
		Map<String, Object> model = new HashMap<String, Object>();
		model.put("source", source);
		model.put("educationList", educationList.getTranslatorEduList());
		model.put("workList", workResponse.getWorkList());
		model.put("certificationList", cerResponse.getCertificateList());
		List<UsrLanguageInfo> languageList = languageResponse.getList();
		//获取语言对
		IQuerySysDuadSV querySysDuadSV = DubboConsumerFactory.getService("iQuerySysDuadSV");
		for(int i=0;i<languageList.size();i++){
			UsrLanguageInfo languageInfo = languageList.get(i);
			QuerySysDuadDetailsRes duadListRes = querySysDuadSV.querySysDuadDetails(languageInfo.getDuadId());
			languageInfo.setLanguageNameZh(duadListRes.getSourceCn()+"->"+duadListRes.getTargetCn());
			languageInfo.setLanguageNameEn(duadListRes.getSourceEn()+"->"+duadListRes.getTargetEn());
		}
		model.put("languageList", languageList);
		model.put("languageListJson",JSON.toJSON(languageResponse.getList()));
		model.put("educationListJson", JSON.toJSON(educationList.getTranslatorEduList()));
		model.put("workListJson", JSON.toJSON(workResponse.getWorkList()));
		model.put("certificationListJson", JSON.toJSON(cerResponse.getCertificateList()));
		model.put("curLanguage", request.getParameter("curLanguage"));
		model.put("languageListCount", languageResponse.getList().size());
		return new ModelAndView("/translator/interpreter_certification_second",model);
	}
	
	@RequestMapping(value = "/saveSecondStepPager")
	@ResponseBody
	public ResponseData<Boolean> saveSecondStepPager(HttpServletRequest request){
		ResponseData<Boolean> responseData = null; 
		String msg = "";
		try{
			/**
			 * 新增的语言信息
			 */
			String oldLanguage = request.getParameter("languageList");
			List<String> oldLanguageList = JSON.parseArray(oldLanguage, String.class);
			String language = request.getParameter("languages");
			List<String> languageList = JSON.parseArray(language, String.class);
			List<UsrLanguageInfo> usrLanguageList = new ArrayList<UsrLanguageInfo>();
			for(int i=0;i<oldLanguageList.size();i++){
				String str = oldLanguageList.get(i);
				if(!StringUtil.isBlank(str)){
					JSONObject json = JSONObject.fromObject(str);
					json.discard("languageNameZh");
					json.discard("languageNameEn");
					UsrLanguageInfo info = (UsrLanguageInfo)JSONObject.toBean(json, UsrLanguageInfo.class);
					info.setState("0");
					info.setUserId(UserUtil.getUserId());
					usrLanguageList.add(info);
				}
			}
			
			for(int i=0;i<languageList.size();i++){
				String str = languageList.get(i);
				if(!StringUtil.isBlank(str)){
					JSONObject json = JSONObject.fromObject(str);
					UsrLanguageInfo info = (UsrLanguageInfo)JSONObject.toBean(json, UsrLanguageInfo.class);
					info.setUserId(UserUtil.getUserId());
					info.setState("0");
					usrLanguageList.add(info);
				}
			}
			/**
			 * 新增的教育经验
			 */
			String education = request.getParameter("education");
			List<String> educationList = JSON.parseArray(education, String.class);
			/**
			 * 历史教育经验
			 */
			String oldEduList = request.getParameter("eduList");
			List<String> oldEducationList = JSON.parseArray(oldEduList, String.class);
			List<UsrEducationMessage> eduResultList = new ArrayList<UsrEducationMessage>();
			for(int i=0;i<oldEducationList.size();i++){
				String eduString = oldEducationList.get(i);
				if(eduString!=null){
					JSONObject json = JSONObject.fromObject(eduString);
					/**
					 * 由于转json时时间类型不统一
					 */
					json.discard("createTime");
					UsrEducationMessage edu = (UsrEducationMessage)JSONObject.toBean(json, UsrEducationMessage.class);
					edu.setTranslatorId(UserUtil.getUserId());
					eduResultList.add(edu);
				}
			}
			for(int i=0;i<educationList.size();i++){
				String eduString = educationList.get(i);
				if(eduString!=null){
					JSONObject json = JSONObject.fromObject(eduString);
					UsrEducationMessage edu = (UsrEducationMessage)JSONObject.toBean(json, UsrEducationMessage.class);
					edu.setTranslatorId(UserUtil.getUserId());
					eduResultList.add(edu);
				}
			}
			
			/**
			 * 工作经验
			 */
			String addwork = request.getParameter("addwork");
			String oldwork = request.getParameter("workList");
			List<String> addworkList = JSON.parseArray(addwork, String.class);
			List<String> oldworkList = JSON.parseArray(oldwork, String.class);
			List<UsrWorkMessage> workResultList = new ArrayList<UsrWorkMessage>();
			for(int i=0;i<oldworkList.size();i++){
				String workString = oldworkList.get(i);
				if(workString!=null){
					JSONObject json = JSONObject.fromObject(workString);
					UsrWorkMessage work = (UsrWorkMessage)JSONObject.toBean(json, UsrWorkMessage.class);
					workResultList.add(work);
				}
			}
			for(int i=0;i<addworkList.size();i++){
				String workString = addworkList.get(i);
				if(workString!=null){
					JSONObject json = JSONObject.fromObject(workString);
					UsrWorkMessage work = (UsrWorkMessage)JSONObject.toBean(json, UsrWorkMessage.class);
					work.setTranslatorId(UserUtil.getUserId());
					workResultList.add(work);
				}
			}
			
			/**
			 * 资质证书
			 */
			String addcard = request.getParameter("addcard");
			String oldcard = request.getParameter("cerList");
			List<String> addcardList = JSON.parseArray(addcard, String.class);
			List<String> oldcardList = JSON.parseArray(oldcard, String.class);
			List<UsrCertificateMessage> cardResultList = new ArrayList<UsrCertificateMessage>();
			for(int i=0;i<oldcardList.size();i++){
				String cardString = oldcardList.get(i);
				if(cardString!=null){
					JSONObject json = JSONObject.fromObject(cardString);
					UsrCertificateMessage certificationRequest = (UsrCertificateMessage)JSONObject.toBean(json, UsrCertificateMessage.class);
					cardResultList.add(certificationRequest);
				}
			}
			
			for(int i=0;i<addcardList.size();i++){
				String cardString = addcardList.get(i);
				if(cardString!=null){
					JSONObject json = JSONObject.fromObject(cardString);
					UsrCertificateMessage certificationRequest = (UsrCertificateMessage)JSONObject.toBean(json, UsrCertificateMessage.class);
					certificationRequest.setTranslatorId(UserUtil.getUserId());
					cardResultList.add(certificationRequest);
				}
			}
			
			IYCTranslatorServiceSV translatorService = DubboConsumerFactory.getService(IYCTranslatorServiceSV.class);
			TraslatorCertificateInfoRequest translatorRequest = new TraslatorCertificateInfoRequest();
			translatorRequest.setUserId(UserUtil.getUserId());
			translatorRequest.setCardResultList(cardResultList);
			translatorRequest.setEduResultList(eduResultList);
			translatorRequest.setWorkResultList(workResultList);
			translatorRequest.setLanguageList(usrLanguageList);
			translatorService.insertCertificateInfo(translatorRequest);
			msg = rb.getMessage("yctranslator.second.step.success");
			responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SUCCESS, msg, true);
		}catch(Exception e){
			e.printStackTrace();
			msg = rb.getMessage("yctranslator.second.step.fail");
			responseData = new ResponseData<Boolean>(ExceptCodeConstants.Special.SYSTEM_ERROR, msg, false);
		}
		return responseData;
	}
	
	@RequestMapping(value = "/toThirdStepPager")
	@ResponseBody
	public ModelAndView toThirdStepPager(HttpServletRequest request){
		IYCUserLanguageSV userLanguageSV = DubboConsumerFactory.getService(IYCUserLanguageSV.class);
		IQuerySysQuestionsSV sysQuestionSV = DubboConsumerFactory.getService(IQuerySysQuestionsSV.class);
		UsrLanguageResponse response = userLanguageSV.queryLanguageInfo(UserUtil.getUserId());
		List<UsrLanguageInfo> languageList = response.getList();
		Map<String, Object> model = new HashMap<String, Object>();
		//获取语言对
		IQuerySysDuadSV querySysDuadSV = DubboConsumerFactory.getService("iQuerySysDuadSV");
		Map<UsrLanguageInfo,List<QuestionsPapersVo>> questMap = new HashMap<UsrLanguageInfo,List<QuestionsPapersVo>>();
		Map<String,List<QuestionsPapersVo>> titleMap = new HashMap<String,List<QuestionsPapersVo>>();
		
		Map<UsrLanguageInfo,List<QuestionsPapersVo>> firstQuestMap = new HashMap<UsrLanguageInfo,List<QuestionsPapersVo>>();
		Map<String,List<QuestionsPapersVo>> firstTitleMap = new HashMap<String,List<QuestionsPapersVo>>();
		if(languageList!=null&&languageList.size()>0){
			/**
			 * 第一次加载语言对和测试题
			 */
			UsrLanguageInfo languageInfoFirst = languageList.get(0);
			QuerySysDuadDetailsRes duadListResFirst = querySysDuadSV.querySysDuadDetails(languageInfoFirst.getDuadId());
			languageInfoFirst.setLanguageNameZh(duadListResFirst.getSourceCn()+"->"+duadListResFirst.getTargetCn());
			languageInfoFirst.setLanguageNameEn(duadListResFirst.getSourceEn()+"->"+duadListResFirst.getTargetEn());
			ItemBankPageQueryRequest queryQuestFirst = new ItemBankPageQueryRequest();
			queryQuestFirst.setLangDir(languageInfoFirst.getDuadId());
			QuestionsPapersResponse questionResponseFirst = sysQuestionSV.questionsPapers(queryQuestFirst);
			firstQuestMap.put(languageInfoFirst, questionResponseFirst.getQiestionsParpersVoList());
			firstTitleMap.put("lan"+languageInfoFirst.getDuadId(), questionResponseFirst.getQiestionsParpersVoList());
			model.put("firstQuestMap", firstQuestMap);
			model.put("firstTitleMap", JSON.toJSON(firstTitleMap));
			model.put("firstLanguageNum", languageInfoFirst.getDuadId());
			/**
			 * 其他的语言对和测试题
			 */
			for(int i=1;i<languageList.size();i++){
				UsrLanguageInfo languageInfo = languageList.get(i);
				QuerySysDuadDetailsRes duadListRes = querySysDuadSV.querySysDuadDetails(languageInfo.getDuadId());
				languageInfo.setLanguageNameZh(duadListRes.getSourceCn()+"->"+duadListRes.getTargetCn());
				languageInfo.setLanguageNameEn(duadListRes.getSourceEn()+"->"+duadListRes.getTargetEn());
				ItemBankPageQueryRequest queryQuest = new ItemBankPageQueryRequest();
				queryQuest.setLangDir(languageInfo.getDuadId());
				QuestionsPapersResponse questionResponse = sysQuestionSV.questionsPapers(queryQuest);
				questMap.put(languageInfo, questionResponse.getQiestionsParpersVoList());
				titleMap.put("lan"+languageInfo.getDuadId(), questionResponse.getQiestionsParpersVoList());
			}
		}
	
		model.put("languageQuest", questMap);
		model.put("languageQuestJson", JSON.toJSON(questMap));
		model.put("titleMap", JSON.toJSON(titleMap));
		return new ModelAndView("/translator/interpreter_certification_third",model);
	}
}
;