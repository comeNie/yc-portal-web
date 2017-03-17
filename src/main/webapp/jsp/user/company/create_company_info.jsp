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
<title>创建企业第一步</title>
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
  		<div class="right-list mt-0 create-company-first">
  			<div class="right-list-title pb-10 pl-20">
  				<p>创建企业</p>
  			</div>
  			<form id="companyInfo" method="post" enctype="multipart/form-data" action="${_base}/p/company/insertCompanyInfo">
  			<div class="form-lable">
  				<ul>
  					<li>
  						<p class="word"><b>*</b><spring:message code="yccompanyinfo.companyname" /></p>
  						<p><input type="text" class="int-text int-xlarge radius" placeholder="First Name" name="companyName" id="companyName"/></p>
  				    	<label id="companyNameErrMsg" style="display: none;">
  				    	   <span class="ash" id="companyNameErrText"></span>
  				    	 </label>
  				    </li>
  					
		            <li>
		              <p class="word"><b>*</b><spring:message code="yccompanyinfo.companylicense" /></p>
		              <p>
			              <div class="input-file">
			              	  <input type="file" class="file" name="attacid" id="attacid"  onchange="uploadImg('attacid','uploadImgErrMsg','uploadImgText')"/>
			                  <span class="txt txt1"><spring:message code="yccompanyinfo.uploadlicense" /></span>
			                  <span class="txt txt2"><spring:message code="yccompanyinfo.uploadlicensesize" /></span>
			                  <label id="uploadImgErrMsg" style="display: none;">
				               <span class="ash" id="uploadImgText"></span>
				              </label>
			              </div>
			              
		              </p>
		            </li>
		            
  					<li>
  						<p class="word"><b>*</b><spring:message code="yccompanyinfo.companyaddress" /></p>
  						<p>
  							<select  class="select select-in-small" id="countryInfo" name="country">
  							</select>
  						</p>
  						<p id="provinceP"><select class="select select-in-small" id="provinceInfo" name="province">
  						  </select>
  						  <spring:message code="interpreter.province" />
  						</p>
  						<p id="cnCityP"><select class="select select-in-small" id="cnCityInfo" name="cnCity"></select>
  							<spring:message code="interpreter.cnCity" />
  						</p>
  						<p><label id="area-error"></label></p>
  					</li>
  					<li>
						<p style="margin-left: 120px"><input type="text" class="int-text int-in-bi radius" id="address" name="address" style="width: 420px" maxlength="100"/>
							<label id="detail-address"></label>
						</p>
					</li>
		            <li>
		              <p class="word"><b>*</b><spring:message code="yccompanyinfo.companybusinessphone"/></p>
		              <p><input type="text" class="int-text int-xlarge radius" name="telephone" id="telephone"/></p>
		            </li>
		            <li>
		              <p class="word"><b>*</b><spring:message code="yccompanyinfo.companylinkman"/></p>
		              <p>
		                <input type="text" class="int-text int-xlarge radius" value="${linkman }" name="linkman" id="linkman"/>
		              </p>
		              <p>
		              	 <label id="linkManErrMsg" style="display: none;">
				               <span class="ash" id="linkManText"></span>
				         </label>  
		              </p>
		            </li>
		            <li>
		              <p class="word"><spring:message code="yccompanyinfo.companylogo"/></p>
		              <p><div class="input-file">
		              	  <input type="file" class="file" name="entpId" id="entpId" onchange="uploadImg('entpId','uploadEntpIdErrMsg','uploadEntpIdText')"/>
		                  <span class="txt txt1"><spring:message code="yccompanyinfo.uploadlogo"/></span>
		                  <span class="txt txt2"><spring:message code="yccompanyinfo.uploadlogosize"/></span>
		              	  <label id="uploadEntpIdErrMsg" style="display: none;">
				               <span class="ash" id="uploadEntpIdText"></span>
				              </label>
		              </div></p>
		            </li>
  			    <li>
              <p class="word"><spring:message code="yccompanyinfo.companyprofile"/></p>
              <p><textarea class="int-text textarea radius" name="content" id="content"></textarea></p>
              <p>
              	 <label id="companyProfileErrMsg" style="display: none;">
		               <span class="ash" id="companyProfileText"></span>
		         </label>  
		      </p>
            </li>
  				</ul>
  			</div>
  			<div class="recharge-btn order-btn">
 				<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="yccompanyinfo.submitsave"/>">
 			</div>
 			</form>
  		</div>	
  	</div>
  </div>
  </div>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
    var countryCode = "";
    var countryCode = "";
    var provinceCode ="";
    var cnCityCode ="";
    var companyInfoMsg ={
    		"showOkValueMsg" : '<spring:message code="ycaccountcenter.js.showOkValueMsg"/>',
    		"showTitleMsg" : '<spring:message code="ycaccountcenter.js.showTitleMsg"/>',
    		"uplaodImageMsg" : '<spring:message code="yccompanyinfo.uplaodImageMsg"/>',
    		"detailAddressErrorMsg" : '<spring:message code="interpreter.address.error.msg"/>',
    		"provinceErrorMsg" : '<spring:message code="interpreter.provice.error.msg"/>',
       		"cityErrorMsg" : '<spring:message code="interpreter.cnCity.error.msg"/>',
       		"detailAddressErrorMsg" : '<spring:message code="interpreter.address.error.msg"/>',
    		"areaTitle" : '<spring:message code="interpreter.area.title"/>',
    		"companynameempty":'<spring:message code="yccompanyinfo.companyname.empty"/>',
    		"companynamelength":'<spring:message code="yccompanyinfo.companyname.length"/>',
    		"licenseempty":'<spring:message code="yccompanyinfo.companylicense.empty"/>',
   			"linkmanlength":'<spring:message code="yccompanyinfo.companylinkman.length"/>',
       		"linkmanempty":'<spring:message code="yccompanyinfo.companylinkman.empty"/>'
    };
	var pager;
	(function() {
		seajs.use('app/jsp/user/company/companyInfo',function(CompanyInfoPager) {
					pager = new CompanyInfoPager({
						element : document.body
					});
					pager.render();
				});
	})();
</script>
</html>
