<%@page import="com.ai.yc.protal.web.utils.UserUtil"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%
UserUtil.getUserPortraitImg();
%>
<script src="${_base}/resources/spm_modules/jquery/1.9.1/jquery.min.js"></script>
   <!--二级主体-->
  <!--外侧背景--> 
  	<!--左侧菜单-->
  	<div class="left-subnav">
  		<div class="left-title">
  			<ul>
  				<li class="user"><img id="ycUserPortraitImg" src="${userPortraitImg}" /></li>
  				<li class="word">
  					<p id="left_username">
						<c:choose>
						<c:when test="${fn:length(user_session_key.username)>=5}">
							${fn:substring(user_session_key.username,0,5)}...
						</c:when>
						<c:otherwise>
							${user_session_key.username}
						</c:otherwise>
						</c:choose>
					</p>
  					<p class="vip1"></p>
  				</li>
  			</ul>
  		</div>
  		<div class="left-list" id="left_menu_list">
  			<ul>
  				<!-- 我的首页 -->
  				<li id="index" class="current">
  					<a href="${_base}/p/security/index" style="display: block;width: 100%;height: 100%">
  					  <span><i class="icon iconfont">&#xe645;</i></span>
  					  <span><spring:message code="ycleftmenu.mymainpage"/></span>
  					</a>
  				</li>
  				<!-- 我的订单 -->
  				<li id="orderList">
  					<a href="${_base}/p/customer/order/list/view" style="display: block;width: 100%;height: 100%">
  					<span><i class="icon iconfont">&#xe64a;</i></span>
  					<span><spring:message code="ycleftmenu.myorder"/></span>
  					</a>
  				</li>
  				<!-- 我的账户 -->
				<li id="myaccount">
					<a href="${_base}/p/balance/account" style="display: block;width: 100%;height: 100%">
						<span><i class="icon iconfont">&#xe648;</i></span>
						<span><spring:message code="ycleftmenu.myaccount"/></span>
					</a>
				</li>
  				<%--<li>--%>
  					<%--<a href="优惠卷.html">--%>
  					<%--<span><i class="icon iconfont">&#xe644;</i></span>--%>
  					<%--<span><spring:message code="ycleftmenu.discount"/></span>--%>
  					<%--</a>--%>
  				<%--</li>--%>
  				<!-- <li>
  					<a href="我的级别.html">
  					<span><i class="icon iconfont">&#xe647;</i></span>
  					<span><spring:message code="ycleftmenu.mylevel"/></span>
  					</a>
  				</li> -->
  				<%--<li>--%>
  					<%--<a href="我的积分.html">--%>
  					<%--<span><i class="icon iconfont">&#xe605;</i></span>--%>
  					<%--<span><spring:message code="ycleftmenu.mycredit"/></span>--%>
  					<%--</a>--%>
  				<%--</li>--%>
  				<%--<li>--%>
  					<%--<a href="发票管理.html">--%>
  					<%--<span><i class="icon iconfont">&#xe643;</i></span>--%>
  					<%--<span><spring:message code="ycleftmenu.myfapiao"/></span>--%>
  					<%--</a>--%>
  				<%--</li>--%>
  				<!-- <li>
  					<a href="企业中心.html">
  					<span><i class="icon iconfont">&#xe6f8;</i></span>
  					<span><spring:message code="ycleftmenu.companycenter"/></span>
  					</a>
  				</li> -->
  				<!-- 个人信息 -->
  				<%-- <li id="interpreterInfo">
  					<a href="${_base}/p/interpreter/interpreterInfoPager?source=user">
  					<span><i class="icon iconfont">&#xe642;</i></span>
  					<span><spring:message code="ycleftmenu.myinfo"/></span>
  					</a>
  				</li> --%>
  				<!-- 安全设置 -->
  				<li id="seccenterSettings">
  					<a  href="${_base}/p/security/seccenter?source=user" style="display: block;width: 100%;height: 100%">
  					<span><i class="icon iconfont">&#xe63f;</i></span>
  					<span><spring:message code="ycleftmenu.mysecurity"/></span>
  					</a>
  				</li>
  			</ul>
  		</div>
		<!--定位-->
		<div class="locationaaa">
			<div class="left-phone">
				<p><i class="icon iconfont">&#xe60d;</i></p>
				<p class="phone-word">
					<span><spring:message code="ycleftmenu.time"/></span>
					<span class="red">400-119-8080</span>
				</p>
			</div>
			<div class="left-tplist"><a hrel="#"><img src="${uedroot}/images/to${lTag}.png" /></a><i class="icon-remove-circle"></i></div>
		</div>
  	</div>
  	<script type="text/javascript">
  	  $(function(){
  		var currentEle = $("#"+current);
    	  if(current!=""&&currentEle){
    		$("#left_menu_list ul li").removeClass("current");
    		currentEle.addClass("current");
    	  } 
  	  });
  	</script>