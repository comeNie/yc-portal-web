<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@ include file="/inc/inc.jsp"%>
</head>
<body>
	<!--头部-->
	<div class="header-big">
		<div class="cloud-header">
			<div class="logo">
				<a href="#"><img src="${uedroot}/images/logo.png" /></a>
			</div>
			<!--导航-->
			<div class="cloud-nav">
				<ul>
					<li class="current"><a href="#">我是客户</a></li>
					<li><a href="#">我是服务方</a></li>
				</ul>
			</div>
			<!--导航-->
			<div class="cloud-breadcrumb">
				<ul>
					<li><select class="select select-topmini none-select">
							<option>简体中文</option>
							<option>ENGLISH</option>
					</select> <i class="icon-caret-down"></i></li>
					<li class="nav-icon"><a href="#"><i class="icon iconfont">&#xe60b;</i></a></li>
					<li class="nav-icon mt-2"><a href="#"><i
							class="icon iconfont">&#xe60a;</i><span class="message">3</span></a></li>
					<li class="user"><a href="#" class="yonh">爱大脸大脸<i
							class="icon-caret-down"></i></a>
						<div class="show">
							<ul>
								<li><i class="icon-user"></i><a href="#">个人信息</a></li>
								<li><i class="icon-lock"></i><a href="#">安全设置</a></li>
								<li><i class="icon-off"></i><a href="#">退出</a></li>
							</ul>
						</div></li>
				</ul>
			</div>
		</div>
	</div>
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
						<p>设置登录密码（设置支付密码）</p>
					</div>
					<!--充值-->
					<div class="recharge mt-30">
						<div class="recharge-content">
							<div class="recharge-unionPay set-up">
								<ul>
									<a href="#" class="current"><i class="icon iconfont def">&#xe60b;</i><br>手机修改密码<label></label></a>
									<a href="#" class="ml-50"><i class="icon iconfont def">&#xe62f;</i><br>邮箱修改密码<label></label></a>
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
											<p class="word">已绑定手机:</p>
											<p>138****1234</p>
										</li>
										<li>
											<p class="word">动态码:</p>
											<p>
												<input type="text" class="int-text int-in radius">
											</p>
											<p>
												<input type="button"
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
											<p class="word">密码:</p>
											<p>
												<input type="text" class="int-text int-xlarge radius">
											</p>
										</li>
										<li>
											<p class="word">确认密码:</p>
											<p>
												<input type="text" class="int-text int-xlarge radius">
											</p>
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
											<p>154560204@qq.com</p>
										</li>
										<li>
											<p class="word">动态码:</p>
											<p>
												<input type="text" class="int-text int-in radius">
											</p>
											<p>
												<input type="button"
													class="btn border-green border-sma radius btn-medium"
													value="获取动态码">
											</p>
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
											<p class="word">密码:</p>
											<p>
												<input type="text" class="int-text int-xlarge radius">
											</p>
										</li>
										<li>
											<p class="word">确认密码:</p>
											<p>
												<input type="text" class="int-text int-xlarge radius">
											</p>
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
	<script type="text/javascript"
		src="../scripts/modular/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="../scripts/modular/frame.js"></script>
	<script type="text/javascript" src="../scripts/modular/eject.js"></script>

</body>
<%@ include file="/inc/incJs.jsp"%>
</html>
