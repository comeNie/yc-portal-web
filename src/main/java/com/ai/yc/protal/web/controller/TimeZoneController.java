package com.ai.yc.protal.web.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * timezone
 *
 * Date: 2016年11月16日 <br>
 * Copyright (c) 2016 asiainfo.com <br>
 * @author gucl
 */
@Controller
public class TimeZoneController {
	private Logger logger=LoggerFactory.getLogger(getClass());

    @RequestMapping("/timezone.htm")
    public void timezone(HttpServletRequest request, HttpSession session){
    	String offset = request.getParameter("offset");
    	logger.info("session "+session.getAttribute("USER_TIME_ZONE"));
    	logger.info("offset="+offset);
    }

}
