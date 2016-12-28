package com.ai.yc.protal.web.filter;

import com.ai.opt.base.vo.BaseResponse;
import com.ai.opt.sdk.dubbo.util.DubboConsumerFactory;
import com.ai.opt.sdk.util.StringUtil;
import com.ai.opt.sso.client.filter.SSOClientConstants;
import com.ai.paas.ipaas.mcs.interfaces.ICacheClient;
import com.ai.yc.common.api.cachekey.key.CacheKey;
import com.ai.yc.common.api.country.param.CountryVo;
import com.ai.yc.protal.web.model.sso.GeneralSSOClientUser;
import com.ai.yc.protal.web.utils.AiPassUitl;
import com.ai.yc.user.api.userservice.interfaces.IYCUserServiceSV;
import com.ai.yc.user.api.userservice.param.CompleteUserInfoRequest;
import com.ai.yc.user.api.userservice.param.InsertYCUserRequest;
import com.ai.yc.user.api.userservice.param.SearchYCUserRequest;
import com.ai.yc.user.api.userservice.param.YCUserInfoResponse;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

import org.apache.commons.lang.StringUtils;
import org.jasig.cas.client.authentication.AttributePrincipal;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import java.io.IOException;
import java.lang.reflect.Field;
import java.security.Principal;
import java.util.Map;


public class AssembleUserInfoFilter implements Filter {
    private String[] ignor_suffix = {};
    private String ignorSuffixStr = "";
    private static final Logger LOG = LoggerFactory.getLogger(AssembleUserInfoFilter.class);

    public void init(FilterConfig filterConfig) throws ServletException {
        ignorSuffixStr = filterConfig.getInitParameter("ignore_suffix");
        if (!"".equals(ignorSuffixStr.trim())) {
            this.ignor_suffix = filterConfig.getInitParameter("ignore_suffix").split(",");
        }
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        if (shouldFilter(req)) {
            chain.doFilter(req, response);
            return;
        }
        HttpSession session = req.getSession();
        GeneralSSOClientUser user = (GeneralSSOClientUser) session.getAttribute(SSOClientConstants.USER_SESSION_KEY);
        if (user == null) {
            user = assembleUser(req);
            if(user!=null){
                session.setAttribute(SSOClientConstants.USER_SESSION_KEY, user);
                LOG.info("已封装的用户信息为：" + JSON.toJSONString(user));
                // 判断客户表信息是否存在，不存在则依据登录信息创建默认的客户信息
                try{
                	populateUsrUserInfo(user);
                }
                catch(Exception e){
                	LOG.error("自动填充客户信息[populateUsrUserInfo]失败："+e.getMessage(),e);
                }
                
            }
            else{
                LOG.info("未获取到用户信息");
            }
            chain.doFilter(req, response);

        } else {
            chain.doFilter(req, response);
        }
    }

    //如果客户表中不存在客户信息，则依据登录信息创建默认的客户信息
    private void populateUsrUserInfo(GeneralSSOClientUser user) {
    	long startTime = System.currentTimeMillis();
    	LOG.info("=====开始populateUsrUserInfo,当前时间戳:"+startTime);
    	SearchYCUserRequest userReq=new SearchYCUserRequest();
    	userReq.setUserId(user.getUserId());
    	long startTimeQryUser = System.currentTimeMillis();
    	LOG.info("开始查询客户信息,当前时间戳:"+startTimeQryUser);
    	IYCUserServiceSV userSv=DubboConsumerFactory.getService(IYCUserServiceSV.class);
    	YCUserInfoResponse userResp= userSv.searchYCUserInfo(userReq);
    	long endTimeQryUser = System.currentTimeMillis();
    	LOG.info("结束查询客户信息,当前时间戳:{}，耗时:{}毫秒",endTimeQryUser,(endTimeQryUser-startTimeQryUser));
    	
    	if(userResp==null||StringUtil.isBlank(userResp.getUserId())){
    		long startTimeCompleteUser = System.currentTimeMillis();
    		LOG.info("客户信息不存在，需自动补全,当前时间戳:"+startTimeCompleteUser);
    		//说明客户信息不存在，需要依据登录信息创建默认的客户信息
    		CompleteUserInfoRequest cmpUser=new CompleteUserInfoRequest();
    		cmpUser.setUserId(user.getUserId());
    		cmpUser.setLoginName(user.getLoginName());
    		cmpUser.setMobilePhone(user.getMobile());
    		//避免网络瞬间中断异常，尝试三次补全
    		boolean flag=false;
    		for(int i=0;i<3;i++){
    			BaseResponse resp=userSv.completeUserInfo(cmpUser);
    			if(resp.getResponseHeader().getIsSuccess()){
    				flag=true;
    				long endTimeCompleteUser = System.currentTimeMillis();
    		    	LOG.info("结束自动补全客户信息,当前时间戳:{}，耗时:{}毫秒",endTimeCompleteUser,(endTimeCompleteUser-startTimeCompleteUser));
    				break;
    			}
    		}
    		if(flag){
    			LOG.info("结束自动补全客户信息OK");
    		}
    		else{
    			LOG.info("结束自动补全客户信息FAILURE");
    		}
    		
    	}
    	else{
    		LOG.info("客户存在，不需补全");
    	}
    	
     	long endTime = System.currentTimeMillis();
        LOG.info("=====结束populateUsrUserInfo,客户信息补全,当前时间戳:{}，耗时:{}毫秒",endTime,(endTime-startTime));
	}

	@Override
    public void destroy() {

    }

    /**
     * 封装用户信息
     *
     * @param request
     * @return
     */
    private GeneralSSOClientUser assembleUser(HttpServletRequest request) {
        GeneralSSOClientUser user = null;
        try {
            Principal principal = request.getUserPrincipal();
            if (principal != null) {
                user = new GeneralSSOClientUser();
                AttributePrincipal attributePrincipal = (AttributePrincipal) principal;
                Map<String, Object> attributes = attributePrincipal.getAttributes();
                Field[] fields = GeneralSSOClientUser.class.getDeclaredFields();
                for (Field field : fields) {
                    String value = (String) attributes.get(field.getName());
                    if (value != null) {
                        field.setAccessible(true);
                        if ("long".equalsIgnoreCase(field.getType().toString())) {
                            field.set(user, Long.parseLong(value));
                        } else {
                            field.set(user, value);
                        }
                    }
                }
                if(attributes.containsKey("loginName")&&attributes.get("loginName")!=null){//用户名特殊处理
                	user.setUsername(String.valueOf(attributes.get("loginName")));
                }
                setMoreUserInfo(user);
            }
        } catch (Exception e) {
            LOG.error("封装用户信息失败", e);
        }
        return user;
    }

    private boolean shouldFilter(HttpServletRequest req) {
        if (ignorSuffixStr==null || "".equals(ignorSuffixStr)){
        	return true;
        }
        String uri = req.getRequestURI().toLowerCase();
        /*if (ignor_suffix != null && ignor_suffix.length > 0) {
            String uri = req.getRequestURI().toLowerCase();
            for (String suffix : ignor_suffix) {
                if (uri.endsWith(suffix)) {
                    return false;
                }
            }
        }
        return true;*/
        return ignorSuffixStr.contains(uri)||ignorSuffixStr.contains(uri+",");
    }
    /**
     * 设置更多用户信息
     * @param user
     */
    private void setMoreUserInfo(GeneralSSOClientUser user){
    	if(!StringUtil.isBlank(user.getDomainname())&&!StringUtil.isBlank(user.getMobile())){
        	ICacheClient iCacheClient = AiPassUitl.getCommonCacheClient();
        	String str = iCacheClient.hget(CacheKey.COUNTRY_D_KEY,user.getDomainname());
            if(StringUtils.isNotBlank(str)) {
            	CountryVo country = JSONObject.parseObject(str, CountryVo.class);
            	user.setFullMobile("+"+country.getCountryCode()+user.getMobile());
            }
        }else{
        	user.setFullMobile(user.getMobile());
        }
    }
}
