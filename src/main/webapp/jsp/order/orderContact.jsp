<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <%@ include file="/inc/inc.jsp" %>
    <title>联系人</title>
    <c:choose>
        <c:when test="${TransType == '2'}">
            <c:set var="order" value="${sessionScope.oralOrderInfo}" scope="session" />
            <c:set var="orderSummary" value="${sessionScope.oralOrderSummary}" scope="session" />
        </c:when>
        <c:otherwise>
            <c:set var="order" value="${sessionScope.writeOrderInfo}" scope="session" />
            <c:set var="orderSummary" value="${sessionScope.writeOrderSummary}" scope="session" />
        </c:otherwise>
    </c:choose>

    <c:set var="transType" value="${order.baseInfo.translateType}" />
</head>
<body>
    <!--面包屑导航-->
    <%@ include file="/inc/topHead.jsp" %>
    <%@ include file="/inc/topMenu.jsp" %>
    <!--主体-->
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
<!--编辑信息弹出框-->	
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
	                <p>
	                	<input type="text" class="int-text int-xlarge radius" id="email" placeholder="<spring:message code="yccontactway.placeholder.email" />" onblur="checkUserEmail('email','emailErrMsg','emailErrorText')"/>
	                	<input type="hidden" id="isDefaultEdit"/>
	                </p>
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
    <!-- 联系人 -->
    <div class="placeorder-container contact-interpret" id="contactPage">
        <div class="placeorder-wrapper">
            <!--步骤-->
            <div class="place-bj">
                <div class="place-step">
                    <!--进行的状态-->
                    <div class="place-step-none adopt-wathet-bj">
                        <ul>
                            <li class="circle"><i class="icon iconfont">&#xe60f;</i></li>
                            <li class="word"><spring:message code="order.translateLan"/></li>
                        </ul>
                        <p class="line"></p>
                    </div>
                    <!--未进行的状态-->
                    <div class="place-step-none adopt-blue-bj">
                        <ul>
                            <li class="circle"><i class="icon iconfont">&#xe60d;</i></li>
                            <li class="word"><spring:message code="order.contact"/></li>
                        </ul>
                        <p class="line"></p>
                    </div>
                    <!--未进行的状态-->
                    <div class="place-step-none adopt-ash-bj">
                        <ul>
                            <li class="circle"><i class="icon iconfont">&#xe608;</i></li>
                            <li class="word"><spring:message code="order.payment"/></li>
                        </ul>
                        <p class="line"></p>
                    </div>

                </div>
            </div>
            <!--白色背景-->
            <div class="white-bj">
                <div class="right-list-title pl-20 none-border">
                    <p><spring:message code="order.ContactInfo"/></p>
                </div>
                <input type="hidden"  name="gnCountryId" value="${Contact.gnCountryId}" />
            	<div class="oral-form">
				     <ul>
				        <c:forEach items="${contactList}" var="contactInfo">
					         <li contact-way>
				                  <c:if test="${contactInfo.isDefault==1}">
				                  	  <p><input type="radio" name="checkContect" value="${contactInfo.userName},${contactInfo.gnCountryId},${contactInfo.mobilePhone},${contactInfo.email}" checked></p>
				                  	  <p>${contactInfo.userName}</p>
							          <p>${contactInfo.mobilePhone}</p>
							          <p>${contactInfo.email}</p>
							          <a class="right-btn mr-20 undis" edit onclick="editContact('${contactInfo.contactId}')">编辑</a>
				                  </c:if>
				                  <c:if test="${contactInfo.isDefault==0}">
					                  <div style="display:none;" name="moreConcats">
					                  		 <p><input type="radio" name="checkContect" value="${contactInfo.userName},${contactInfo.gnCountryId},${contactInfo.mobilePhone},${contactInfo.email}"></p>
					                  		 <p>${contactInfo.userName}</p>
									          <p>${contactInfo.mobilePhone}</p>
									          <p>${contactInfo.email}</p>
								              <a class="right-btn undis" onclick="setDefaultValue('${contactInfo.contactId}')">设为默认的地址</a>
											  <a class="right-btn mr-20 undis" edit onclick="editContact('${contactInfo.contactId}')">编辑</a>
					                  </div>
				                  </c:if>
					           </li>
				         </c:forEach>
				       </ul>
			         	<div class="operate">
				                <a href="javascript:void(0)" class="opera-green mr-10"  id="upContect" onclick="upConcats()" style="display:none;" up >收起</a>
				                <a href="javascript:void(0)" class="opera-green mr-10"  id="moreButId" onclick="moreConcats()" >更多</a>
								<a href="javascript:void(0)" class="opera-green" id="add-person">新增</a>
			           </div>
			  	</div>
            </div>
            <!--白色背景-->
            <div class="white-bj">
                <input type="hidden" id="transType" value="${transType}">
                <div class="right-list-title pb-10 ">
                    <p><spring:message code="order.ConfirmOrderInfo"/></p>
                </div>
                <div class="right-list-table">
                    <c:if test="${transType != '2'}">
                        <table id="textOrderTable" class="table table-th-color">
                            <thead>
                            <tr>
                                <th width="32%"><spring:message code="order.Subject"/></th>
                                <th width="17%"><spring:message code="order.Language"/></th>
                                <th width="17%"><spring:message code="order.Fields"/></th>
                                <th width="17%"><spring:message code="order.purpose"/></th>
                                <th width="17%"><spring:message code="order.TranslationGrade"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${order.baseInfo.translateName}</td>
                                <td>${orderSummary.duadName}</td>
                                <td>${orderSummary.purposeName}</td>
                                <td>${orderSummary.domainName}</td>
                                <td>${orderSummary.translevel}</td>
                            </tr>
                            </tbody>
                        </table>
                    </c:if>
                    <%--口译订单--%>
                    <c:if test="${transType == '2'}">
                        <table class="table table-th-color" id="oralOrderTable">
                            <thead>
                            <tr>
                                <th width="24%"><spring:message code="order.Subject"/></th>
                                <th width="12%"><spring:message code="order.translateLan"/></th>
                                <th width="12%"><spring:message code="order.InterpretationType"/></th>
                                <th width="12%"><spring:message code="order.StartingTime"/></th>
                                <th width="12%"><spring:message code="order.EngdingTime"/></th>
                                <th width="12%"><spring:message code="order.Place"/></th>
                                <th width="12%"><spring:message code="order.MeetingAmount"/></th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>${order.baseInfo.translateName}</td>
                                <td>${orderSummary.duadName}</td>
                                <td>${orderSummary.translevel}</td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                                    value="${order.productInfo.startTime}"/></td>
                                <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                                    value="${order.productInfo.endTime}"/></td>
                                <td>${order.productInfo.meetingAddress}</td>
                                <td>${order.productInfo.meetingSum}</td>
                            </tr>
                            </tbody>
                        </table>
                    </c:if>
                </div>

                <c:if test="${transType != '2'}">
                    <div class="right-list-title pb-10 mt-20 none-border">
                        <!-- 给译员留言 -->
                        <p><spring:message code="order.LeaveMessage"/></p>
                    </div>
                    <div class="lx-textarea">
                        <p><textarea id="remark"
                                 onkeyup="textLimit(this,50);" onkeydown="textLimit(this,50);"
                                 oninput="textLimit(this,50);"  onpropertychange="textLimit(this,50);"
                                class="int-text textarea-xlarge-text radius">${order.baseInfo.remark}</textarea></p>
                    </div>
                </c:if>
            </div>
            <!--白色背景-->
            <div class="white-bj">
                <div class="right-list-title pb-10 none-border">
                    <p><spring:message code="order.TotalPirce"/></p>
                </div>
                <div class="urgent">
                    <ul>

                        <li id="price">
                            <c:if test="${transType == '0' && order.feeInfo.currencyUnit == '1'}">
                                <span><fmt:formatNumber value="${order.feeInfo.totalFee/1000}" pattern="#,##0.00#"/></span><spring:message code="order.yuan"/>
                            </c:if>
                            <c:if test="${transType == '0' && order.feeInfo.currencyUnit == '2'}">
                                $<span><fmt:formatNumber value="${order.feeInfo.totalFee/1000}" pattern="#,##0.00#"/></span>
                            </c:if>
                            <c:if test="${transType != '0'}">
                                <spring:message code="order.waitPatiently" />
                            </c:if>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="recharge-btn order-btn placeorder-btn">
                <input type="button" id="toCreateOrder" skip="${skip}" class="btn btn-yellow btn-xxxlarge radius10" value="<spring:message code="order.Back"/>">
                <input type="button" id="submitOrder" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="order.SubmitOrder"/>">
            </div>
        </div>
    </div>

    <!--底部-->
    <%@include file="/inc/indexFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript" src="${_base}/resources/template/scripts/modular/contact.js"></script>
<script type="text/javascript">
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
(function () {
   var pager;
   seajs.use(['app/jsp/order/orderContact'], function(orderContactPage) {
       pager = new orderContactPage({element : document.body});
       pager.render();
   });
   //IE8的输入框提示信息兼容
  // $("input,textarea").placeholder();
})();
	
    function textLimit(field, maxlimit) {
        // 函数，3个参数，表单名字，表单域元素名，限制字符；
        if (field.value.length > maxlimit){
            //如果元素区字符数大于最大字符数，按照最大字符数截断；
            field.value = field.value.substring(0, maxlimit);
        }
    }
</script>
</html>