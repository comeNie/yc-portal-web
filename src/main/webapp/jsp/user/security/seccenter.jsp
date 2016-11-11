<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title><spring:message code="ycaccountcenter.title"/> </title>

 	<%@ include file="/inc/inc.jsp"%>
</head>
<body>
  <!--头部-->
  <jsp:include page="/inc/userTopMenu.jsp"/>

  <!--二级主体-->
  <!--外侧背景-->
  <div class="cloud-container">
  <!--内侧内容区域-->
  <div class="cloud-wrapper">
  	<!--左侧菜单-->
  	<div class="left-subnav">
  	<jsp:include page="/inc/leftmenu.jsp" />
  	</div>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	<div class="right-wrapper">
  		<!--右侧第一块-->
	
  		<!--右侧第二块-->
  		<div class="right-list mt-0">
  			<div id="sec-level" class="security-title">
  			
  				<div class="security-chart">
  					<!-- <img  src="${uedroot}/images/anq.jpg" /> -->
  					<div id="indicatorContainer"></div>
  				</div>
  				
  				<div  id="sec-level-info"  class="security-word">
  					<ul>
  						<li ><spring:message code="ycaccountcenter.accountleveltip"/></li>
  						<li id="sec-level-info-account-level" class="red"><spring:message code="ycaccountcenter.acc.level.danger"/></li>
  						<li id="sec-level-info-account-warn" class="ash"><spring:message code="ycaccountcenter.acc.level.danger.warning"/></li>
  					</ul>
  				</div>
  			</div>
  			<div class="security-list">
  				<ul>
  					<li id="login_password_icon_color" class="green"><i id="login_password_icon" class="icon-ok-sign"></i></li>
  					<li class="word"><spring:message code="ycaccountcenter.setting.loginpassword"/></li>
  					<li><spring:message code="ycaccountcenter.setting.loginpassword.tip"/></li>
  					<li class="right"><a href="${_base}/p/security/updatePassword"><spring:message code="ycaccountcenter.setting.set"/></a></li>
  				</ul>
  				<ul>
  					<li id="login_email_icon_color" class="red"><i id="login_email_icon" class="icon-remove-sign"></i></li>
  					<li class="word"><spring:message code="ycaccountcenter.setting.email"/></li>
  					<li id="login_email_text"><spring:message code="ycaccountcenter.setting.email.unset"/></li>
  					<li class="right"><a href="#"><spring:message code="ycaccountcenter.setting.set"/></a></li>
  				</ul>
  				<ul>
  					<li id="login_phone_icon_color" class="red"><i id="login_phone_icon" class="icon-remove-sign"></i></li>
  					<li class="word"><spring:message code="ycaccountcenter.setting.loginphone"/></li>
  					<li id="login_phone_text"><spring:message code="ycaccountcenter.setting.loginphone.unset"/></li>
  					<li class="right"><a href="#"><spring:message code="ycaccountcenter.setting.set"/></a></li>
  				</ul>
  				<ul>
  					<li id="pay_password_icon_color"  class="red"><i id="pay_password_icon" class="icon-remove-sign"></i></li>
  					<li class="word"><spring:message code="ycaccountcenter.setting.paypassword"/></li>
  					<li id="pay_password_text"><spring:message code="ycaccountcenter.setting.paypassword.unset"/></li>
  					<li class="right"><a href="#"><spring:message code="ycaccountcenter.setting.set"/></a></li>
  				</ul>
  			</div>
 			
  		</div>	
  	</div>
  	
  	
  </div>
  		
  </div>
</body>

<%@ include file="/inc/incJs.jsp" %>

<script src="${_base}/resources/spm_modules/radia/radialIndicator.js"></script>

<script type="text/javascript">

	var pager;
	(function() {
		seajs.use('app/jsp/user/security/securitycenter', function(secXXXPager) {
			pager = new secXXXPager({
				element : document.body
			});
			pager.render();
		});
	})();
	
	var isexistemail = "${isexistemail}";
	var isexistphone = "${isexistphone}";
	var isexistpaypassword = "${isexistpaypassword}"
	var securitylevel = "${securitylevel}";
	var userEmail = "${userinfo.email}"
	var userMobile = "${userinfo.mobile}";
	var secCenterMsg = {
			"email_set"       : '<spring:message code="ycaccountcenter.setting.email.set"/>',
			"login_phone_set" : '<spring:message code="ycaccountcenter.setting.loginphone.set"/>',
			"paypassword_set" : '<spring:message code="ycaccountcenter.setting.paypassword.set"/>'
		};

	$(document).ready(function(){
		var accLevelInfo = $("#sec-level-info-account-level");
		if(parseInt(securitylevel) < 60)
		{
			accLevelInfo.html('<spring:message code="ycaccountcenter.acc.level.danger"/>');
			$("#sec-level-info-account-warn").html('<spring:message code="ycaccountcenter.acc.level.danger.warning"/>');
		}
		if(parseInt(securitylevel) >= 60 && parseInt(securitylevel) < 100)
		{
			accLevelInfo.html('<spring:message code="ycaccountcenter.acc.level.warn"/>');
			$("#sec-level-info-account-warn").html('<spring:message code="ycaccountcenter.acc.level.warn.warning"/>');
		}
		if(parseInt(securitylevel) == 100)
		{
			accLevelInfo.html('<spring:message code="ycaccountcenter.acc.level.safe"/>');
			$("#sec-level-info-account-warn").html('<spring:message code="ycaccountcenter.acc.level.safe.warning"/>');
		}
		
		// 环形
		$('#indicatorContainer').radialIndicator({
				radius : 100,
				barColor: {
	                0: '#FF0000',
	                33: '#FFFF00',
	                66: '#0066FF',
	                100: '#33CC33'
	            },
	            frameTime : 30,
	            percentage: true
		});
		var radialObj = $('#indicatorContainer').data('radialIndicator');
		radialObj.animate(parseInt(securitylevel));
		
	});
</script>
   
</html>