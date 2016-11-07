<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>安全设置无</title>
 	<%@ include file="/inc/inc.jsp"%>
</head>
<body>
	<!--头部-->
	<div class="header-big">
  	<div class="cloud-header">
  		<div class="logo"><a href="#"><img src="${uedroot}/images/logo.png" /></a></div>
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
  				<li>
  					<select class="select select-topmini none-select">
  					<option>简体中文</option>
  					<option>ENGLISH</option>
  					</select>
  					<i class="icon-caret-down"></i>
  				</li>
  				<li class="nav-icon"><a href="#"><i class="icon iconfont">&#xe60b;</i></a></li>
  				<li class="nav-icon mt-2"><a href="#"><i class="icon iconfont">&#xe60a;</i><span class="message">3</span></a></li>
  				<li class="user"><a href="#" class="yonh">爱大脸大脸<i class="icon-caret-down"></i></a>
  					<div class="show">
  						<ul>
  							<li><i class="icon-user"></i><a href="#">个人信息</a></li>
  							<li><i class="icon-lock"></i><a href="#">安全设置</a></li>
  							<li><i class="icon-off"></i><a href="#">退出</a></li>
  						</ul>
  					</div>
  				</li>
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
  			<div class="security-title">
  				<div class="security-chart"><img src="${uedroot}/images/anq.jpg" /></div>
  				<div class="security-word">
  					<ul>
  						<li>您的账号安全级别</li>
  						<li class="red">高危账号</li>
  						<li class="ash">请保持手机、邮箱正常使用，如果停用，请及时修改</li>
  					</ul>
  				</div>
  			</div>
  			<div class="security-list">
  				<ul>
  					<li class="red"><i class="icon-remove-sign"></i></li>
  					<li class="word">登录密码</li>
  					<li>请设置密码，用于系统登录等操作</li>
  					<li class="right"><a href="#">设置</a></li>
  				</ul>
  				<ul>
  					<li class="red"><i class="icon-remove-sign"></i></li>
  					<li class="word">绑定邮箱</li>
  					<li>您还没有绑定邮箱，请绑定</li>
  					<li class="right"><a href="#">设置</a></li>
  				</ul>
  				<ul>
  					<li class="red"><i class="icon-remove-sign"></i></li>
  					<li class="word">登录密码</li>
  					<li>您还没有绑定手机，请绑定</li>
  					<li class="right"><a href="#">设置</a></li>
  				</ul>
  				<ul>
  					<li class="red"><i class="icon-remove-sign"></i></li>
  					<li class="word">支付密码</li>
  					<li>用于管理账户余额</li>
  					<li class="right"><a href="#">设置</a></li>
  				</ul>
  			</div>
 			
  		</div>	
  	</div>
  	
  	
  </div>
  		
  </div>
</body>
</html>