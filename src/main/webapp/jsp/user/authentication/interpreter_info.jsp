<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="_base" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>个人信息-译员认证前</title>
   <%@ include file="/inc/inc.jsp" %>
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
  		<jsp:include page="/inc/leftmenu.jsp"/>
  	</div>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	<div class="right-wrapper">
  		<!--右侧第一块-->
	
  		<!--右侧第二块-->
  		
  		<div class="right-list mt-0">
  			<div class="right-list-title pb-10 pl-20">
  				<p>基本信息</p>
  				<p class="right"><input type="button" class="btn  btn-od-large btn-blue radius20" value="译云认证"></p>
  			</div>
  			<form id="dataForm" method="post" >
  			<div class="form-lable">
  				<ul>
  					<li class="toux">
  						<p class="word">头像:</p>
  						<p class="portrait"><img src="images/icon1.jpg">
  							<div class="portrait-file">
  								<a href="#">修改头像</a>
  								<input type="file"  class="file-opacity"/>
  							</div>
  						</p>
  						
  					</li>
  					<li>
  						<p class="word"><b>*</b>用户名:</p>
  						<p><input type="text" class="int-text int-xlarge radius" name="userName" placeholder="请输入用户名"/></p>
  						<label>仅允许修改一次</label>
  					</li>
  					<li>
  						<p class="word">姓名:</p>
  						<p><input type="text" class="int-text int-xlarge radius"/></p>
  					</li>
  					<li>
  						<p class="word"><b>*</b>昵称:</p>
  						<p><input type="text" class="int-text int-xlarge radius"/></p>
  					</li>
  					<li>
  						<p class="word">性别:</p>
  						<p>
  							<span><input type="radio" class="radio"/></span>
  							<span>男</span>
  						</p>
  						<p>
  							<span><input type="radio" class="radio"/></span>
  							<span>女</span>
  						</p>
  					</li>
  					<li>
  						<p class="word">生日:</p>
  						<p><input type="text" class="int-text int-xlarge radius"/><i class="icon-calendar"></i></p>
  					</li>
  					<li>
  						<p class="word">邮箱:</p>
  						<p  class="rightword">ceshi@gtcom.com.cn</p>
  						<p><a href="#">修改</a></p>
  					</li>
  					<li>
  						<p class="word">手机:</p>
  						<p  class="rightword">需到安全中心进行绑111定</p>
  						<p><a href="#">设置</a></p>
  					</li>
  					<li>
  						<p class="word">QQ:</p>
  						<p><input type="text" class="int-text int-xlarge radius"/></p>
  					</li>
  					<li>
  						<p class="word">地址:</p>
  						<p><select class="select select-in-small"></select></p>
  						<p><select class="select select-in-small"></select></p>
  						<p>省</p>
  						<p><select class="select select-in-small"></select></p>
  						<p>市</p>
  						<p><input type="text" class="int-text int-in-bi radius"/></p>
  					</li>
  				</ul>
  			</div>
  			<div class="recharge-btn order-btn">
 				<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="保 存">
 			</div>
 			</form>
  		</div>	
  	</div>
  </div>
  </div>
<script type="text/javascript">
		var pager;
		(function() {
			seajs.use('app/user/interpreter/interpreterInfo',function(InterPreterInfoPager) {
						pager = new InterPreterInfoPager({
							element : document.body
						});
						pager.render();
					});
		})();
	</script>
</body>
</html>