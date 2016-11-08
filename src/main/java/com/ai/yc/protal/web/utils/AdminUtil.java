package com.ai.yc.protal.web.utils;

import com.ai.opt.sso.client.filter.SSOClientConstants;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpSession;

/**
 * Created by jackieliu on 16/7/8.
 */
public class AdminUtil {
    private AdminUtil() {
		// TODO Auto-generated constructor stub
	}

    /**
     * 获取管理员标识
     * @return
     */
    public static Long getAdminId(){
        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        return 1l;
    }


    /**
     * 获取商户标识
     * @return
     */
    public static String getSupplierId(){
//        HttpSession session = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest().getSession();
        return "-1";
    }
}
