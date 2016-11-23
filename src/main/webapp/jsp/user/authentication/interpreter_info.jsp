<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
	<%@ include file="/inc/userTopMenu.jsp" %>
	 <!--二级主体-->
  <!--外侧背景-->
  <div class="cloud-container">
  <!--内侧内容区域-->
  <div class="cloud-wrapper">
  	<!--左侧菜单-->
  	<div class="left-subnav">
  	 <%@ include file="/inc/leftmenu.jsp" %>
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
  						<p class="word">
  							<spring:message code="interpreter.portrait" />
  						</p>
  						<p class="portrait">
  							<img src="${portraitId}" id="portraitFileId" />
  							<div class="portrait-file">
  								<a href="#"><spring:message code="interpreter.updatePortrait" /></a>
  								<input type="file"  class="file-opacity" id="uploadImg" name="uploadImg" onchange="uploadImg11('uploadImg')"/>
  							</div>
  						</p>
  						<label id="uploadImgErrMsg" style="display: none;"><span class="ash" id="uploadImgText"></span></label>
  					</li>
  					<li>
  						<p class="word"><b>*</b>
							<spring:message code="interpreter.userName" />
						</p>
  						<p><input type="text" class="int-text int-xlarge radius" id="userName"  name="userName" placeholder="请输入用户名"/></p>
  					</li>
  					<li>
  						<p class="word">
  							<spring:message code="interpreter.fullName" />
  						</p>
  						<p><input type="text" class="int-text int-xlarge radius" name="fullName" id="fullName" /></p>
  					</li>
  					<li>
  						<p class="word"><b>*</b>
  							<spring:message code="interpreter.nickName" />
  						</p>
  						<p><input type="text" class="int-text int-xlarge radius" name="nickname" id="nickname" value="${interpreterInfo.nickname}"/>
  						</p>
  						<label id="nickNameErrMsg" style="display: none;"><span  id="nickNameText"></span></label>
  					</li>
  					<li>
  						<p class="word">
  							<spring:message code="interpreter.sex" />
  						</p>
  						<c:if test="${interpreterInfo.sex==0}">
	  						<p>
	  							<span><input type="radio" name="sex" class="radio" checked="checked" value="0"/></span>
	  							<span><spring:message code="interpreter.sex.man" /></span>
	  						</p>
	  						<p>
	  							<span><input type="radio" name="sex" class="radio" value="1"/></span>
	  							<span><span><spring:message code="interpreter.sex.women" /></span></span>
	  						</p>
  						</c:if>
  						<c:if test="${interpreterInfo.sex==1}">
	  						<p>
	  							<span><input type="radio" name="sex" class="radio"  value="0"/></span>
	  							<span><spring:message code="interpreter.sex.man" /></span>
	  						</p>
	  						<p>
	  							<span><input type="radio" name="sex" class="radio" checked="checked" value="1"/></span>
	  							<span><spring:message code="interpreter.sex.women" /></span>
	  						</p>
  						</c:if>
  					</li>
  					<li>
  						<p class="word"><spring:message code="interpreter.birthday" /></p>
  						<p>																					
  							<input type="text" class="int-text int-xlarge radius" readonly="readonly" name="birthday" value="${birthday}" id="startTime"/>
							<span class="time"> <i class="fa  fa-calendar" ></i></span>
  						</p>
  					</li>
  					<li>
  						<p class="word"><spring:message code="interpreter.email" /></p>
  						<p  class="rightword">ceshi@gtcom.com.cn</p>
  						<p><a href="#"><spring:message code="interpreter.update" /></a></p>
  					</li>
  					<li>
  						<p class="word"><spring:message code="interpreter.mobilePhone" /></p>
  						<p  class="rightword">需到安全中心进行绑111定</p>
  						<p><a href="#"><spring:message code="interpreter.setting" /></a></p>
  					</li>
  					<li>
  						<p class="word">QQ:</p>
  						<p><input type="text" class="int-text int-xlarge radius" name="qq" id="qq"/></p>
  					</li>
  					<li>
  						<p class="word"><spring:message code="interpreter.address" /></p>
  						<p><select class="select select-in-small"></select></p>
  						<p><select class="select select-in-small"></select></p>
  						<p><spring:message code="interpreter.address" /></p>
  						<p><select class="select select-in-small"></select></p>
  						<p><spring:message code="interpreter.cnCity" /></p>
  						<p><input type="text" class="int-text int-in-bi radius" id="address" name="address"/></p>
  					</li>
  				</ul>
  			</div>
  			<div class="recharge-btn order-btn">
 				<input type="button" class="btn btn-green btn-xxxlarge radius10" id="saveButton"  value="保 存">
 				<input type="hidden" id="uploadImgFlag" value="0"/>
 				<input type="hidden" id="nickNameFlag" value="0"/>
 				<input type="hidden" id="portraitId" name="portraitId"/>
 			</div>
 			</form>
  		</div>	
  	</div>
  </div>
  </div>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
    var current ="";
	var pager;
	(function() {
		<%-- 展示日历 --%>
		$('#dataForm').delegate('.fa-calendar','click',function(){
			var calInput = $(this).parent().prev();
			var timeId = calInput.attr('id');
			console.log("click calendar "+timeId);
			WdatePicker({el:timeId,readOnly:true});
		});
		seajs.use('app/jsp/user/interpreter/interpreterInfo',function(InterPreterInfoPager) {
					pager = new InterPreterInfoPager({
						element : document.body
					});
					pager.render();
				});
	})();
</script>
</body>


</html>