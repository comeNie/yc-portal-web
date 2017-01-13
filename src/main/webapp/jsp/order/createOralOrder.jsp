<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <%@ include file="/inc/inc.jsp" %>
    <title><spring:message code="order.oralTittle"/></title>

	<script src="${_base}/resources/spm_modules/my97DatePicker/WdatePicker.js"></script>
	<c:set var="order" value="${sessionScope.oralOrderInfo}" scope="session" />
</head>
<body>

	<input type="hidden" name="b-transLevel" value="<c:forEach  items="${order.productInfo.translateLevelInfoList }" var="lev">
		${lev.translateLevel},
	</c:forEach>"/>
	<input type="hidden" name="b-language" value="<c:forEach  items="${order.productInfo.languagePairInfoList}" var="lan">
		${lan.languagePairId},
	</c:forEach>"/>
    <input type="hidden" name="b-place" value="${order.productInfo.meetingAddress}"/>
    <input type="hidden" name="b-sex" value="${order.productInfo.interperGen}"/>

	<!--面包屑导航-->
	<%@ include file="/inc/topHead.jsp" %>
	<%@ include file="/inc/topMenu.jsp" %>
		<!--主体-->
		<form id="oralOrderForm" valid="true">
		<div class="placeorder-container" id="oralOrderPage" >
		<div class="placeorder-wrapper">
			<!--步骤-->
			<div class="place-bj">
				<div class="place-step">
					<!--进行的状态-->
			 		<div class="place-step-none adopt-blue-bj">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60f;</i></li>
			 				<li class="word"><spring:message code="order.translateLan"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-ash-bj">
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
  					<p><spring:message code="order.SubjectTrans"/></p>
  				</div>
  				<div class="oral-form">
  					<ul>
  						<li>
  							<p><input id="transSubject" name="transSubject" maxlength="15" type="text" class="int-text int-100 radius"
                                      value="${order.baseInfo.translateName}" placeholder="<spring:message code="order.descTransRequire"/>">
                            </p>
  							<label></label>
  						</li>
  					
  					</ul>
  				</div>
			</div>
			<!--白色背景-->
			<div class="white-bj pb-0" >
				<div class="right-list-title pl-20 none-border">
  					<p><spring:message code="order.translateLan"/></p>
  				</div>
  				<div class="form-lable form-pt-0">
  				<ul>
  					<li>
  						<c:forEach items="${duadList}" var="duad">
  						<c:if test="${duad.orderType == 2}">
	  						<p>
	  							<span><input name="duad" type="checkbox" class="radio" value="${duad.duadId}" duadZh="${duad.sourceCn}→${duad.targetCn}" duadEn="${duad.sourceEn}→${duad.targetEn}"></span>
	  							<c:choose>
		  							<c:when test="<%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>">
		  								<span name="${duad.duadId}">${duad.sourceCn}→${duad.targetCn}</span>
		  							</c:when>
		  							<c:otherwise> 
		  								<span name="${duad.duadId}">${duad.sourceEn}→${duad.targetEn}</span>
		  							</c:otherwise>
	  							</c:choose>
	  						</p>
	  					</c:if>
						</c:forEach>
  					</li>
  				</ul>
  			</div>
  			<div class="right-list-title pl-20 none-border">
  					<p><spring:message code="order.InterpretationType"/></p>
  				</div>
  				<div class="form-lable form-pt-0">
  				<ul>
  					<li>
  						<p>
  							<!-- 陪同翻译 -->
  							<span><input name="interpretationType" type="checkbox" class="radio"  value="100110"></span>
  							<span name="100110"><spring:message code="order.interpretationType1"/></span>
  						</p>
  						<p>
  							<!-- 交替传译 -->
  							<span><input name="interpretationType" type="checkbox" class="radio" value="100120"></span>
  							<span name="100120"><spring:message code="order.interpretationType2"/></span>
  						</p>
  						<p>
  							<!-- 同声传译  -->
  							<span><input name="interpretationType" type="checkbox" class="radio" value="100130"></span>
  							<span name="100130"><spring:message code="order.interpretationType3"/></span>
  						</p>
  					</li>
  					<label class="x-label"></label>
  				</ul>
  			</div>
			</div>
			<div class="white-bj">
				<div class="selection-select single-select">
					<ul class="mb-40">
						<li class="none-ml">
							<p class="word"><spring:message code="order.StartingTime"/></p>
							<p class="int-posit"><input id="begin_time" name="begin_time" type="text" class="int-text int-in-250 radius"
                                      onClick="WdatePicker({onpicked: function(){$dp.$('begin_time').blur();},lang:'${my97Lang}',readOnly:true,isShowOK:true,autoPickDate:true, dateFmt:'yyyy-MM-dd HH:mm:ss',opposite:true,minDate: new Date().format('yyyy-MM-dd 00:00:00'),maxDate:'#F{$dp.$D(\'end_time\',{m:-1})}'})"
                                      value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${order.productInfo.startTime}"/>" /><i class=" icon-sort-down"></i></p>
						</li>
						<li>
							<p class="word"><spring:message code="order.EngdingTime"/></p>
							<p class="int-posit"><input id="end_time" name="end_time" type="text" class="int-text int-in-250 radius"
                                      onClick="WdatePicker({onpicked: function(){$dp.$('begin_time').blur();},lang:'${my97Lang}',readOnly:true,isShowOK:true,autoPickDate:true, dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'begin_time\',{m:+1})||\'%y-%M-%d\'}'})"
                                      value="<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${order.productInfo.endTime}"/>" /><i class=" icon-sort-down"></i></p>
						</li>
						<li>
							<p class="word"><spring:message code="order.Place"/></p>
							<!-- 北京 京外城市 国外 -->
							<p><select id="place" name="place" class="select select-250 radius">
								<option value="bj"><spring:message code="order.place1"/></option>
								<option value="other"><spring:message code="order.place2"/></option>
								<option value="abroad"><spring:message code="order.place3"/></option>
							</select></p>
						</li>
						<li>
							<p class="word"><spring:message code="order.MeetingAmount"/></p>
							<p><input id="meetingAmount" name="meetingAmount" type="text" class="int-text int-in-250 radius"
                                  value="${order.productInfo.meetingSum}" placeholder="<spring:message code="order.MeetingAmountInfo"/>"></p>
							<label></label>
						</li>
					</ul>
					<ul>
						<li class="none-ml">
							<p class="word"><spring:message code="order.interpreterNum"/></p>
							<p><input id="interpreterNum" name="interpreterNum" type="text" class="int-text int-in-250 radius"
                                      value="${order.productInfo.interperSum}" placeholder="<spring:message code="order.interpreterNumInfo"/>">
                            </p>
							<label></label>
						</li>
						<li>
							<p class="word"><spring:message code="order.Gender"/></p>
							<p>
								<select id="gender" name="gender" class="select select-250 radius">
									<option value="2"><spring:message code="order.sex1"/></option>
									<option value="0"><spring:message code="order.sex2"/></option>
									<option value="1"><spring:message code="order.sex3"/></option>
								</select>
							</p>
						</li>
					</ul>
				</div>
  			</div>	
			<div class="recharge-btn order-btn placeorder-btn ml-0">
 				<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="order.subTranslation"/>">
 				<p><input id="isAgree" name="isAgree" type="checkbox" class="radio" checked=""><spring:message
						code="order.Agreement"/><a href="${_base}/rule" target="_blank"><spring:message
						code="order.AgreementInfo"/></a></p>
 			</div>
			
		</div>
		</div>
		
		</form>
	<!--底部-->
	<%@include file="/inc/indexFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
	(function () {
		var pager;
		seajs.use('app/jsp/order/createOralOrder', function(createOralOrderPage) {
			pager = new createOralOrderPage({element : document.body});
			pager.render();
		});
        $("input").placeholder();
        //checkbox兼容ie8
//        $('.form-lable input').iCheck({
//            checkboxClass: 'icheckbox_flat-blue',
//            radioClass: 'iradio_flat-blue'
//        });
        //checkbox兼容ie8
//        $('.recharge-btn input').iCheck({
//            checkboxClass: 'icheckbox_flat-blue',
//            radioClass: 'iradio_flat-blue'
//        });
	})();
</script>
</html>
