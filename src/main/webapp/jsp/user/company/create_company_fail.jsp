<%@page import="com.ai.yc.protal.web.constants.Constants"%>
<%@page import="com.ai.opt.sdk.components.ccs.CCSClientFactory"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<%@ include file="/inc/inc.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>创建企业第一步</title>
</head>
<body>
	<!--头部-->
	<c:if test="${source=='user'}">
      <%@ include file="/inc/userTopMenu.jsp"%>
  	</c:if>
 	 <c:if test="${source=='interpreter'}">
      <%@ include file="/inc/transTopMenu.jsp"%>
  	</c:if>
  <!--二级主体-->
  <!--外侧背景-->
  <div class="cloud-container">
  <!--内侧内容区域-->
  <div class="cloud-wrapper">
  	<!--左侧菜单-->
  	<!--左侧菜单-->
  	<div class="left-subnav">
  	 <c:if test="${source=='user'}">
  	<%@ include file="/inc/leftmenu.jsp"%>
  	</c:if>
     <c:if test="${source=='interpreter'}">
    <%@ include file="/inc/transLeftmenu.jsp"%>
  	</c:if>
  	</div>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	<div class="right-wrapper">
  		<!--右侧第一块-->
  		<!--右侧第二块-->
  		<div class="right-list right-list-height mt-0">
  			<div class="right-list-title pb-10 pl-20">
  				<p>创建企业</p>	
  			</div>
  			<!--充值-->
 			<div class="recharge mt-30">
 					<!--充值成功-->
 					<div class="recharge-success">
 						<ul>
 							<li><img src="${uedroot}/images/rech-fail.png" /></li>
 							<li class="word">您的注册信息提交失败</li>
 						</ul>
 					</div>
 			</div>
  		</div>	
  	</div>  	
  </div>
  </div>
</body>
<%@ include file="/inc/incJs.jsp" %>
</html>
