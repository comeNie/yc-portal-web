<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.Locale"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<div class="header-big">
  	<div class="cloud-header">
  		<div class="logo">
			<a href="${pageContext.request.contextPath}">
			<img src="${pageContext.request.contextPath}/resources/template/images/logo<%= !Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())?"_en":""%>.png" />
			</a>
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
  				<li>
					<select class="select select-topmini none-select">
						<option value="<%= Locale.SIMPLIFIED_CHINESE%>">简体中文</option>
						<option value="<%= Locale.US%>"
								<%= !Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())?"selected":""%>
						>ENGLISH</option>
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
