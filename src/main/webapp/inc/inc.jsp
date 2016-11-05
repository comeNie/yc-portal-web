<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>  
<c:set var="_base" value="${pageContext.request.contextPath}"/>
<c:set var="_slpres" value="${_base}/resources/local"/>
<c:set var="spmRes" value="${_base}/resources/spm_modules"/>
<c:set var="uedroot" value="${pageContext.request.contextPath}/resources/template"/>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setDateHeader("Expires", 0);
    response.setHeader("Pragma", "No-cache");
%>
<!-- <link rel="stylesheet" type="text/css" href="${_base}/resources/slpmall/styles/bootstrap.css"> -->
<link rel="stylesheet" type="text/css" href="${spmRes}/optDialog/css/ui-dialog.css"/>

<link href="${uedroot}/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
<link href="${uedroot}/css/iconfont.css" rel="stylesheet" type="text/css">
<link href="${uedroot}/css/modular/global.css" rel="stylesheet" type="text/css"/>
<link href="${uedroot}/css/modular/frame.css" rel="stylesheet" type="text/css"/>
<link href="${uedroot}/css/modular/headr-footer.css" rel="stylesheet" type="text/css"/>
<link href="${uedroot}/css/modular/modular.css" rel="stylesheet" type="text/css"/>

