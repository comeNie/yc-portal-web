<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.Locale"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	<div class="header-big">
  	<div class="cloud-header">
  		<div class="logo">
			<a href="${pageContext.request.contextPath}/">
			<img src="${pageContext.request.contextPath}/resources/template/images/logo${lTag}.png" />
			</a>
		</div>
  		<!--导航-->
  		<div class="cloud-nav">
  			<ul>
  				<li class="current"><a href="${_base}/p/security/index"><spring:message code="user.topMenu.iClient"/></a></li>
  				<li><a href="${_base}/p/security/interpreterIndex"><spring:message code="user.topMenu.iLsp"/></a></li>
  			</ul>
  		</div>
  		<!--导航-->
  		<div class="cloud-breadcrumb">
  			<ul>
  				<li>
					<select id="langHeadSel" class="select select-topmini select-bj none-select" onchange="changeLang(this);">
						<option value="<%= Locale.SIMPLIFIED_CHINESE%>">简体中文</option>
						<option value="<%= Locale.US%>"
								<%= !Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())?"selected":""%>
						>ENGLISH</option>
					</select>
  					<i class="icon-caret-down dingw"></i>
  				</li>
  				<li class="nav-icon"><a href="#"><i class="icon iconfont">&#xe60b;</i></a></li>
  				<li class="nav-icon mt-2"><a href="#"><i class="icon iconfont">&#xe60a;</i><span class="message">3</span></a></li>
				<li class="user"><a href="javaScript:void(0)" class="yonh">
				<span id="top_username">
				  <c:choose>
						<c:when test="${fn:length(user_session_key.username)>8}">
							${fn:substring(user_session_key.username,0,8)}...
						</c:when>
						<c:otherwise>
							${user_session_key.username}
						</c:otherwise>
					</c:choose>
				</span><i class="icon-caret-down btg" id="icon2"></i></a>
  				</li>
  			</ul>
            <div class="show">
                <ul>
                    <li><i class="icon-user"></i><a href="${_base}/p/interpreter/interpreterInfoPager?source=user"><spring:message code="user.topMenu.perProfile"/></a></li>
                    <li><i class="icon-lock"></i><a href="${_base}/p/security/seccenter?source=user"><spring:message code="user.topMenu.secSetting"/></a></li>
                    <li><i class="icon-off"></i><a href="${_base}/ssologout"><spring:message code="user.topMenu.exit"/></a></li>
                </ul>
            </div>
  		</div>
  	</div>
  </div>