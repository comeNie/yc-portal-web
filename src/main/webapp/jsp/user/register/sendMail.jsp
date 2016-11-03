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
<link href="${uedroot}/css/modular/login-regsiter.css"
	rel="stylesheet" type="text/css" />
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
						<li class="word">已成功发送邮件至y*****t@163.com</li>
						<li>验证邮件24小时内有效，请尽快登录您的邮箱<a href="#">点击验证链接</a>完成验证
						</li>
					</ul>
				</div>

			</div>
		</div>


	</div>
</body>
</html>