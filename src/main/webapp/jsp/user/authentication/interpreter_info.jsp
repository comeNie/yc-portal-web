<%@page import="com.ai.yc.protal.web.constants.Constants"%>
<%@page import="com.ai.opt.sdk.components.ccs.CCSClientFactory"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<%@ include file="/inc/inc.jsp" %>
	<title><spring:message code="ycleftmenu.myinfo"/></title>
	<link rel="stylesheet" type="text/css" href="${_base}/resources/spm_modules/webuploader/webuploader.css">

	<style>
		.portrait-file  .webuploader-pick, .portrait-file  .webuploader-pick-hover {background-color: transparent;}
	</style>
</head>
<%
//默认设置成1为开启，0为关闭
String accountEnable="1";
try{
	accountEnable=CCSClientFactory.getDefaultConfigClient().get(Constants.Account.CCS_PATH_ACCOUNT_ENABLE);
}
catch(Exception e){
	//获取配置出错，直接忽略，视为开启
}
%>
<body>
	<!--头部-->
	<c:if test="${source=='user'}">
      <%@ include file="/inc/userTopMenu.jsp"%>
  </c:if>
  <c:if test="${source=='interpreter'}">
      <%@ include file="/inc/transTopMenu.jsp"%>
  </c:if>
	 <!--二级主体-->
  <!--外侧背景-->
  <div class="cloud-container">
  <!--内侧内容区域-->
  <div class="cloud-wrapper">
  	<!--左侧菜单-->
  	<div class="left-subnav">
  	 <c:if test="${source=='user'}">
  	<%@ include file="/inc/leftmenu.jsp"%>
  	</c:if>
     <c:if test="${source=='interpreter'}">
    <%@ include file="/inc/transLeftmenu.jsp"%>
  </c:if>
  	</div>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	<div class="right-wrapper">
  		<!--右侧第一块-->
	
  		<!--右侧第二块-->
  		
  		<div class="right-list mt-0">
  			<div class="right-list-title pb-10 pl-20">
  				<p><spring:message code="interpreter.baseInfo" /></p>
  				<!-- <p class="right"><input type="button" class="btn  btn-od-large btn-blue radius20" value="译云认证"></p> -->
  			</div>
  			<form id="dataForm" method="post" >
  			<div class="form-lable">
  				<ul>
  					<li class="toux">
  						<p class="word">
  							<spring:message code="interpreter.portrait" />:
  						</p>
  						<p class="portrait">
  							<img src="${userPortraitImg}" id="portraitFileId" />
  							<div class="portrait-file" style="display:block;">
  								<a href="javascript:void(0);"><spring:message code="interpreter.updatePortrait" /></a>
								<div id="uploadImg"></div>
  								<%--<input type="file"  class="file-opacity" id="uploadImg" name="uploadImg" onchange="uploadPortraitImg('uploadImg')"/>--%>
  							</div>

  						</p>
  						<label id="uploadImgErrMsg" style="display: none;"><span class="ash" id="uploadImgText"></span></label>
  					</li>
  					<li>
  						<p class="word"><b>*</b>
							<spring:message code="interpreter.userName" />
						</p>
  						<p id="p_userName">
  						<c:if test="${interpreterInfo.isChange=='1'}">
  						 ${user_session_key.username}
  						</c:if>
  						<c:if test="${interpreterInfo.isChange!='1'}">
  						<input  maxlength="16" type="text" class="int-text int-xlarge radius" id="userName"  name="userName" value="${user_session_key.username}"/>
  						 <label id="userNameErrMsg"><spring:message code="interpreter.userName.allows.modify.once"/></label>
  						 <label id="userName-error" class="error" for="userName"></label>
  						</c:if>
  						</p>
  					</li>
  					<li>
  						<p class="word">
  							<spring:message code="interpreter.firstName" />
  						</p>
  						<p><input maxlength="50" type="text" class="int-text int-xlarge radius" name="firstname" id="firstname" value="${interpreterInfo.firstname}" /></p>
  					</li>
  					<li>
  						<p class="word">
  							<spring:message code="interpreter.lastName" />
  						</p>
  						<p><input maxlength="50" type="text" class="int-text int-xlarge radius" name="lastname" id="lastname" value="${interpreterInfo.lastname}" /></p>
  					</li>
  					<li>
  						<p class="word"><b>*</b>
  							<spring:message code="interpreter.nickName" />
  						</p>
  						<p><input  type="text" class="int-text int-xlarge radius" name="nickname" id="nickname" value="${interpreterInfo.nickname}"/>
  						<label id="nickname-error" class="error" for="nickname"></label>
  						</p>
  					</li>
  					<li>
  						<p class="word">
  							<spring:message code="interpreter.sex" />
  						</p>
  						   <p>
	  							<span><input type="radio" name="sex" class="radio" <c:if test="${interpreterInfo.sex==0 || interpreterInfo.sex==null}">checked="checked"</c:if> value="0"/></span>
	  							<span><spring:message code="interpreter.sex.man" /></span>
	  						</p>
	  						<p>
	  							<span><input type="radio" name="sex" class="radio" <c:if test="${interpreterInfo.sex==1}">checked="checked"</c:if> value="1"/></span>
	  							<span><span><spring:message code="interpreter.sex.women" /></span></span>
	  						</p>
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
  						<p  class="rightword">${user_session_key.email}</p>
  						<p>
  						 <c:if test="${user_session_key.email!=null&&user_session_key.email!=''}">
  						  <a href="${_base}/p/security/seccenter?source=${source}"><spring:message code="interpreter.update" /></a>
  						 </c:if>
  						 <c:if test="${user_session_key.email==null||user_session_key.email==''}">
  						  <a href="${_base}/p/security/seccenter?source=${source}"><spring:message code="interpreter.setting" /></a>
  						 </c:if>
  						</p>
  					</li>
  					<li>
  						<p class="word"><spring:message code="interpreter.mobilePhone" /></p>
  						<p  class="rightword">${user_session_key.fullMobile}</p>
						<p>
  							<c:if test="${user_session_key.fullMobile==null||user_session_key.fullMobile==''}">
  						    	<a href="${_base}/p/security/seccenter?source=${source}"><spring:message code="interpreter.setting" /></a>
  							</c:if>
  							<c:if test="${user_session_key.fullMobile!=null}">
  								<a href="${_base}/p/security/seccenter?source=${source}"><spring:message code="interpreter.update" /></a>
  							</c:if>
  						</p>
  					</li>
  					<li>
  						<p class="word">QQ:</p>
  						<p><input maxlength="10" type="text" class="int-text int-xlarge radius" name="qq" id="qq" value="${interpreterInfo.qq}"/></p>
  					</li>
  					<li>
  						<p class="word"><spring:message code="interpreter.save.area" /></p>
  						<p>
  							<select  class="select select-in-small" id="countryInfo" name="country">
  							</select>
  						</p>
  						<p id="provinceP"><select class="select select-in-small" id="provinceInfo" name="province" >
  						  </select>
  						  <spring:message code="interpreter.province" />
  						</p>
  						<p id="cnCityP"><select class="select select-in-small" id="cnCityInfo" name="cnCity" ></select>
  							<spring:message code="interpreter.cnCity" />
  						</p>
  						<p><label id="area-error"></label></p>
					</li>
					<li>
						<p style="margin-left: 120px"><input type="text" class="int-text int-in-bi radius" id="address" name="address" value="${interpreterInfo.address}" style="width: 420px" maxlength="100"/>
							<label id="detail-address"></label>
						</p>
					</li>
  				</ul>
  			</div>
  			<div class="recharge-btn order-btn">
 				 <% if(Constants.Account.ACCOUNT_ENABLE.equals(accountEnable)){ %>
 				<input type="button" class="btn btn-green btn-xxxlarge radius10" id="saveButton"  value="<spring:message code="interpreter.save" />">
 				<% } %>
 				<input type="hidden" id="uploadImgFlag" value="0"/>
 				<input type="hidden" id="nickNameFlag" value="0"/>
 				<input type="hidden" id="portraitId" name="portraitId" value="${interpreterInfo.portraitId}"/>
 			</div>
 			</form>
  		</div>	
  	</div>
  </div>
  </div>
  	<%@ include file="/inc/userFoot.jsp"%>
  </body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
    var current ="interpreterInfo";
    var originalNickname="${interpreterInfo.nickname}";
    var originalUsername="${user_session_key.username}";
    var countryCode = "${interpreterInfo.country}";
    var provinceCode = "${interpreterInfo.province}";
    var cnCityCode = "${interpreterInfo.cnCity}";
    var interpreterInfoMsg ={
    		"showOkValueMsg" : '<spring:message code="ycaccountcenter.js.showOkValueMsg"/>',
    		"showTitleMsg" : '<spring:message code="ycaccountcenter.js.showTitleMsg"/>',
    		"uplaodImageMsg" : '<spring:message code="interpreter.uplaodImageMsg"/>',
    		"userNameEmptyMsg" : '<spring:message code="interpreter.save.userName.empty.msg"/>',
    		"userNameErrorMsg" : '<spring:message code="interpreter.save.userName.error.msg"/>',
    		"userNameMaxMsg" : '<spring:message code="interpreter.save.userName.maxlength.msg"/>',
    		"userNameMinMsg" : '<spring:message code="interpreter.save.userName.minlength.msg"/>',
    		"nickNameEmptyMsg" : '<spring:message code="interpreter.save.nickName.empty.msg"/>',
    		"nickNameErrorMsg" : '<spring:message code="interpreter.save.nickName.error.msg"/>',
    		"nickNameMaxMsg" : '<spring:message code="interpreter.save.nickName.maxlength.msg"/>',
    		"nickNameMinMsg" : '<spring:message code="interpreter.save.nickName.minlength.msg"/>',
    		"qqErrorMsg" : '<spring:message code="interpreter.save.qq.error.msg"/>',
   			"provinceErrorMsg" : '<spring:message code="interpreter.provice.error.msg"/>',
       		"cityErrorMsg" : '<spring:message code="interpreter.cnCity.error.msg"/>',
       		"detailAddressErrorMsg" : '<spring:message code="interpreter.address.error.msg"/>',
       		"areaTitle" : '<spring:message code="interpreter.area.title"/>'
       		
    	};
	var pager;
	(function() {
		<%-- 展示日历 --%>
		$('#dataForm').delegate('.fa-calendar','click',function(){
			var calInput = $(this).parent().prev();
			var timeId = calInput.attr('id');
			//console.log("click calendar "+timeId); ie8兼容
			WdatePicker({
				el:timeId,
				readOnly:true,
				lang:'${my97Lang}'
				});
		});
		seajs.use('app/jsp/user/interpreter/interpreterInfo',function(InterPreterInfoPager) {
					pager = new InterPreterInfoPager({
						element : document.body
					});
					pager.render();
				});
        //checkbox兼容ie8
//        $('.form-lable input').iCheck({
//            checkboxClass: 'icheckbox_flat-blue',
//            radioClass: 'iradio_flat-blue'
//        });
	})();
</script>

</html>