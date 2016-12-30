<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/inc/inc.jsp" %>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title><spring:message code="ycfindpassword.forgetPassword"/></title>
    <link href="${uedroot}/css/modular/login-regsiter.css" rel="stylesheet" type="text/css" />
</head>
<body class="login-body">
  		<!--右侧第二块-->
  		<form method="post">
  		<div class="login-big">
			<div class="login-headr">
			<p>
			<img src="${uedroot }/images/login-logo.png" onclick="location.href='${_base}/'" />
			</p>
			<p class="word">
			<spring:message code="ycfindpassword.forgetPassword" />
			</p>
			</div>
			
			<div class="password-bj">
				<!--输入账号-->
				<div class="back" id="back-pass">
				<div class="recharge-content">
 					<div class="recharge-form-label mt-20">
 						<ul>
 							<li>
 								<input type="hidden" id="userId" name="uid"/>
 								<input type="hidden" id="tcode"/>
 								<input type="hidden" id="t_userName" name="t_userName"/>
 								<label class="ml-70" id="accountErrMsg" style="display: none;"></label>
 								<p class="word"><spring:message code="ycfindpassword.account"/></p>
 								<p><input type="text" class="int-text int-in-big radius" name="userName" id="userName" placeholder="<spring:message code="ycfindpassword.account.tip"/>"></p>
 								<label id="userNameErrMsg" style="display: none;"><span class="ash" id="userNameText"></span></label>
 								
 							</li>
 							<li>
 								<p class="word"><spring:message code="ycfindpassword.captcha"/></p>
 								<p><input type="text" class="int-text int-large radius" id="verifyCodeImg" placeholder="<spring:message code="ycfindpassword.verificationCode.tip"/>"></p>
 								<p><img id="refreshVerificationCode"
										src="${_base}/userCommon/imageVerifyCode" height="44"
										style="cursor: pointer"></p>
								<label id="verifyCodeImgErrMsg" style="display: none;"><span class="ash" id="verifyCodeImgText"></span></label>
 							</li>
 						</ul>
 					</div>	
 				</div>
 				
 				<div class="recharge-btn">
 						<input type="button" id="find_password_next-btn" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="ycfindpassword.next" />">
 			 	</div>
 			 	</div>
 				<!--输入账号结束-->
				<!--找回密码操作-->
				<div class="forget" id="back-pass1">
					<div class="recharge-unionPay set-up">
 						<ul>
 							<li id="phoneVerification"><a href="javascript:void(0);" class="current"><i class="icon iconfont def">&#xe60b;</i><br><spring:message code="ycfindpassword.byPhone"/><label></label></a></li>
 							<li id="emailVerification"><a href="javascript:void(0);" class="ml-50"><i class="icon iconfont def">&#xe62f;</i><br><spring:message code="ycfindpassword.byMail"/><label></label></a></li>
 						</ul>
 					</div>
 				<!--tab1-->	
 				<div id="set-table1">
 					<div id="next1">
 					<!--步骤-->
 					<div class="set-up-step">
 						<!--进行的状态-->
			 		<div class="place-step-none adopt-stgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">1</li>
			 				<li class="word"><spring:message code="ycfindpassword.step1"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stash-bj shezh-line">
			 			<ul>
			 				<li class="circle">2</li>
			 				<li class="word"><spring:message code="ycfindpassword.step2"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stash-bj shezh-line">
			 			<ul>
			 				<li class="circle">3</li>
			 				<li class="word"><spring:message code="ycfindpassword.step3"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
 					</div>
 					<!--表单-->
 					<div class="recharge-form-label mt-30">
 						<ul>
 							<li>
 								<label class="ml-70" id="dynamicode" style="display: none;"></label>
 								<p class="word"><spring:message code="ycfindpassword.phoneLabel"/></p>
 								<p id="telephone"></p>
 							</li>
 							<li>
 								<p class="word"><spring:message code="ycfindpassword.dynamicCodeLabel"/></p>
 								<p><input type="text" class="int-text int-in radius" id="phoneDynamicode"></p>
 								<p><input type="button" class="btn border-green border-sma radius btn-medium" id="send_dynamicode_btn" value="<spring:message code="ycfindpassword.dynamicCodeBtn"/>">
 								</p>
 								
 							</li>
 						</ul>
 					</div>
 				
 				<!--按钮-->
 				<div class="recharge-btn btn40">
 						<input type="button" id="find_password_next-bt1" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="ycfindpassword.next" />">
 				</div>	
				</div>
					<div id="next2">
	 					<!--步骤-->
	 					<div class="set-up-step">
	 						<!--进行的状态-->
				 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
				 			<ul>
				 				<li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
				 				<li class="word"><spring:message code="ycfindpassword.step1"/></li>
				 			</ul>
				 			<p class="line"></p>
				 		</div>
				 		<!--未进行的状态-->
				 		<div class="place-step-none adopt-stgreen-bj shezh-line">
				 			<ul>
				 				<li class="circle">2</li>
				 				<li class="word"><spring:message code="ycfindpassword.step2"/></li>
				 			</ul>
				 			<p class="line"></p>
				 		</div>
				 		<!--未进行的状态-->
				 		<div class="place-step-none adopt-stash-bj shezh-line">
				 			<ul>
				 				<li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
				 				<li class="word"><spring:message code="ycfindpassword.step3"/></li>
				 			</ul>
				 			<p class="line"></p>
				 		</div>
	 					</div>
	 					<!--表单-->
	 					<div class="recharge-form-label mt-30 ">
	 						<ul>
	 							<li>
	 								<label class="ml-70" id="passwordMsg" style="display: none;"></label>
	 								<p class="word"><spring:message code="ycfindpassword.password"/></p>
	 								<p><input type="password" autocomplete="off"  maxlength="16" class="int-text int-xlarge radius" id="password"></p>
	 							</li>
	 							<li>
	 								<p class="word"><spring:message code="ycfindpassword.confirmPassword"/></p>
	 								<p><input type="password" autocomplete="off"  maxlength="16" class="int-text int-xlarge radius" id="confirmPassword"></p>
	 							</li>
	 						</ul>
	 					</div>
	 				
	 				<!--按钮-->
	 				<div class="recharge-btn btn40">
	 						<input type="button" id="find_password_next-bt2" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="ycfindpassword.next" />">
	 				</div>	
					</div>

					<div id="next3">
 					<!--步骤-->
 					<div class="set-up-step">
 						<!--进行的状态-->
			 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
			 				<li class="word"><spring:message code="ycfindpassword.step1"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
			 				<li class="word"><spring:message code="ycfindpassword.step2"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
			 				<li class="word"><spring:message code="ycfindpassword.step3"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
 					</div>
 					<!--表单-->
 					<div class="recharge-success mt-40">
 						<ul>
 							<li><img src="${uedroot }/images/rech-win.png"></li>
 							<li class="word"><spring:message code="ycfindpassword.success"/></li>
 							<li class="word" id="goIndexCountDown2"><spring:message arguments="${_base}/p/index" code="ycfindpassword.success.countDown"/></li>
 						</ul>
 					</div>
 				
				</div>
				</div>
				<!--tab1-->	
 				<div id="set-table2" style="display:none">
 					<div id="next4">
 					<!--步骤-->
 					<div class="set-up-step">
 						<!--进行的状态-->
			 		<div class="place-step-none adopt-stgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">1</li>
			 				<li class="word"><spring:message code="ycfindpassword.step1"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stash-bj shezh-line">
			 			<ul>
			 				<li class="circle">2</li>
			 				<li class="word"><spring:message code="ycfindpassword.step2"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stash-bj shezh-line">
			 			<ul>
			 				<li class="circle">3</li>
			 				<li class="word"><spring:message code="ycfindpassword.step3"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
 					</div>
 					<!--表单-->
 					<div class="recharge-form-label mt-30 ">
 						<ul>
 							<li>
 								<label class="ml-70" id="emailErrMsg" style="display: none;"></label>
 								<p class="word"><spring:message code="ycfindpassword.emailLabel"/></p>
 								<p id="passwordEmail"></p>
 							</li>
 							<li>
 								<p class="word"><spring:message code="ycfindpassword.dynamicCodeLabel"/></p>
 								<p><input type="text" class="int-text int-in radius" id="emailIdentifyCode"></p>
 								<p><input type="button" class="btn border-green border-sma radius btn-medium" value="<spring:message code="ycfindpassword.dynamicCodeBtn"/>" id="sendEmailBtn"></p>
 								<p><a href="javascript:void(0);" id="goEmail"><spring:message code="ycfindpassword.goEmail"/></a></p>
 							</li>
 						</ul>
 					</div>
 				
 				<!--按钮-->
 				<div class="recharge-btn btn40">
 						<input type="button" id="find_password-next-bt4" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="ycfindpassword.next" />">
 				</div>	
				</div>
					<div id="next5">
	 					<!--步骤-->
	 					<div class="set-up-step">
	 						<!--进行的状态-->
				 		<div class="place-step-none adopt-lightgreen-bj shezh-line" >
				 			<ul>
				 				<li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
				 				<li class="word"><spring:message code="ycfindpassword.step1"/></li>
				 			</ul>
				 			<p class="line"></p>
				 		</div>
				 		<!--未进行的状态-->
				 		<div class="place-step-none adopt-stgreen-bj shezh-line">
				 			<ul>
				 				<li class="circle">2</li>
				 				<li class="word"><spring:message code="ycfindpassword.step2"/></li>
				 			</ul>
				 			<p class="line"></p>
				 		</div>
				 		<!--未进行的状态-->
				 		<div class="place-step-none adopt-stash-bj shezh-line">
				 			<ul>
				 				<li class="circle">3</li>
				 				<li class="word"><spring:message code="ycfindpassword.step3"/></li>
				 			</ul>
				 			<p class="line"></p>
				 		</div>
	 					</div>
	 					<!--表单-->
	 					<div class="recharge-form-label mt-30 ">
	 						<ul>
	 							<li>
	 								<label class="ml-70" id="emailPasswordErrMsg" style="display: none;"></label>
	 								<p class="word"><spring:message code="ycfindpassword.password"/></p>
	 								<p><input type="password" autocomplete="off"  class="int-text int-xlarge radius" id="emailPassword"></p>
	 							</li>
	 							<li>
	 								<p class="word"><spring:message code="ycfindpassword.confirmPassword"/></p>
	 								<p><input type="password" autocomplete="off"  class="int-text int-xlarge radius" id="emailConfirmPassword"></p>
	 							</li>
	 						</ul>
	 					</div>
	 				
	 				<!--按钮-->
	 				<div class="recharge-btn btn40">
	 						<input type="button" id="find_password-next-bt5" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="ycfindpassword.next" />">
	 				</div>	
					</div>

					<div id="next6">
 					<!--步骤-->
 					<div class="set-up-step">
 						<!--进行的状态-->
			 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
			 				<li class="word"><spring:message code="ycfindpassword.step1"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
			 				<li class="word"><spring:message code="ycfindpassword.step2"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
			 				<li class="word"><spring:message code="ycfindpassword.step3"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
 					</div>
 					<!--表单-->
 					<div class="recharge-success mt-40">
 						<ul>
 							<li><img src="${uedroot}/images/rech-win.png"></li>
 							<li class="word"><spring:message code="ycfindpassword.success"/></li>
 							<li class="word" id="goIndexCountDown1"><spring:message arguments="${_base}/p/index" code="ycfindpassword.success.countDown"/></li>
 						</ul>
 					</div>
 			
				</div>
				</div>
			
		</div>	
		</div>
		
  	</div>
  	</form>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
var pager;
(function() {
	seajs.use('app/jsp/user/password/password', function(passwordPager) {
		pager = new passwordPager({
			element : document.body
		});
		pager.render();
	});
    $("input").placeholder();
})();
</script>
<script src="${_base}/resources/spm_modules/email/emailHandle.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#goEmail").click(function(){
			$emailHandle.openEmail($("#passwordEmail").html());
		});
	});
	var passwordMsg = {
			"showOkValueMsg" : '<spring:message code="ycaccountcenter.js.showOkValueMsg"/>',
    		"showTitleMsg" : '<spring:message code="ycaccountcenter.js.showTitleMsg"/>',
    		"notBindingPhone" : '<spring:message code="ycaccountcenter.updatePassword.notBindingPhone"/>',
    		"notBindingEmail" : '<spring:message code="ycaccountcenter.updatePassword.notBindingEmail"/>',
    		'sendMailError':'<spring:message code="ycaccountcenter.updatePassword.sendMailError"/>',
			"account_empty" : '<spring:message code="ycfindpassword.accountEmpty" />',
			"account_not_exist" : '<spring:message code="ycfindpassword.accountNotExist" />',
			"password_empty" : '<spring:message code="ycfindpassword.passwordEmpty" />',
			"password_error" : '<spring:message code="ycfindpassword.passwordError" />',
			"confirm_password_empty" : '<spring:message code="ycfindpassword.passwordEmpty" />',
			"confirm_password_error" : '<spring:message code="ycfindpassword.confirmPasswordError" />',
			"verify_code_img_empty" : '<spring:message code="ycfindpassword.captchaEmpty" />',
			"verify_code_img_error" : '<spring:message code="ycfindpassword.captchaError" />',
			"smsCodeEmpty" : '<spring:message code="ycfindpassword.smsCodeEmpty" />',
			"smsCodeError" : '<spring:message code="ycfindpassword.smsCodeError" />',
			"emailCodeEmpty" : '<spring:message code="ycfindpassword.emailCodeEmpty" />',
			"emailCodeError" : '<spring:message code="ycfindpassword.emailCodeError" />',
			"getDynamiCode":'<spring:message code="ycregister.getDynamiCode"/>',
			"resend60":'<spring:message code="ycfindpassword.js.resend60"/>',
			"resend":'<spring:message code="ycfindpassword.js.resend"/>'
		};
</script>

</body>
</html>