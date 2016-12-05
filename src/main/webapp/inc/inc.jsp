<%@page import="java.util.Locale"%>
<%@ page import="com.ai.paas.ipaas.i18n.ZoneContextHolder" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!--session time zone：<%=session.getAttribute("USER_TIME_ZONE")%>-->
<!--zone context：<%= ZoneContextHolder.getZone()%>-->
<fmt:setTimeZone value="<%= ZoneContextHolder.getZone()%>" scope="session"/>
<c:set var="_base" value="${pageContext.request.contextPath}"/>
<c:set var="rootRes" value="${_base}/resources"/>
<c:set var="spmRes" value="${_base}/resources/spm_modules"/>
<c:set var="uedroot" value="${pageContext.request.contextPath}/resources/template"/>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "No-cache");
    //设置日历控件国际化语言
    if(Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())){
        request.setAttribute("my97Lang","zh-cn");
    }else {
        request.setAttribute("my97Lang","en");
    }
%>
<!-- <link rel="stylesheet" type="text/css" href="${_base}/resources/slpmall/styles/bootstrap.css"> -->
<link href="${uedroot}/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
<link href="${uedroot}/css/iconfont.css" rel="stylesheet" type="text/css">
<link href="${uedroot}/css/modular/global.css" rel="stylesheet" type="text/css"/>
<link href="${uedroot}/css/modular/frame.css" rel="stylesheet" type="text/css"/>
<link href="${uedroot}/css/modular/headr-footer.css" rel="stylesheet" type="text/css"/>
<link href="${uedroot}/css/modular/modular.css" rel="stylesheet" type="text/css"/>

