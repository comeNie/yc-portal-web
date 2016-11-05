<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>邮箱注册验证码</title>
<%@ include file="/inc/inc.jsp"%>
<link href="${uedroot}/css/modular/login-regsiter.css" rel="stylesheet"
	type="text/css" />
</head>
<body class="login-body">
	<div class="login-big">
		<div class="login-headr">
			<p>
				<img src="${uedroot}/images/login-logo.png" />
			</p>
			<p class="word">账号注册</p>
		</div>
		<div class="login-wrapper">
			<div class="login-left">
				<img src="${uedroot}/images/login-bj.png">
			</div>
			<div class="register-right radius">

				<div class="verification">
					<ul>
						<li><img src="${uedroot}/images/rech-win.png" /></li>
						<li class="word">已成功发送邮件至${email}</li>
						<li>验证邮件24小时内有效，请尽快登录您的邮箱<a id="goEmail"
							href="javascript:void(0);">点击验证链接</a>完成验证
						</li>
					</ul>
				</div>

			</div>
		</div>


	</div>
</body>
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
	var email = "${email}";
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
</script>
</html>