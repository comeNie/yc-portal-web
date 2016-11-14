<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
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
						<p><spring:message code="ycaccountcenter.updatePassword.title"/></p>
					</div>
					<!--充值-->
					<div class="recharge mt-30">
						<div class="recharge-content">
							<div class="recharge-unionPay set-up" >
								<ul>
									<li ><a id="phoneVerification" href="javascript:void(0);" class="current"><i class="icon iconfont def">&#xe60b;</i><br><spring:message code="ycaccountcenter.updatePassword.phoneVerification"/><label></label></a></li>
									<li ><a id="emailVerification" href="javascript:void(0);" class="ml-50"><i class="icon iconfont def">&#xe62f;</i><br><spring:message code="ycaccountcenter.updatePassword.emailVerification"/><label></label></a></li>
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
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step1"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stash-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step2"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stash-bj shezh-line">
										<ul>
											<li class="circle">3</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step3"/></li>
										</ul>
										<p class="line"></p>
									</div>
								</div>
								<!--表单-->
								<div class="recharge-form-label mt-30 ">
									<ul>
										<li> 
										    <label class="ml-70" id="dynamicode" style="display: none;"></label>
											<p class="word"><spring:message code="ycaccountcenter.updatePassword.bindPhone"/></p>
											<p id="telephone">18929309495</p>
										</li>
										<li>
											<p class="word">动态码:</p>
											<p>
												<input id="phoneDynamicode" type="text" class="int-text int-in radius">
											</p>
											<p>
												<input type="button" id="send_dynamicode_btn"
													class="btn border-green border-sma radius btn-medium"
													value="获取动态码">
											</p>
										</li>
									</ul>
								</div>


								<!--按钮-->
								<div class="recharge-btn">
									<input type="button" id="next-bt1"
										class="btn btn-green btn-xxxlarge radius10" value="下一步">
								</div>
							</div>
							<div class="binding" id="next2">
								<!--步骤-->
								<div class="set-up-step">
									<!--进行的状态-->
									<div class="place-step-none adopt-lightgreen-bj shezh-line">
										<ul>
											<li class="circle">1</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step1"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stgreen-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step2"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stash-bj shezh-line">
										<ul>
											<li class="circle">3</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step3"/></li>
										</ul>
										<p class="line"></p>
									</div>
								</div>
								<!--表单-->
								<div class="recharge-form-label mt-30 ">
									<ul>
									<li>
		 								<label class="ml-70" id="passwordMsg" style="display: none;">输入账号错误</label>
		 								<p class="word">密码:</p>
		 								<p><input type="text" class="int-text int-xlarge radius" id="password"></p>
		 							</li>
		 							<li>
		 								<p class="word">确认密码:</p>
		 								<p><input type="text" class="int-text int-xlarge radius" id="confirmPassword"></p>
		 							</li>
									</ul>
								</div>
								<!--按钮-->
								<div class="recharge-btn">
									<input type="button" id="next-bt2"
										class="btn btn-green btn-xxxlarge radius10" value="提交">
								</div>
							</div>
							<div class="binding" id="next3">
								<!--步骤-->
								<div class="set-up-step">
									<!--进行的状态-->
									<div class="place-step-none adopt-lightgreen-bj shezh-line">
										<ul>
											<li class="circle">1</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step1"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-lightgreen-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step2"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stgreen-bj shezh-line">
										<ul>
											<li class="circle">3</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step3"/></li>
										</ul>
										<p class="line"></p>
									</div>
								</div>
								<!--表单-->
								<div class="recharge-success mt-40">
									<ul>
										<li><img src="${uedroot}/images/rech-win.png"></li>
										<li class="word"><spring:message code="ycaccountcenter.updatePassword.step2"/>成功</li>
									</ul>
								</div>

							</div>
						</div>
						<div id="set-table2" style="display: none">
							<div class="binding" id="next4">
								<!--步骤-->
								<div class="set-up-step">
									<!--进行的状态-->
									<div class="place-step-none adopt-stgreen-bj shezh-line">
										<ul>
											<li class="circle">1</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step1"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stash-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step2"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stash-bj shezh-line">
										<ul>
											<li class="circle">3</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step3"/></li>
										</ul>
										<p class="line"></p>
									</div>
								</div>
								<!--表单-->
								<div class="recharge-form-label mt-30 ">
									<ul>
										<li>
											<p class="word"><spring:message code="ycaccountcenter.updatePassword.bindEmail"/></p>
											<p id="passwordEmail">${user.email}</p>
										</li>
										<li>
											<p class="word">验证码:</p>
 								            <p><input type="text" class="int-text int-in radius" id="emailIdentifyCode"></p>
 								            <p><input type="button" class="btn biu-btn radius btn-medium" value="<spring:message code="ycaccountcenter.updatePassword.sendEmailCode"/>" id="sendEmailBtn"></p>
 								            <p><a href="javascript:void(0);" id="goEmail"><spring:message code="ycaccountcenter.updatePassword.goEmail"/></a></p>
										</li>
									</ul>
								</div>


								<!--按钮-->
								<div class="recharge-btn">
									<input type="button" id="next-bt4"
										class="btn btn-green btn-xxxlarge radius10" value="下一步">
								</div>
							</div>
							<div class="binding" id="next5">
								<!--步骤-->
								<div class="set-up-step">
									<!--进行的状态-->
									<div class="place-step-none adopt-lightgreen-bj shezh-line">
										<ul>
											<li class="circle">1</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step1"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stgreen-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step2"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stash-bj shezh-line">
										<ul>
											<li class="circle">3</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step3"/></li>
										</ul>
										<p class="line"></p>
									</div>
								</div>
								<!--表单-->
								<div class="recharge-form-label mt-30 ">
									<ul>
										<li>
			 								<label class="ml-70" id="emailPasswordErrMsg" style="display: none;"></label>
			 								<p class="word">密码:</p>
			 								<p><input type="text" class="int-text int-xlarge radius" id="emailPassword"></p>
	 									</li>
			 							<li>
			 								<p class="word">确认密码:</p>
			 								<p><input type="text" class="int-text int-xlarge radius" id="emailConfirmPassword"></p>
			 							</li>
									</ul>
								</div>
								<!--按钮-->
								<div class="recharge-btn">
									<input type="button" id="next-bt5"
										class="btn btn-green btn-xxxlarge radius10" value="提交">
								</div>
							</div>
							<div class="binding" id="next6">
								<!--步骤-->
								<div class="set-up-step">
									<!--进行的状态-->
									<div class="place-step-none adopt-lightgreen-bj shezh-line">
										<ul>
											<li class="circle">1</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step1"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-lightgreen-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step2"/></li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stgreen-bj shezh-line">
										<ul>
											<li class="circle">3</li>
											<li class="word"><spring:message code="ycaccountcenter.updatePassword.step3"/></li>
										</ul>
										<p class="line"></p>
									</div>
								</div>
								<!--表单-->
								<div class="recharge-success mt-40">
									<ul>
										<li><img src="${uedroot}/images/rech-win.png"></li>
										<li class="word">修改密码成功</li>
									</ul>
								</div>

							</div>
						</div>
					</div>

				</div>
			</div>


		</div>

	</div>
	<input type="hidden" id="code"/>
</body>
<%@ include file="/inc/incJs.jsp"%>
<script src="${_base}/resources/spm_modules/email/emailHandle.js"></script>

<script type="text/javascript">
	var phone = "${user.mobile}";
	var email = "${user.email}";
	var pager;
	(function() {
		seajs.use('app/jsp/user/security/updatePassword', function(updatePasswordPager) {
			pager = new updatePasswordPager({
				element : document.body
			});
			pager.render();
		});
	})();
	
	$(document).ready(function(){
		$("#goEmail").click(function(){
			$emailHandle.openEmail(email);
		});
	});
</script>
</html>
