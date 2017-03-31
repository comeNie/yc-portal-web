<%@ page import="com.ai.paas.ipaas.i18n.ZoneContextHolder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <%@ include file="/inc/inc.jsp" %>
    <!-- 优惠券 -->
    <title><spring:message code="ycleftmenu.discount"/></title>
</head>
<body>
	<!--头部-->
	<%@ include file="/inc/userTopMenu.jsp" %>
	<!--二级主体-->
  	<!--外侧背景-->
  <div class="cloud-container">
  <!--内侧内容区域-->
  <div class="cloud-wrapper">
  	<!--左侧菜单-->
  	<%@include file="/inc/leftmenu.jsp" %>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	<div class="right-wrapper">	
  		<!--右侧第二块-->
  		<div class="right-list mt-0">
  			<div class="oder-table">
  				<ul>
  					<!-- 未使用 -->
  					<li><a href="javaScript:void(0);" name="displayFlagA" class="current"  value="">未使用(${UnPaidCount})</a></li>
  					<!-- 已使用 -->
  					<li><a href="javaScript:void(0);" name="displayFlagA" value="">已使用(${UnPaidCount})</a></li>
  					<!-- 已过期 -->
  					<li><a href="javaScript:void(0);" name="displayFlagA" value="">已过期(${TranslateCount})</a></li>
  				</ul>
  			</div>
  			<div id="table-da1">
			<!-- 优惠券列表 -->
  			<div class="coupon" id="coupon" id="searchOrderData"></div>
  			<!-- 优惠券列表结束 -->
  			<div id="showMessageDiv"></div>
			<!-- 分页开始 -->
			<div class="biu-paging paging-large">
			 	<ul id="pagination-ul"></ul>
			</div>
			<!-- 分页结束 -->
  			</div>
  		</div>	
  	</div>
  </div>	
  </div>
  <!-- 底部 -->
<%@include file="/inc/userFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>

<script type="text/javascript">
var pager, orderPager;
(function () {
	seajs.use('app/jsp/coupon/couponList', function(oderListPage, orderPage) {
		pager = new oderListPage({element : document.body});
		orderPager = new orderPage({element : document.body})
		pager.render();
	});
</script>





</html>
