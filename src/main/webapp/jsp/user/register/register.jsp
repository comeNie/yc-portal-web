<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>邮箱注册</title>
<%@ include file="/inc/inc.jsp"%>
<link href="${_base}/resources/template/css/modular/login-regsiter.css"
	rel="stylesheet" type="text/css" />
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
				<div class="login-title">注册</div>
				<div class="login-form-title">
					<ul>
						<label class="ml-70" id="regsiterMsg"></label>
						<p class="right">
							<a id="change_register_type" href="javascript:void(0);" register_type="phone"><i class="icon iconfont">&#xe614;</i>邮箱注册</a>
						</p>
					</ul>
				</div>
				 <form id="regsiterForm" method="post" >
				<div class="regsiter-form">
					<ul>
					    <li id="li_register_phone_container">
								<p class="word">手机号:</p>
								<p><select class="select select-in radius"><option>86+ 中国</option></select></p>
								<p class="ml-20"><input type="text" class="int-text int-in-bi radius"></p>
							</li>
					    
						<li id="li_register_email_container" style="display: none;">
							<p class="word">邮箱:</p>
							<p>
								<input id="email" maxlength="100" name="email" type="text" class="int-text int-in-big radius">
							</p>
						</li>
						<li>
							<p class="word">密码:</p>
							<p>
								<input id="password" maxlength="16" name="password" type="password" class="int-text int-in-big radius">
							</p>
						</li>
						<li>
							<p class="word">确认密码:</p>
							<p>
								<input id="confirmPassword" maxlength="16"  name="confirmPassword" type="password" class="int-text int-in-big radius">
							</p>
						</li>
						<li>
							<p class="word">验证码:</p>
							<p>
								<input type="text" class="int-text int-in-280 radius">
							</p>
							<p class="img">
								<img id="refreshVerificationCode"
									src="${_base}/reg/imageVerifyCode" height="44">
							</p>
						</li>
                        <li id="li_register_phone_code_container">
								<p class="word">动态码:</p>
								<p><input type="text" class="int-text int-in-280 radius"></p>
								<p><input type="button" class="btn btn-green btn-280 radius ml-20" value="获取动态码"></p>
							</li>
                        
						<li class="alink">
							<p class="ml-100">
								<input type="checkbox" class="radio" checked="">
							</p>
							<p>
								我已阅读并同意<a href="#">《译云用户协议》</a>
							</p>
							<p class="right">
								<a href="#">已有账户，直接登录</a>
							</p>
						</li>
						<li class="ml-100"><input id="regsiterBtn" type="button"
							class="btn btn-blue btn-415 radius20" value="立即注册"></li>


					</ul>
				</div>
               </form>
			</div>
		</div>


	</div>
</body>
<script type="text/javascript">
	var pager;
	(function() {
		seajs.use('user/register/register', function(registerPager) {
			pager = new registerPager({
				element : document.body
			});
			pager.render();
		});
	})();
</script>

</html>