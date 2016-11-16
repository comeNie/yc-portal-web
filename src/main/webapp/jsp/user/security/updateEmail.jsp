<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:set var="_base" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>修改邮箱</title>
   <%@ include file="/inc/inc.jsp" %>
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
  	<jsp:include page="/inc/leftmenu.jsp">
  	  <jsp:param name="current" value="seccenterSettings" />
  	</jsp:include>
  	</div>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	<div class="right-wrapper">
  		<!--右侧第一块-->
	
  		<!--右侧第二块-->
  		<div class="right-list mt-0">
  			<div class="right-list-title pb-10 pl-20">
  				<p></p>	
  			</div>
  			<!--充值-->
 			<div class="recharge mt-30">
 				<div class="recharge-content">
 					<div class="recharge-unionPay set-up">
 						<ul>
 							<li id="phoneVerification"><a href="#" class="current"><i class="icon iconfont def">&#xe60b;</i><br>通过已验证手机验证<label></label></a></li>
 							<li id="emailVerification"><a href="#" class="ml-50"><i class="icon iconfont def">&#xe62f;</i><br>通过已验证邮箱验证<label></label></a></li>
 						</ul>
 					</div>
 					</div>
 				<div id="set-table1">
 				<div class="binding" id="next1">
 					<!--步骤-->
 					<div class="set-up-step">
 						<!--进行的状态-->
			 		<div class="place-step-none adopt-stgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">1</li>
			 				<li class="word">验证身份</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stash-bj shezh-line">
			 			<ul>
			 				<li class="circle">2</li>
			 				<li class="word">修改绑定邮箱</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stash-bj shezh-line">
			 			<ul>
			 				<li class="circle">3</li>
			 				<li class="word">完成</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
 					</div>
 					<!--表单-->
 					<div class="recharge-form-label mt-30 ">
 						<ul>
 							<li>
 								<label class="ml-70" id="dynamicode" style="display: none;"></label>
 								<p class="word">手机:</p>
 								<p>
									<select id="country" class="select select-in radius"></select>
									<input id="tempCode" type="hidden"/>
								</p>
 								
 								<p id="telephone">${sessionScope.user_session_key.mobile}</p>
 							</li>
 							<li>
 								<p class="word">动态码:</p>
 								<p><input type="text" class="int-text int-in radius" id="phoneDynamicode"></p>
 								<p><input type="button" class="btn border-green border-sma radius btn-medium" id="send_dynamicode_btn" value="获取动态码">
 								</p>
 								
 							</li>
 						</ul>
 					</div>
 				
 				
 				<!--按钮-->
 				<div class="recharge-btn">
 						<input type="button" id="next-bt1" class="btn btn-green btn-xxxlarge radius10" value="下一步">
 				</div>
 				</div>
 				<div class="binding" id="next2">
 					<!--步骤-->
 					<div class="set-up-step">
 						<!--进行的状态-->
			 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">1</li>
			 				<li class="word">验证身份</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">2</li>
			 				<li class="word">修改绑定邮箱</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stash-bj shezh-line">
			 			<ul>
			 				<li class="circle">3</li>
			 				<li class="word">完成</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
 					</div>
 					<!--表单-->
 					<div class="recharge-form-label mt-30 ">
 						<ul>
 							<li>
 								<label class="ml-70" id="phoneUEmailErrMgs" style="display: none;"></label>
 								<p class="word">邮箱:</p>
 								<p><input type="text" class="int-text int-xlarge radius" id="phoneUEmail"></p>
 							</li>
 							<li>
 								<p class="word">验证码:</p>
 								<p><input type="text" class="int-text int-in radius" id="phoneUEmailCode"></p>
 								<p><input type="button" class="btn border-green border-sma radius btn-medium" id="phone-send-email-btn" value="获取动态码"></p>
 								<p><a id="goEmail1" href="javascript:void(0);">立即进入邮箱</a></p>
 							</li>
 						</ul>
 					</div>
 				<!--按钮-->
 				<div class="recharge-btn">
 						<input type="button" id="pnext-bt2" class="btn btn-green btn-xxxlarge radius10" value="提交">
 				</div>
 				</div>
 				<div class="binding" id="next3">
 					<!--步骤-->
 					<div class="set-up-step">
 						<!--进行的状态-->
			 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">1</li>
			 				<li class="word">验证身份</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">2</li>
			 				<li class="word">修改绑定邮箱</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">3</li>
			 				<li class="word">完成</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
 					</div>
 					<!--表单-->
 					<div class="recharge-success mt-40">
 						<ul>
 							<li><img src="${uedroot }/images/rech-win.png"></li>
 							<li class="word">修改绑定邮箱成功</li>
 						</ul>
 					</div>
 			
 				</div>
 				</div>
 				<div id="set-table2" style="display:none">
 				<div class="binding" id="next4">
 					<!--步骤-->
 					<div class="set-up-step">
 						<!--进行的状态-->
			 		<div class="place-step-none adopt-stgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">1</li>
			 				<li class="word">验证身份</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stash-bj shezh-line">
			 			<ul>
			 				<li class="circle">2</li>
			 				<li class="word">修改绑定邮箱</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stash-bj shezh-line">
			 			<ul>
			 				<li class="circle">3</li>
			 				<li class="word">完成</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
 					</div>
 					<!--表单-->
 					<div class="recharge-form-label mt-30 ">
 						<ul>
 							<li>
 								<label class="ml-70" id="emailErrMsg" style="display: none;"></label>
 								<p class="word">已绑定邮箱:</p>
 								<p id="goEmail2Val">${sessionScope.user_session_key.email}</p>
 							</li>
 							<li>
 								<p class="word">动态码:</p>
 								<p><input type="text" class="int-text int-in radius" id="emailIdentifyCode"></p>
 								<p><input type="button" class="btn border-green border-sma radius btn-medium" id="sendEmailBtn" value="获取动态码"></p>
 								<p><a href="javascript:void(0);" id="goEmail2">立即进入邮箱</a></p>
 							</li>
 						</ul>
 					</div>
 				
 				
 				<!--按钮-->
 				<div class="recharge-btn">
 						<input type="button" id="next-bt4" class="btn btn-green btn-xxxlarge radius10" value="下一步">
 				</div>
 				</div>
 				<div class="binding" id="next5">
 					<!--步骤-->
 					<div class="set-up-step">
 						<!--进行的状态-->
			 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">1</li>
			 				<li class="word">验证身份</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">2</li>
			 				<li class="word">修改绑定邮箱</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stash-bj shezh-line">
			 			<ul>
			 				<li class="circle">3</li>
			 				<li class="word">完成</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
 					</div>
 					<!--表单-->
 					<div class="recharge-form-label mt-30 ">
 						<ul>
 							<li>
 								<label class="ml-70" id="emailUErrMsg" style="display: none;"></label>
 								<p class="word">邮箱:</p>
 								<p><input type="text" class="int-text int-xlarge radius" id="emailUpdateEmail"></p>
 							</li>
 							<li>
 								<p class="word">验证码:</p>
 								<p><input type="text" class="int-text int-in radius" id="uEmailCode"></p>
 								<p><input type="button" class="btn border-green border-sma radius btn-medium" id="email-sendCode-btn" value="获取验证码"></p>
 								<p><a href="javascript:void(0);" id="goEmail3">立即进入邮箱</a></p>
 							</li>
 						</ul>
 					</div>
 				<!--按钮-->
 				<div class="recharge-btn">
 						<input type="button" id="next-bt5" class="btn btn-green btn-xxxlarge radius10" value="提交">
 				</div>
 				</div>
 				<div class="binding" id="next6">
 					<!--步骤-->
 					<div class="set-up-step">
 						<!--进行的状态-->
			 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">1</li>
			 				<li class="word">验证身份</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-lightgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">2</li>
			 				<li class="word">修改绑定邮箱</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-stgreen-bj shezh-line">
			 			<ul>
			 				<li class="circle">3</li>
			 				<li class="word">完成</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
 					</div>
 					<!--表单-->
 					<div class="recharge-success mt-40">
 						<ul>
 							<li><img src="${uedroot }/images/rech-win.png"></li>
 							<li class="word">修改绑定邮箱成功</li>
 						</ul>
 					</div>
 				
 				</div>
 				</div>
 			</div>
  	</div>
  </div>
  </div>
  </div>
<%@ include file="/inc/incJs.jsp" %>
<script src="${_base}/resources/spm_modules/email/emailHandle.js"></script>
<script type="text/javascript">
var pager;
(function() {
	seajs.use('app/jsp/user/security/updateEmail', function(updateEmailPager) {
		pager = new updateEmailPager({
			element : document.body
		});
		pager.render();
	});
})();
</script>
<script type="text/javascript">
	var phone = "${sessionScope.user_session_key.mobile}";
	var email = "${sessionScope.user_session_key.email}";
	$(document).ready(function(){
		$("#goEmail1").click(function(){
			$emailHandle.openEmail($("#phoneUEmail").val());
		});
		$("#goEmail2").click(function(){
			$emailHandle.openEmail(email);
		});
		$("#goEmail3").click(function(){
			$emailHandle.openEmail($("#emailUpdateEmail").val());
		});
	});
	var updateEmailMsg = {
			"account_empty" : '<spring:message code="ycregisterMsg.accountEmpty" />',
			"account_error" : '<spring:message code="ycregisterMsg.accountError" />',
			"password_empty" : '<spring:message code="ycregisterMsg.passwordEmpty" />',
			"password_error" : '<spring:message code="ycregisterMsg.passwordError" />',
			"confirm_password_empty" : '<spring:message code="ycregisterMsg.passwordEmpty" />',
			"confirm_password_error" : '<spring:message code="ycregisterMsg.confirmPasswordError" />',
			"verify_code_img_empty" : '<spring:message code="ycregisterMsg.verificationCodeEmpty" />',
			"verify_code_img_error" : '<spring:message code="ycregisterMsg.verificationCodeError" />',
			"agreement" : '<spring:message code="ycregisterMsg.agreement" />',
			"phone_registered" : '<spring:message code="ycregister.register.phone" />',
			"email_registered" : '<spring:message code="ycregister.register.email" />',
			"getDynamiCode":'<spring:message code="ycregister.getDynamiCode"/>'
		};
</script>

</body>
</html>