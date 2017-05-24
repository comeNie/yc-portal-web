<%@page import="com.ai.yc.protal.web.constants.Constants"%>
<%@page import="com.ai.opt.sdk.components.ccs.CCSClientFactory"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<%@ include file="/inc/inc.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>译员认证</title>
</head>
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
  				<p>基本信息</p>
  				<p class="right"><input type="button" class="btn  btn-od-large btn-red radius20" value="译员审核中"></p>
  			</div>
  			<form id="dataForm" method="post" >
  			<div class="form-lable">
  				<ul>
  					<li class="toux">
  						<p class="word">
  							<spring:message code="interpreter.portrait" />:
  						</p>
  						<div class="portrait" >
  							<img src="${userPortraitImg}" id="portraitFileId" />
  							<div id="portraitbox" class="portrait-file" style="display:block;">
  								<a href="javascript:void(0)" style="cursor: pointer;"><spring:message code="interpreter.updatePortrait" /></a>
								 <div id="uploadImg" class="file-opacity"></div>
  							</div>
  						</div>
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
  							<span><spring:message code="interpreter.sex.women" /></span>
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
  							<c:if test="${user_session_key.fullMobile!=null&&user_session_key.fullMobile!=''}">
  								<a href="${_base}/p/security/seccenter?source=${source}"><spring:message code="interpreter.update" /></a>
  							</c:if>
  						</p>
  					</li>
  					<li>
  						<p class="word">身份证:</p>
  						<p>
  							<input type="text" class="int-text int-xlarge radius" id="legalCertNum" name="legalCertNum" value="${translatorResponse. legalCertNum}"/>
  						</p>
  						<label id="legalCertNumError" style="display: none;"><span class="ash" id="legalCertNumText"></span></label>
  					</li>
  					<li>
  						<p class="word"><b>*</b>母语:</p>
  						<p><select class="select select-xlarge" id="motherTongue" name="motherTongue"></select></p>
  					</li>
  					<li>
  						<p class="word"><b>*</b>翻译年限:</p>
  						<p><input type="text" class="int-text int-xlarge radius" id="translationYears" name="workingLife" value="${translatorResponse.workingLife }"/></p>
  						<label id="translationYearsError" style="display: none;"><span class="ash" id="translationYearsText"></span></label>
  					</li>
  					<!-- <li>
  						<p class="word"><b>*</b>认证语言:</p>
  						<p>
  							<div class="language">
  								<input id="tmpIntput" type="hidden" value="-1"/>
  								<div id="languagesDiv">
	  								
  								</div>
  								<p><a href="javascript:void(0)" id="addLanguage"><i class="icon-plus-sign"></i>添加语言</a></p>
  							</div>
  						</p>
  					</li> -->
  					<li id="goodField">
  						<p class="word"><b>*</b>擅长领域:</p>
  						<label id="goodFieldError" style="display: none;"><span class="ash" id="goodFieldErrorText"></span></label>
  					</li>
  					<li id="goodUser">
  						<p class="word"><b>*</b>擅长用途:</p>
  						<label id="goodUsersError" style="display: none;"><span class="ash" id="goodUsersErrorText"></span></label>
  					</li>
  					<li>
  						<p class="word">座机:</p>
  						<p><input type="text" class="int-text int-xlarge radius" id="fixPhone" name="fixPhone"/></p>
  						<label id="fixPhoneError" style="display: none;"><span class="ash" id="fixPhoneText"></span></label>
  					</li>
  					<li>
  						<p class="word">QQ:</p>
  						<p><input type="text" class="int-text int-xlarge radius" name="qq" id="qq"/></p>
  						<label id="qqError" style="display: none;"><span class="ash" id="qqText"></span></label>
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
 				<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="下一步">
 			</div>
 			<input type="hidden" id="goodUserValue" name="areaOfUse"/>
 			<input type="hidden" id="goodFieldsValue" name="areaOfExperise"/>
 			</form>
  		</div>	
  	</div>
  </div>
  </div>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
var current ="interpreterInfo";
var originalNickname="${interpreterInfo.nickname}";
var originalUsername="${user_session_key.username}";
var countryCode = "${interpreterInfo.country}";
var provinceCode = "${interpreterInfo.province}";
var cnCityCode = "${interpreterInfo.cnCity}";
var fieldList = '${fieldList}';
var userList = '${userList}';
var languagePairText = "";
var motherTongue = '${translatorResponse.motherTongue}';
var translatorId = '${translatorResponse.translatorId}';
var translatorInfoMsg ={
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
		seajs.use('app/jsp/translator/translatorInfo',function(TranslatorInfoPager) {
					pager = new TranslatorInfoPager({
						element : document.body
					});
					pager.render();
				});
	})(); 
</script>
</html>
