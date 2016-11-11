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
				<jsp:include page="/inc/leftmenu.jsp" />
			</div>
			<!--右侧内容-->
			<!--右侧大块-->
			<div class="right-wrapper">
				<!--右侧第一块-->

				<!--右侧第二块-->
				<div class="right-list mt-0">
					<div class="right-list-title pb-10 pl-20">
						<p>设置登录密码</p>
					</div>
					<!--充值-->
					<div class="recharge mt-30">
						<div class="recharge-content">
							<div class="recharge-unionPay set-up" >
								<ul>
									<li ><a id="phoneVerification" href="javascript:void(0);" class="current"><i class="icon iconfont def">&#xe60b;</i><br>手机修改密码<label></label></a></li>
									<li ><a id="emailVerification" href="javascript:void(0);" class="ml-50"><i class="icon iconfont def">&#xe62f;</i><br>邮箱修改密码<label></label></a></li>
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
											<li class="word">设置密码</li>
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
											<p class="word">已绑定手机:</p>
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
											<li class="word">验证身份</li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stgreen-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word">设置密码</li>
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
											<li class="word">验证身份</li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-lightgreen-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word">设置密码</li>
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
										<li><img src="${uedroot}/images/rech-win.png"></li>
										<li class="word">设置密码成功</li>
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
											<li class="word">验证身份</li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stash-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word">设置密码</li>
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
											<p class="word">已绑定邮箱:</p>
											<p id="passwordEmail">${user.email}</p>
										</li>
										<li>
											<p class="word">验证码:</p>
 								            <p><input type="text" class="int-text int-in radius" id="emailIdentifyCode"></p>
 								            <p><input type="button" class="btn biu-btn radius btn-medium" value="发送验证邮件" id="sendEmailBtn"></p>
 								            <p><a href="javascript:void(0);" id="goEmail">立即进入邮箱</a></p>
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
											<li class="word">验证身份</li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-stgreen-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word">设置密码</li>
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
											<li class="word">验证身份</li>
										</ul>
										<p class="line"></p>
									</div>
									<!--未进行的状态-->
									<div class="place-step-none adopt-lightgreen-bj shezh-line">
										<ul>
											<li class="circle">2</li>
											<li class="word">设置密码</li>
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
<script type="text/javascript">
	var phone = "18929309495";
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
	$(document).ready(function(){
		$("#goEmail").click(function(){
			var _mail =email.split('@')[1];    //获取邮箱域
			var _host = hash[_mail];
			if(!_host){
				_host = 'http://mail.'+_mail;
			}
			window.open(_host);
		});
	});
</script>
</html>
