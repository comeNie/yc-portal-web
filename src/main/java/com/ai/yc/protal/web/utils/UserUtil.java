package com.ai.yc.protal.web.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.ai.yc.translator.api.translatorservice.interfaces.IYCTranslatorServiceSV;
import com.ai.yc.translator.api.translatorservice.interfaces.IYCUserTranslatorSV;
import com.ai.yc.translator.api.translatorservice.param.SearchYCTranslatorRequest;
import com.ai.yc.translator.api.translatorservice.param.SearchYCTranslatorSkillListRequest;
import com.ai.yc.translator.api.translatorservice.param.YCTranslatorInfoResponse;
import com.ai.yc.translator.api.translatorservice.param.YCTranslatorSkillListResponse;
import com.ai.yc.user.api.usercompanyrelation.interfaces.IYCUserCompanyRelationSV;
import com.ai.yc.user.api.usercompanyrelation.param.ManagerResponse;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.ai.opt.sdk.components.idps.IDPSClientFactory;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.StringUtil;
import com.ai.opt.sso.client.filter.SSOClientConstants;
import com.ai.paas.ipaas.image.IImageClient;
import com.ai.yc.protal.web.model.sso.GeneralSSOClientUser;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;

/**
 * Created by jackieliu on 16/7/8.
 */
public class UserUtil {
    private UserUtil() {
		// TODO Auto-generated constructor stub
	}

    /**
     * 获取管理员标识
     * @return
     */
    public static String getUserId(){
        GeneralSSOClientUser ssoClientUser = getSsoUser();
        return ssoClientUser!=null?ssoClientUser.getUserId():null;
    }

    /**
     * 获取客户的用户名
     * @return
     */
    public static String getUserName(){
        GeneralSSOClientUser ssoClientUser = getSsoUser();
        return ssoClientUser!=null?ssoClientUser.getUsername():null;
    }

    /**
     * 获取单点登陆的用户信息
     * @return
     */
    public static GeneralSSOClientUser getSsoUser(){
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        GeneralSSOClientUser clientUser = (GeneralSSOClientUser)session.getAttribute(SSOClientConstants.USER_SESSION_KEY);
        //TODO....模拟数据
//        if (clientUser==null) {
//            clientUser = new GeneralSSOClientUser();
//            clientUser.setUserId("305234");
//            clientUser.setEmail("mengbo@asiainfo.com");
//            clientUser.setUsername("mengbo@asiainfo.com");
//            saveSsoUser(clientUser);
//        }
        return clientUser;
    }
    /**
     * 更新单点登陆的用户信息
     * @return
     */
    public static void saveSsoUser(GeneralSSOClientUser user){
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        session.setAttribute(SSOClientConstants.USER_SESSION_KEY,user);
    }
    /**
     * 获取用户安全级别
     * @return
     */
    public static int getUserSecurityLevel(){
    	GeneralSSOClientUser userSSOInfo = UserUtil.getSsoUser();
		int securitylevel=0;
		if (!StringUtil.isBlank(userSSOInfo.getEmail())) {
			securitylevel += 33;
		}

		if (!StringUtil.isBlank(userSSOInfo.getMobile())) {
			securitylevel += 33;
		}
		securitylevel += 34;//默认有密码
		return securitylevel;
    }
    /**
     * 获取用户头像信息
     * @return
     */
    public static String getUserPortraitImg(){
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session =request.getSession();
        String userPortraitImg = (String) session.getAttribute("userPortraitImg");
        if(!StringUtil.isBlank(userPortraitImg)){
        	return userPortraitImg;
        }
        userPortraitImg = request.getContextPath()+"/resources/template/images/4.jpg";
        try {
			IYCUserServiceSV ucUserServiceSV = DubboConsumerFactory
					.getService(IYCUserServiceSV.class);
			SearchYCUserRequest userRequest = new SearchYCUserRequest();
			userRequest.setUserId(UserUtil.getUserId());
			YCUserInfoResponse response = ucUserServiceSV
					.searchYCUserInfo(userRequest);
			String idpsns = "yc-portal-web";
			IImageClient im = IDPSClientFactory.getImageClient(idpsns);
			String portraitId = response.getPortraitId();
			if(!StringUtil.isBlank(portraitId)){
				userPortraitImg = im.getImageUrl(portraitId, ".jpg", "100x100");
			}

        } catch (Exception e) {
		 }
        session.setAttribute("userPortraitImg",userPortraitImg);
        return userPortraitImg;
    }

    /**
     * 判断用户是否为lspadmin
     * @return
     */
    public static String getLspAdmin(){
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session =request.getSession();

        String lspAdmin = (String)session.getAttribute("lspAdmin");
        if(!StringUtil.isBlank(lspAdmin)){
            return lspAdmin;
        }
        try {
            //判断译员是否为lsp管理员
            IYCTranslatorServiceSV userTranslatorSV = DubboConsumerFactory
                    .getService(IYCTranslatorServiceSV.class);
            SearchYCTranslatorSkillListRequest searchYCTranslatorSkillListRequest = new SearchYCTranslatorSkillListRequest();
            searchYCTranslatorSkillListRequest.setUserId(UserUtil.getUserId());
            YCTranslatorSkillListResponse translatorSkillList = userTranslatorSV.getTranslatorSkillList(searchYCTranslatorSkillListRequest);
            if (null==translatorSkillList){
                lspAdmin="error";
            }
            lspAdmin = translatorSkillList.getLspRole();

        } catch (Exception e) {
        }
        session.setAttribute("lspAdmin",lspAdmin);
        return lspAdmin;
    }

    /**
     * 判断客户是否为具有企业管理员权限
     * @return
     */
    public static String getCompanyAdmin(){
        HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
        HttpSession session =request.getSession();

        String isManagement = (String) session.getAttribute("isManagement");
        if(!StringUtil.isBlank(isManagement)){
            return isManagement;
        }
        try {
            //判断译员是否为企业管理员
            IYCUserCompanyRelationSV iycUserCompanyRelationSV = DubboConsumerFactory
                    .getService(IYCUserCompanyRelationSV.class);
            ManagerResponse userIsManager = iycUserCompanyRelationSV.getUserIsManager(UserUtil.getUserId());
            System.err.print(UserUtil.getUserId());
            if (null==userIsManager){
                isManagement="error";
            }else {
                isManagement = userIsManager.getIsManagement().toString();
            }

        } catch (Exception e) {
        }
        session.setAttribute("isManagement",isManagement);
        return isManagement;
    }
}
