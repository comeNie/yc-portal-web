<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title><spring:message code="ycregister.register" /></title>
<%@ include file="/inc/inc.jsp"%>
<link href="${uedroot}/css/modular/login-regsiter.css" rel="stylesheet"
	type="text/css" />

</head>
<body class="login-body">
	<div class="login-big">
		<div class="login-headr">
			<p>
				<img style="cursor: pointer" src="${uedroot}/images/login-logo.png" onclick="location.href='${_base}/'" />
			</p>
			<p class="word">
				<spring:message code="ycregister.registerTitle" />
			</p>
		</div>
		<div class="login-wrapper">
			<div class="login-left">
				<img src="${uedroot}/images/login-bj.png">
			</div>
			<div class="register-right radius">
				<div class="login-title">
					<spring:message code="ycregister.register" />
				</div>
				<div class="login-form-title">
					<ul>
						<label class="ml-70" id="regsiterMsg"></label>
						<p class="right">
							<a id="change_register_type" href="javascript:void(0);"
								register_type="phone"><i class="icon iconfont">&#xe635;</i>
								<spring:message code="ycregister.register.email" /></a>
						</p>
					</ul>
				</div>
				<form id="regsiterForm" method="post">
					<div class="regsiter-form">
						<ul>
							<li id="li_register_phone_container">
								<p class="word">
									<spring:message code="ycregister.phone" />
								</p>
								<p>
									<select id="country" class="select select-in radius"></select>
								</p>
								<p class="ml-20">
									<input id="phone" name="phone" maxlength="100" type="text"
										class="int-text int-in-bi radius" placeholder="<spring:message code="ycregister.register.phone.tip" />">
								</p>
							</li>

							<li id="li_register_email_container" style="display: none;">
								<p class="word">
									<spring:message code="ycregister.email" />
								</p>
								<p>
									<input id="email" maxlength="64" name="email" type="text"
										class="int-text int-in-big radius" placeholder="<spring:message code="ycregister.register.email.tip" />">
								</p>
							</li>
							<li>
								<p class="word">
									<spring:message code="ycregister.password" />
								</p>
								<p>
									<input id="password"  name="password"
										type="password" autocomplete="off"  class="int-text int-in-big radius" placeholder="<spring:message code="ycregister.register.password.tip" />">
								</p>
							</li>
							<li>
								<p class="word">
									<spring:message code="ycregister.confirmPassword" />
								</p>
								<p>
									<input id="confirmPassword" 
										name="confirmPassword" type="password" autocomplete="off" 
										class="int-text int-in-big radius" placeholder="<spring:message code="ycregister.register.confirmPassword.tip" />"/>
								</p>
							</li>
							<li>
								<p class="word">
									<spring:message code="ycregister.verificationCode" />
								</p>
								<p>
									<input id="verifyCodeImg" name="imgCode" maxlength="4"
										type="text" class="int-text int-in-280 radius" placeholder="<spring:message code="ycregister.register.verificationCode.tip" />">
								</p>
								<p class="img">
									<img id="refreshVerificationCode"
										src="${_base}/userCommon/imageVerifyCode" height="44"
										style="cursor: pointer">
								</p>
							</li>
							<li id="li_register_phone_code_container">
								<p class="word">
									<spring:message code="ycregister.dynamiCode" />
								</p>
								<p>
									<input id="smsCode" name="smsCode" maxlength="6" type="text" class="int-text int-in-280 radius" placeholder="<spring:message code="ycregister.register.dynamiCode.tip" />"/>
								</p>
								<p>
									<input id="send_dynamicode_btn" type="button" class="btn btn-green btn-280 radius ml-20"
										value="<spring:message code="ycregister.getDynamiCode"/>">
								</p>
							</li>

							<li class="alink">
								<p class="ml-100"><input id="agreement" type="checkbox" class="radio" checked="checked"></p>
								<p><spring:message code="ycregister.agreement" arguments="${_base}/agreement"/></p>
								<p class="right"><a href="${_base}/p/index"><spring:message	code="ycregister.haveAccounts" /></a></p>
							</li>
							<li class="ml-100"><input id="regsiterBtn" type="button" class="btn btn-blue btn-415 radius20" value="<spring:message code="ycregister.registerNow" />"></li></ul>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
	var pager;
	(function() {
		seajs.use('app/jsp/user/register/register', function(registerPager) {
			pager = new registerPager({
				element : document.body
			});
			pager.render();
		});
        $("input").placeholder();
        $("#regsiterMsg").html("");
        //checkbox兼容ie8
//        $('.regsiter-form :checkbox').iCheck({
//            checkboxClass: 'icheckbox_flat-blue',
//            radioClass: 'iradio_flat-blue'
//        });
	})();
	var registerMsg = {
		"account_phone_empty" : '<spring:message code="ycregisterMsg.accountPhoneEmpty" />',
		"account_email_empty" : '<spring:message code="ycregisterMsg.accountEmailEmpty" />',
		"account_phone_error" : '<spring:message code="ycregisterMsg.accountPhoneError" />',
		"account_email_error" : '<spring:message code="ycregisterMsg.accountEmailError" />',
		"account_exists" : '<spring:message code="ycregisterMsg.accountExists" />',
		"password_empty" : '<spring:message code="ycregisterMsg.passwordEmpty" />',
		"password_error" : '<spring:message code="ycregisterMsg.passwordError" />',
		"confirm_password_empty" : '<spring:message code="ycregisterMsg.passwordEmpty" />',
		"confirm_password_error" : '<spring:message code="ycregisterMsg.confirmPasswordError" />',
		"verify_code_img_empty" : '<spring:message code="ycregisterMsg.verificationCodeEmpty" />',
		"verify_code_img_error" : '<spring:message code="ycregisterMsg.verificationCodeError" />',
		"agreement" : '<spring:message code="ycregisterMsg.agreement" />',
		"phone_registered" : '<spring:message code="ycregister.register.phone" />',
		"email_registered" : '<spring:message code="ycregister.register.email" />',
		"sms_code_empty":'<spring:message code="ycregisterMsg.smsEmpty"/>',
		"sms_code_error":'<spring:message code="ycregisterMsg.smsError"/>',
		"getDynamiCode":'<spring:message code="ycregister.getDynamiCode"/>',
		"resend":'<spring:message code="ycregisterMsg.resend"/>'
	};
</script>

</html>