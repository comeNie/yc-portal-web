<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="_base" value="${pageContext.request.contextPath}" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>注册失败</title>
<link href="${_base}/resources/template/css/bootstrap/font-awesome.css" rel="stylesheet"
	type="text/css">
<link href="${_base}/resources/template/css/iconfont.css" rel="stylesheet" type="text/css">
<link href="${_base}/resources/template/css/modular/global.css" rel="stylesheet" type="text/css" />
<link href="${_base}/resources/template/css/modular/login-regsiter.css" rel="stylesheet"
	type="text/css" />
</head>
<body class="login-body">
	<div class="login-big">
		<div class="login-headr">
			<p>
				<img src="${_base}/resources/template/images/login-logo.png" />
			</p>
			<p class="word">账号注册</p>
		</div>
		<div class="login-wrapper">
			<div class="login-left">
				<img src="${_base}/resources/template/images/login-bj.png">
			</div>
			<div class="register-right radius">

				<div class="verification">
					<ul>
						<li><img src="${_base}/resources/template/images/rech-fail.png" /></li>
						<li class="word">抱歉，激活链接已经过期失效，请重新注册</li>
						<li><span>5s</span>内自动回到<a href="#">注册</a>页面</li>
					</ul>
				</div>

			</div>
		</div>


	</div>
</body>
</html>
