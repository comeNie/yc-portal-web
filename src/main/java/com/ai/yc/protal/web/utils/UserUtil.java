package com.ai.yc.protal.web.utils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
     * 获取单点登陆的用户信息
     * @return
     */
    public static GeneralSSOClientUser getSsoUser(){
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        GeneralSSOClientUser clientUser = (GeneralSSOClientUser)session.getAttribute(SSOClientConstants.USER_SESSION_KEY);
        //TODO....模拟数据
        if (clientUser==null) {
            clientUser = new GeneralSSOClientUser();
            clientUser.setUserId("4444313");
            clientUser.setEmail("test@asiainfo.com");
            saveSsoUser(clientUser);
        }
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
		if (StringUtil.isBlank(userSSOInfo.getEmail())) {
			securitylevel += 33;
		}

		if (StringUtil.isBlank(userSSOInfo.getMobile())) {
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
}
