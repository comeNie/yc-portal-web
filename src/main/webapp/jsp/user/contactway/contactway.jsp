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
<title><spring:message code="yccontactway.contactway"/></title>
</head>
<body>
<!--删除弹窗--> 
<div class="eject-big">
    <div class="prompt-samll" id="delete-dlog" delete-dlog>
    <div class="prompt-samll-title"><spring:message code="yccontactway.del.tip" /></div>
    <!--确认删除-->
    <div class="prompt-samll-confirm">
      <ul>
      <li><spring:message code="yccontactway.confirm.del" /></li>
      <li class="eject-btn">
        <input type="button" class="btn btn-green btn-120 radius20" value="<spring:message code="yccontactway.js.showOkValueMsg" />" completed onclick="confirmDel()">
        <input type="button"  class="btn border-green btn-120 radius20" value="<spring:message code="yccontactway.js.cancel" />" cancel>
      </li>   
      </ul>
    </div>
    </div>  
  <div class="mask" id="eject-mask"></div>
</div>
<!--新增信息弹窗--> 
<div class="eject-big">
  <div class="prompt-samll add-msg" id="add-msg">
    <div class="prompt-samll-title"><spring:message code="yccontactway.addinfo" /></div>
    <div class="prompt-samll-confirm">
      <ul>
        <li class="form-lable">
            <ul>
              <li>
                <p class="word"><spring:message code="yccontactway.username" />:</p>
                <p><input type="text" class="int-text int-xlarge radius" placeholder="<spring:message code="yccontactway.placeholder.username" />" id="userNameAdd" onblur="checkUserName('userNameAdd','userNameAddErrMsg','userNameAddErrorText')"/></p>
              	<label id="userNameAddErrMsg" style="display: none;"><span class="ash" id="userNameAddErrorText"></span></label>
              </li>
              <li>
                <p class="word"><spring:message code="yccontactway.mobilePhone" />:</p>
                <p>
                  <div class="select-wrap pull-left mr-20 contact-select">
                    <select id="country-add" class="select select-in"></select>
                  </div>
                  <input type="text" class="int-text int-in-bi radius pull-left" placeholder="<spring:message code="yccontactway.placeholder.mobilePhone" />" id="telephoneAdd" onblur="checkphone('telephoneAdd','telephoneAddErrMsg','telephoneAddErrorText','country-add')"/>
               	 <label id="telephoneAddErrMsg" style="display: none;"><span class="ash" id="telephoneAddErrorText"></span></label>
                </p>
                
              </li>
              <li>
                <p class="word"><spring:message code="yccontactway.email" />:</p>
                <p><input type="text" class="int-text int-xlarge radius" placeholder="<spring:message code="yccontactway.placeholder.email" />" id="emailAdd" onblur="checkUserEmail('emailAdd','emailAddErrMsg','emailAddErrorText')"/></p>
              	<label id="emailAddErrMsg" style="display: none;"><span class="ash" id="emailAddErrorText"></span></label>
              </li>
            </ul>
        </li>
        <li class="eject-btn">
          <input type="button" id="saveButton" class="btn btn-green btn-100 radius20" value="<spring:message code="yccontactway.js.showOkValueMsg" />" >
          <input type="button" id="add-cancel" class="btn border-green btn-100 radius20" value="<spring:message code="yccontactway.js.cancel" />">
        </li>   
      </ul>
    </div>
  </div>  
  <div class="mask" id="eject-mask"></div>
</div>
<!--<spring:message code="yccontactway.editinfo" />弹窗--> 
<div class="eject-big">
  <div class="prompt-samll add-msg" edit-msg>
    <div class="prompt-samll-title"><spring:message code="yccontactway.editinfo" /></div>
    <div class="prompt-samll-confirm">
      <ul>
        <li class="form-lable">
            <ul>
              <li>
                <p class="word"><spring:message code="yccontactway.username" />:</p>
                <p><input type="text" class="int-text int-xlarge radius" id="contactUserName" placeholder="<spring:message code="yccontactway.placeholder.username" />" onblur="checkUserName('contactUserName','userNameErrMsg','userNameErrorText')"/></p>
              	<label id="userNameErrMsg" style="display: none;"><span class="ash" id="userNameErrorText"></span></label>
              </li>
              <li>
                <p class="word"><spring:message code="yccontactway.mobilePhone" />:</p>
                <p>
                  <div class="select-wrap pull-left mr-20 contact-select">
                    <select id="country-edit" class="select select-in"></select>
                  </div>
                  <input type="text" class="int-text int-in-bi radius pull-left" id="telephone" placeholder="<spring:message code="yccontactway.placeholder.mobilePhone" />号" onblur="checkphone('telephone','telephoneErrMsg','telephoneErrorText','country-edit')"/>
                  <label id="telephoneErrMsg" style="display: none;"><span class="ash" id="telephoneErrorText"></span></label>
                </p>
              </li>
              <li>
                <p class="word"><spring:message code="yccontactway.email" />:</p>
                <p><input type="text" class="int-text int-xlarge radius" id="email" placeholder="<spring:message code="yccontactway.placeholder.email" />" onblur="checkUserEmail('email','emailErrMsg','emailErrorText')"/></p>
             	 <label id="emailErrMsg" style="display: none;"><span class="ash" id="emailErrorText"></span></label>
              </li>
            </ul>
        </li>
        <li class="eject-btn">
          <input type="button" class="btn btn-green btn-100 radius20" value="<spring:message code="yccontactway.js.showOkValueMsg" />"  onclick="confirmEdit()">
          <input type="button" class="btn border-green btn-100 radius20" value="<spring:message code="yccontactway.js.cancel" />" edit-cancel>
        </li>   
      </ul>
    </div>
  </div>  
  <div class="mask" eject-mask></div>
</div>
<!--/弹出结束-->
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
  		<div class="right-wrapper contact-way">
  		<!--右侧第一块-->
	
  		<!--右侧第二块-->
  		<div class="right-list mt-0">
  			 <h2 class="title"><spring:message code="yccontactway.contactway" /></h2>
         <ul class="cont-list">
         <c:forEach items="${contactList}" var="contactInfo">
         	<li class="pull-left cont-people current" cont-people>
              <p>
                <span class="key"><spring:message code="yccontactway.username" />:</span>
                <span class="value">${contactInfo.userName}</span>
              </p>
              <p>
                <span class="key"><spring:message code="yccontactway.mobilePhone" />:</span>
                <span class="value">${contactInfo.mobilePhone}</span>
              </p>
              <p>
                <span class="key"><spring:message code="yccontactway.email" />:</span>
                <span class="value">${contactInfo.email}</span>
              </p>
              <div class="operate">
                  <div class="pull-left setting-left active" setting-left>
	                  <c:if test="${contactInfo.isDefault==1}">
	                    <input type="checkbox" checked="checked" id="isdefaultValue" class="checkbox mr-10" onclick="setDefaultValue('${contactInfo.contactId}')"/>
	                  </c:if>
	                  <c:if test="${contactInfo.isDefault==0}">
	                  	<input type="checkbox" class="" id="isdefaultValue" onclick="setDefaultValue('${contactInfo.contactId}')"/>
	                  </c:if>
	                  <span class="txt"><spring:message code="yccontactway.defaultAddress" /></span>
                  </div>
                  <div class="pull-right setting-right">
                    <i class="edit-img" edit onclick="editContact('${contactInfo.contactId}')"></i>
                    <i class="delete-img" delete-btn onclick="delContact('${contactInfo.contactId}')"></i>
                  </div>
              </div>
           </li>
         </c:forEach>
         </ul>
         <div class="add-contact" id="add-person">
           <img src="${uedroot}/images/icon-add.png" class="pull-left mr-10"/>
           <span class="pull-left mr-20"><spring:message code="yccontactway.newcontactway" /></span>
           <span class="pull-left tip-msg">( <spring:message code="yccontactway.add.fail" /> )</span>
         </div>
  		</div>	
  		</div>
  	</div>
  </div>
  </div>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript" src="${_base}/resources/template/scripts/modular/alignment.js"></script>
<script type="text/javascript" src="${_base}/resources/template/scripts/modular/eject.js"></script>
<script type="text/javascript">
$(function(){
	  $('.operate .checkbox').iCheck({
	     checkboxClass: 'icheckbox_flat-blue',
	     radioClass: 'iradio_flat-blue'
	   });
	 });
    var countryCode = "";
    var provinceCode ="";
    var cnCityCode ="";
    var contactInfoMsg ={
    		"userNameEmptyError" : '<spring:message code="yccontactway.username.empty"/>',
    		"userNameExistError" : '<spring:message code="yccontactway.username.exist"/>',
    		"emailEmptyError" : '<spring:message code="yccontactway.email.empty"/>',
    		"emailExistError" : '<spring:message code="yccontactway.email.exist"/>',
    		"emailOKError" : '<spring:message code="yccontactway.email.OK"/>',
    		"phoneEmptyError" : '<spring:message code="yccontactway.mobilephone.empty"/>',
    		"phoneExistError" : '<spring:message code="yccontactway.mobilephone.exist"/>',
    		"phoneOKError" : '<spring:message code="yccontactway.mobilephone.OK"/>',
    		"showOK" : '<spring:message code="yccontactway.js.showOkValueMsg"/>',
    		"showCancal" : '<spring:message code="yccontactway.js.cancel"/>',
    		"saveDataFail" : '<spring:message code="yccontactway.save.error.msg"/>',
    		
    };
	var pager;
	(function() {
		seajs.use('app/jsp/user/contactway/contactWayInfo',function(CompanyInfoPager) {
					pager = new CompanyInfoPager({
						element : document.body
					});
					pager.render();
				});
	})();
</script>
</html>
