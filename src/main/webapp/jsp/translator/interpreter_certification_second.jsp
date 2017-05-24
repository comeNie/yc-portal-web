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
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" type="text/css" href="${_base}/resources/spm_modules/webuploader/webuploader.css">
<title><spring:message code="yctranslator.second.title" /></title>
</head>
<body>
<!--弹出--> 
<div class="eject-big">
    <div class="prompt-samll" id="modify-password">
    <div class="prompt-samll-title"><spring:message code="yctranslator.second.delete.tip"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
          <spring:message code="yctranslator.second.delete.first.line"/>
      </li>
       <li>
           <spring:message code="yctranslator.second.delete.second.line"/>
      </li>
      <li class="eject-btn">
        <input type="button" id="modify-determine" class="btn btn-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.Ok"/>">
        <input type="button" id="modify-close" class="btn border-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.cancle"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="eject-mask"></div>
</div>
<!--/弹出结束-->
<!--弹出--> 
<div class="eject-big">
    <div class="prompt-samll" id="setting-dialog">
    <div class="prompt-samll-title"><spring:message code="yctranslator.second.delete"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
       <spring:message code="yctranslator.second.delete.cer"/>
      </li>
      <li class="eject-btn">
        <input type="button" id="setting-save-confirm" class="btn btn-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.Ok"/>">
        <input type="button" id="setting-save-cancel" class="btn border-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.cancle"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="setting-mask"></div>
</div>
<!--/弹出结束--> 
<!--弹出--> 
<div class="eject-big">
    <div class="prompt-samll" id="setting-dialog1">
    <div class="prompt-samll-title"><spring:message code="yctranslator.second.delete"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
        <spring:message code="yctranslator.second.delete.work"/>
      </li>
      <li class="eject-btn">
        <input type="button" id="setting-save-confirm1" class="btn btn-green btn-120 radius20" value="确 定">
        <input type="button" id="setting-save-cancel1" class="btn border-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.cancle"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="setting-mask1"></div>
</div>
<!--/弹出结束--> 
<!--弹出--> 
<div class="eject-big">
    <div class="prompt-samll" id="confirm-step2-educate">
    <div class="prompt-samll-title"><spring:message code="yctranslator.second.delete"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
        <spring:message code="yctranslator.second.delete.edu"/>
      </li>
      <li class="eject-btn">
        <input type="button" id="confirm-step2-educate-confirm" class="btn btn-green btn-120 radius20" value="确 定">
        <input type="button" id="confirm-step2-educate-cancel" class="btn border-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.cancle"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="confirm-step2-educate-mask"></div>
</div>
<!--/弹出结束--> 
<!--弹出--> 
<div class="eject-big">
    <div class="prompt-samll" id="confirm-step2-language">
    <div class="prompt-samll-title"><spring:message code="yctranslator.second.delete"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
      	<spring:message code="yctranslator.second.language.first.line"/>
      </li>
      <li>
        <spring:message code="yctranslator.second.language.second.line"/>
      </li>
      <li class="eject-btn">
        <input type="button" id="confirm-step2-language-confirm" class="btn btn-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.Ok"/>">
        <input type="button" id="confirm-step2-language-cancel" class="btn border-green btn-120 radius20" value="<spring:message code="yctranslator.second.botton.cancle"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="confirm-step2-language-mask"></div>
</div>
<!--/弹出结束--> 
<!-- 译员不能为空提示弹窗 -->
<div class="eject-big">
    <div class="prompt-samll" id="confirm-step2-empty">
    <div class="prompt-samll-title"> <spring:message code="yctranslator.second.delete.tip"/></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul class="pass-list">
      <li>
      <spring:message code="yctranslator.second.delete.language.tip"/>
     
      </li>
      <li class="eject-btn">
        <input type="button" id="confirm-step2-empty-confirm" class="btn btn-green btn-120 radius20" value=" <spring:message code="yctranslator.second.botton.Ok"/>">
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="confirm-step2-empty-mask"></div>
</div>
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
  		<!--右侧大块-->
    <div class="right-wrapper translater-confirm-step2">
    <div class="translater-step">
        <div class="steps-bar">
            <ul>
              <li class="finished">
                <div class="step">1</div>
                 <p class="txt"><spring:message code="yctranslator.improve.interpreter.information"/></p>
                 <div class="line"></div>
              </li>
              <li class="active">
                <div class="step">2</div>
                 <p class="txt"><spring:message code="yctranslator.improve.resume.information"/></p>
                 <div class="line"></div>
              </li>
              <li class="last">
                <div class="step">3</div>
                 <p class="txt"><spring:message code="yctranslator.improve.language.information"/></p>
                 <div class="line"></div>
              </li>
            </ul>
            <p class="loadingBar"></p>
        </div>
    </div>
  	 <div class="right-list mt-0">
        <div class="confirm-content">
          <ul>
            <li>
              <label class="key"><span class="important">*</span><spring:message code="yctranslator.add.resume.information"/></label>
              <textarea class="int-text textarea radius" id="introduction" ></textarea>
              <label id="introductionTip" style="color: red;"></label>
            </li>
            <li>
                <label class="key"><span class="important">*</span><spring:message code="yctranslator.add.translate.language"/></label>
                <div class="value">
                    <div add-program class='inputContainer'>
                      <c:forEach items="${languageList}" var="languageInfo" varStatus="status">
                        <p class='inputp${languageInfo.languageId}'>
                        	<c:if test="${curLanguage=='zh_CN'}">
                        		<span class="txt1 input12">${languageInfo.languageNameZh }</span>
                        	</c:if>
                        	<c:if test="${curLanguage=='en_US'}">
                        		<span class="txt1 input12">${languageInfo.languageNameEn }</span>
                        	</c:if>
                        	<c:if test="${curLanguage=='zh_CN'}">
		                        <c:if test="${languageInfo.translationType=='1'}">
		                        	<span class="txt2 input13" ><spring:message code="yctranslator.add.translatertype.interpret"/></span>
		                        </c:if>
		                         <c:if test="${languageInfo.translationType=='2'}">
		                        	<span class="txt2 input13" ><spring:message code="yctranslator.add.translatertype.translate"/></span>
		                        </c:if>
		                    </c:if>
                        	<c:if test="${curLanguage=='en_US'}">
		                        <c:if test="${languageInfo.translationType=='1'}">
		                        	<span class="txt2 input13" >interpret</span>
		                        </c:if>
		                         <c:if test="${languageInfo.translationType=='2'}">
		                        	<span class="txt2 input13" >translate</span>
		                        </c:if>
		                    </c:if>
	                        <span class="txt1 input14"><strong>${languageInfo.referencePrice}</strong>元/千字（参考价）</span>
	                         <c:if test="${languageInfo.translationType=='2'}">
	                           <c:if test="${languageInfo.state=='0'}">
	                           		 <span><spring:message code="yctranslator.add.translate.state.didnottest"/></span>
	                           </c:if>
	                           <c:if test="${languageInfo.state=='1'}">
	                           		 <span><spring:message code="yctranslator.add.translate.state.audit"/></span>
	                           </c:if>
	                           <c:if test="${languageInfo.state=='2'}">
	                           		 <span><spring:message code="yctranslator.add.translate.state.egit"/></span>
	                           </c:if>
	                            <c:if test="${languageInfo.state=='3'}">
	                           		 <span><spring:message code="yctranslator.add.translate.state.egit.fail"/></span>
	                           </c:if>
	                        </c:if>
	                       
	                        <input type="button" class="btn biu-btn btn-auto-25 btn-red radius10" name='1' value="<spring:message code="yctranslator.second.delete"/>" confirm-step2-language>
	                        <input type="button" class="btn biu-btn btn-auto-25 btn-green radius10" name='1.1' value="<spring:message code="yctranslator.second.edit"/>" editBtnLang>
                    	</p>
                      </c:forEach>
                      <p class='inputexit'>
                      </p>
                      </div>
                    <span class="add-language"  add-languages><spring:message code="yctranslator.second.botton.addlanguage"/></span>
                </div>
            </li>
            <li>
                <label class="key"><span class="important">*</span><spring:message code="yctranslator.second.label.addeducation"/></label>
                <div class="value">
                    <div add-program class='eduContainer'>
                      <c:forEach items="${educationList}" var="educationInfo">
                     	<p class='inputp1'>
	                        <span class="txt3">${educationInfo.school}</span>
	                        <span class="txt3">${educationInfo.studyStartTime}-${educationInfo.studyEndTime}</span>
	                        <span>${educationInfo.eduBackground}</span>
	                        <input type="button" class="btn biu-btn btn-auto-25 btn-red radius10" name='1' value="<spring:message code="yctranslator.second.delete"/>" confirm-step2-educate>
	                        <input type="button" class="btn biu-btn btn-auto-25 btn-green radius10" name='1.1' value="<spring:message code="yctranslator.second.edit"/>" editBtnEdu>
                      	</p>
                     </c:forEach>
                     <p class='exit2'></p>
                    </div>
                    <span class="add-language" add-educate><spring:message code="yctranslator.second.botton.addeducation"/></span>
                </div>
            </li>
            <li>
                <label class="key"><spring:message code="yctranslator.add.label.work"/></label>
                <div class="value">
                    <div add-program class='workContainer'>
                     <c:forEach items="${workList}" var="userWork">
                     	<p class='inputp1'>
                        <span class="txt3">${userWork.company}</span>
                        <span class="txt3">${userWork.workStartTime}-${userWork.workEndTime}</span>
                        <span><strong>3</strong><spring:message code="yctranslator.add.year"/></span>
                        <input type="button" class="btn biu-btn btn-auto-25 btn-red radius10" name='1' value="<spring:message code="yctranslator.second.delete"/>" setting-save-btn1>
                        <input type="button" class="btn biu-btn btn-auto-25 btn-green radius10" name='1.1' value="<spring:message code="yctranslator.second.edit"/>" editBtnWork>
                      </p>
                     </c:forEach>
                      
                      <p class='exit3'></p>
                    </div>
                    <span class="add-language" add-work><spring:message code="yctranslator.second.botton.addwork"/></span>
                </div>
            </li>
            <li>
                <label class="key"><spring:message code="yctranslator.add.label.certification"/></label>
                <div class="value">
                    <div add-program class='diplomaContainer'>
                    <c:forEach items="${certificationList}" var="certification">
                    	<p class='inputp1'>
                        <span class="txt3">${certification.certificateName }</span>
                        <span class="txt3">${certification.awardedTime}</span>
                        <span>${certification.grantingInstitution }</span>
                        <input type="button" class="btn biu-btn btn-auto-25 btn-red radius10" name='1' value="<spring:message code="yctranslator.second.delete"/>" setting-save-btn>
                        <input type="button" class="btn biu-btn btn-auto-25 btn-green radius10" name='1.1' value="<spring:message code="yctranslator.second.edit"/>" editBtnDiploma>
                      </p>
                    </c:forEach>
                     
                      <p class='exit4'></p>
                    </div>
                    <span class="add-language" add-card><spring:message code="yctranslator.add.botton.certification"/></span>
                </div>
            </li>
          </ul>
        </div>
        <div class="recharge-btn order-btn">
            <input type="button" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="yctranslator.second.next.step"/>" id="ddd">
          </div>
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
var languagePairText = "";

var languageList = '${languageListJson}';
var eduList = '${educationListJson}';
var workList = '${workListJson}';
var cerList = '${certificationListJson}';
var translatorInfoMsg ={
		"languageprivceempty" : '<spring:message code="yctranslator.second.language.price.empty"/>',
		"languageprivcenumber" : '<spring:message code="yctranslator.second.language.price.number"/>',
		"didnottest" : '<spring:message code="yctranslator.add.translate.state.didnottest"/>',
		"interpret" : '<spring:message code="yctranslator.add.translatertype.interpret"/>',
		"translate" : '<spring:message code="yctranslator.add.translate.translate"/>',
		"priceUnit" : '<spring:message code="yctranslator.second.language.price"/>',
		"deleteButton" : '<spring:message code="yctranslator.second.delete"/>',
		"editButton" : '<spring:message code="yctranslator.second.edit"/>',
		"eduspecialty" : '<spring:message code="yctranslator.second.education.specialty"/>',
		"edumaster" : '<spring:message code="yctranslator.second.education.master"/>',
		"eduundergraduate" : '<spring:message code="yctranslator.second.education.undergraduate"/>',
		"majorname" : '<spring:message code="yctranslator.second.education.majorname"/>',
		"address" : '<spring:message code="yctranslator.second.education.address"/>',
		"detailaddress" : '<spring:message code="yctranslator.second.education.detailaddress"/>',
		"time" : '<spring:message code="yctranslator.second.education.time"/>',
		"year" : '<spring:message code="yctranslator.second.education.time.year"/>',
		"month" : '<spring:message code="yctranslator.second.education.time.month"/>',
		"to" : '<spring:message code="yctranslator.second.education.time.to"/>',
		"positionname" : '<spring:message code="yctranslator.second.work.position.name"/>',
		"companyname" : '<spring:message code="yctranslator.second.work.company.name"/>',
		"incumbencytime" : '<spring:message code="yctranslator.second.work.incumbency.time"/>',
		"positiondescription" : '<spring:message code="yctranslator.second.work.position.description"/>',
		"certificateauthority" : '<spring:message code="yctranslator.second.cer.certificate.authority"/>',
		"certificatename" : '<spring:message code="yctranslator.second.cer.certificate.name"/>',
		"issuedate" : '<spring:message code="yctranslator.second.cer.issue.date"/>',
		"certificateoverview" : '<spring:message code="yctranslator.second.cer.certificate.overview"/>',
		"collegenameempty" : '<spring:message code="yctranslator.second.education.college.name.empty "/>',
		"collegenamelength" : '<spring:message code="yctranslator.second.education.college.name.length"/>',
		"majornameempty" : '<spring:message code="yctranslator.second.education.major.name.empty"/>',
		"majornamelength" : '<spring:message code="yctranslator.second.education.major.name.lengthe"/>',
		"detailAddressEmpty" : '<spring:message code="yctranslator.second.education.college.name.empty"/>',
		"detailAddressLength" : '<spring:message code="yctranslator.second.education.college.name.length"/>',
		"companynameempty" : '<spring:message code="yctranslator.second.work.company.name.empty"/>',
		"companynamelength" : '<spring:message code="yctranslator.second.work.company.name.length"/>',
		"positionnameempty" : '<spring:message code="yctranslator.second.work.position.name.empty"/>',
		"positionnamelength" : '<spring:message code="yctranslator.second.work.position.name.length"/>',
		"certificatenameempty" : '<spring:message code="yctranslator.second.cer.certificate.name.empty"/>',
		"certificatenamelength" : '<spring:message code="yctranslator.second.cer.certificate.name.length"/>',
		"certificateauthorityname" : '<spring:message code="yctranslator.second.cer.certificate.authority.name"/>',
		"certificateauthoritylength" : '<spring:message code="yctranslator.second.cer.certificate.authority.length"/>',
		"showOkValueMsg" : '<spring:message code="yctranslator.second.botton.Ok"/>',
		"showTitleMsg" : '<spring:message code="yctranslator.second.botton.cancle"/>',
   		
	};
	 var pager;
	(function() {
		//展示日历
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
		seajs.use('app/jsp/translator/translatorSecondInfo',function(TranslatorInfoPager) {
					pager = new TranslatorInfoPager({
						element : document.body
					});
					pager.render();
				});
	})(); 
</script>

</html>
