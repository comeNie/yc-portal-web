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
  	<jsp:include page="/inc/leftmenu.jsp" />
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
								</p>
 								
 								<p id="telephone">13718206604</p>
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
 								<label class="ml-70" id="uphoneErrMsg" style="display: none;"></label>
 								<p class="word">手机:</p>
 								<p>
									<select id="country" class="select select-in radius"></select>
									<input type="text"  class="" id="uPhone">
								</p>
 								<p></p>
 							</li>
 							<li>
 								<p class="word">动态码:</p>
 								<p><input type="text" class="int-text int-in radius" id="uphoneDynamicode"></p>
 								<p><input type="button" class="btn border-green border-sma radius btn-medium" id="usend_dynamicode_btn" value="获取动态码">
 								</p>
 							</li>
 						</ul>
 					</div>
 				<!--按钮-->
 				<div class="recharge-btn">
 						<input type="button" id="unext-bt2" class="btn btn-green btn-xxxlarge radius10" value="提交">
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
 								<p>178070754@qq.com</p>
 							</li>
 							<li>
 								<p class="word">动态码:</p>
 								<p><input type="text" class="int-text int-in radius" id="emailIdentifyCode"></p>
 								<p><input type="button" class="btn border-green border-sma radius btn-medium" id="sendEmailBtn" value="获取动态码"></p>
 								<p><a href="#" id="goEmail">立即进入邮箱</a></p>
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
 								<label class="ml-70" id="emailUpdatePhoneErrMsg" style="display: none;"></label>
 								<p class="word">手机:</p>
 								<p>
									<select id="country" class="select select-in radius"></select>
								</p>
 								<p><input type="text" class="int-text int-large radius" id="emailUpdatePhone"></p>
 							</li>
 							<li>
 								<p class="word">验证码:</p>
 								<p><input type="text" class="int-text int-in radius" id="emailUValidateCode"></p>
 								<p><input type="button" class="btn border-green border-sma radius btn-medium" id="emailUpDynamicodeBtn" value="获取动态码"></p>
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
	var hash = {
		'qq.com' : 'http://mail.qq.com',
		'gmail.com' : 'http://mail.google.com',
		'sina.com' : 'http://mail.sina.com.cn',
		'163.com' : 'http://mail.163.com',
		'126.com' : 'http://mail.126.com',
		'yeah.net' : 'http://www.yeah.net/',
		'sohu.com' : 'http://mail.sohu.com/',
		'tom.com' : 'http://mail.tom.com/',
		'139.com' : 'http://mail.10086.cn/',
		'hotmail.com' : 'http://www.hotmail.com',
		'live.com' : 'http://login.live.com/',
		'live.cn' : 'http://login.live.cn/',
		'live.com.cn' : 'http://login.live.com.cn',
		'189.com' : 'http://webmail16.189.cn/webmail/',
		'yahoo.com.cn' : 'http://mail.cn.yahoo.com/',
		'yahoo.cn' : 'http://mail.cn.yahoo.com/',
		'eyou.com' : 'http://www.eyou.com/',
		'21cn.com' : 'http://mail.21cn.com/',
		'188.com' : 'http://www.188.com/',
		'foxmail.com' : 'http://mail.foxmail.com',
		'outlook.com' : 'http://www.outlook.com'
	}
	var email = "${sessionScope.user_session_key.mobile}";
	var phone = "${sessionScope.user_session_key.email}";
	$(document).ready(function(){
		$("#goEmail").click(function(){
			var _mail =email.split('@')[1];    //获取邮箱域
			var _host = hash[_mail];
			if(!_host){
				_host = 'http://mail.'+_mail;
			}
			location.href=_host;
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