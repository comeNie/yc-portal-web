<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>注册成功</title>
    <%@ include file="/inc/inc.jsp"%>
    <link href="${uedroot}/css/modular/login-regsiter.css"
	rel="stylesheet" type="text/css" />
</head>
<body class="login-body">
		<div class="login-big">
			<div class="login-headr"><p><img src="${uedroot}/images/login-logo.png" /></p><p class="word">账号注册</p></div>
			<div class="login-wrapper">
				<div class="login-left"><img src="${uedroot}/images/login-bj.png"></div>
				<div class="register-right radius">

					<div class="verification">
						<ul>
							<li><img src="${uedroot}/images/rech-win.png" /></li>
							<li class="word">恭喜您注册成功</li>
							<li><span>5s</span>内自动回到<a href="#">登录</a>页面</li>
							<li>恭喜您获得平台赠送的翻译体验金，欢迎您体验<a href="#">人工翻译</a>服务。</li>
						</ul>
					</div>
					
				</div>
			</div>
			
			
		</div>
</body>
<%@ include file="/inc/incJs.jsp" %>
</html>