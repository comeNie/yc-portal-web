<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title></title>
<%@ include file="/inc/inc.jsp"%>
</head>
<body>
	<!--头部-->
	<jsp:include page="/inc/userTopMenu.jsp"/>
	<!--二级主体-->
	<!--外侧背景-->
	<div class="cloud-container">
		<!--内侧内容区域-->
		<div class="cloud-wrapper">
			<!--左侧菜单-->
			<div class="left-subnav">
				<jsp:include page="/inc/leftmenu.jsp">
  	            <jsp:param name="current" value="seccenterSettings" />
  	            </jsp:include>
			</div>
			<!--右侧内容-->
			<!--右侧大块-->
			<div class="right-wrapper">
  		<div class="right-wrapper">
  		<!--右侧第一块-->
	
  		<!--右侧第二块-->
  		<div class="right-list mt-0">
  			<div class="right-list-title pb-10 pl-20">
  				<p>绑定手机</p>	
  			</div>
  			<!--充值-->
 			<div class="recharge mt-30">
 				<div class="recharge-content binding">
 					<div class="recharge-form-label mt-20">
 						<ul>
 							<li>
 							   <p class="word">手机号:</p>
 								<p><select id="country" class="select select-in"></select></p>
 								<p><input id="telephone" type="text" class="int-text int-large radius"></p>
 								<label id="telephoneErrMsg"></label>
 								
 							</li>
 							<li>
 								<p class="word">动态码:</p>
 								<p><input id="dynamicode" type="text" class="int-text int-in radius"></p>
 								<p><input type="button" id="send_dynamicode_btn" class="btn border-green border-sma radius btn-medium" value="获取动态码"></p>
 							   <label id="dynamicodeErrMsg"></label>
 							</li>
 						</ul>
 					</div>
 					
 				</div>
 				<!--按钮-->
 				<div class="recharge-btn">
 						<input type="button" id="submitPhoneBtn" class="btn btn-green btn-xxxlarge radius10" value="提 交">
 					</div>
 			</div>
 			</div>
  		</div>	
	  </div>
	</div>

	</div>
</body>
<%@ include file="/inc/incJs.jsp"%>
<script type="text/javascript">
	var pager;
	(function() {
		seajs.use('app/jsp/user/security/bindPhone', function(updatePhonePager) {
			pager = new updatePhonePager({
				element : document.body
			});
			pager.render();
		});
	})();
</script>
</html>
