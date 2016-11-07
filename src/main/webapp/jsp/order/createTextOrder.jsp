<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page import="java.util.Locale"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>翻译下单页</title>
	<%@ include file="/inc/inc.jsp" %>
</head>
<body>	
	<!--面包屑导航-->
	<%@ include file="/inc/topHead.jsp" %>
	<%@ include file="/inc/topMenu.jsp" %>
		<!--主体-->
		<form id="textOrderForm" valid="true">
		<div class="placeorder-container" id="textOrderPage">
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
				<div class="right-list-title pb-20 pl-20 none-border">
  					<p><spring:message code="order.translateLan"/></p>
  				</div>
  				<div class="placeorder-translate">
  					<select class="select select-large" id="selectDuad" name="<%=response.getLocale()%>">
  						<c:forEach items="${duadList}" var="duad">
	  						<c:if test="${duad.orderType != 2}">
		  					 	<option value="${duad.duadId}"  currency="${duad.currency}" 
								ordinary="${duad.ordinary}"  ordinaryUrgent="${duad.ordinaryUrgent}" 
								professional="${duad.professional}"  professionalUrgent="${duad.professionalUrgent}"  
								publish="${duad.publish}"  publishUrgent="${duad.publishUrgent}"
								sourceEn="${duad.sourceEn}" duadId="${duad.duadId}">
									<c:choose>
										<c:when test="<%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>">${duad.sourceCn}→${duad.targetCn}</c:when>
										<c:otherwise>${duad.sourceEn}→${duad.targetEn}</c:otherwise>
									</c:choose>

								</option>
							</c:if>
						</c:forEach>
  					</select>
  				</div>
			</div>
			<!--白色背景-->
			<div class="white-bj">
				<div class="right-list-title pb-20 pl-20 none-border">
  					<p><spring:message code="order.translateContent"/></p>
  				</div>
  				<div class="translate-int radius">
  					<p><textarea id="translateContent" name="translateContent" class="int-text textarea-xlarge-100 radius"></textarea></p>
  					<p class="right"><input type="button" class="btn border-blue radius20 btn-80" value="<spring:message code="order.uploadDoc"/>"></p>
  				</div>	
			</div>
			<!--白色背景-->
			<div class="white-bj">
				<div class="selection-level mt-20" id="transGrade">
					<ul class="none-ml current" name="0">
						<li class="blue">
							<p><spring:message code="order.Standard"/></p>
							<p><i class="icon-star-empty"></i></p>
						</li>
						<li>
							<p><spring:message code="order.stanInstruction"/></p>
						</li>
						<li>
							<p><span id="stanPrice">150</span><spring:message code="order.thousandWords"/></p>
							<p class="ml-30"><span>1</span>次免费修改</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p><spring:message code="order.stanInfo1"/></p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p><spring:message code="order.stanInfo2"/></p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p><spring:message code="order.stanInfo3"/></p>
						</li>
						<label><i class="icon iconfont">&#xe617;</i></label>
					</ul>
					<ul name="1">
						<li class="blue">
							<p><spring:message code="order.Professional"/></p>
							<p><i class="icon-star-empty"></i><i class="icon-star-empty"></i></p>
						</li>
						<li>
							<p><spring:message code="order.proInstruction"/></p>
						</li>
						<li>
							<p><span id="proPrice">150</span><spring:message code="order.thousandWords"/></p>
							<p class="ml-30"><span>1</span>次免费修改</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p><spring:message code="order.proInfo1"/></p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p><spring:message code="order.proInfo2"/></p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p><spring:message code="order.proInfo3"/></p>
						</li>
					</ul>
					<ul name="2">
						<li class="blue">
							<p><spring:message code="order.Publishing"/></p>
							<p><i class="icon-star-empty"></i><i class="icon-star-empty"></i><i class="icon-star-empty"></i></p>
						</li>
						<li>
							<p><spring:message code="order.pubInstruction"/></p>
						</li>
						<li>
							<p><span id="pubPrice">150</span><spring:message code="order.thousandWords"/></p>
							<p class="ml-30"><span>1</span>次免费修改</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p><spring:message code="order.pubInfo1"/></p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p><spring:message code="order.pubInfo2"/></p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p><spring:message code="order.pubInfo3"/></p>
						</li>
					</ul>
				</div>
				<!--select-->
				<div class="selection-select mt-50">
					<ul>
						<li class="none-ml">
							<p class="word"><spring:message code="order.purpose"/></p>
							<p>
								<select id="selectPurpose" name="selectPurpose" class="select select-medium radius">
									<c:forEach items="${purposeList}" var="purpose">
										<option value="${purpose.purposeId}">
											<c:choose>
												<c:when test="<%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>">${purpose.purposeCn}</c:when>
												<c:otherwise>${purpose.purposeEn}</c:otherwise>
											</c:choose>
										</option>
										<option value="${purpose.purposeId}"
										<c:if test="${purpose.purposeId == selPurpose}">selected</c:if>>${purpose.purposeName}</option>
									</c:forEach>
								</select>
							</p>
						</li>
						<li>
							<p class="word"><spring:message code="order.Fields"/></p>
							<p>
								<select id="selectDomain" name="selectDomain" class="select select-medium radius">
									<c:forEach items="${domainList}" var="domain">
										<option value="${domain.domainId}">
											<c:choose>
												<c:when test="<%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>">${domain.domainCn}</c:when>
												<c:otherwise>${domain.domainEn}</c:otherwise>
											</c:choose>
										</option>
									</c:forEach>
								</select>
							</p>
						</li>
						<li>
							<p class="word"><spring:message code="order.addedSer"/></p>
							<p><select class="select select-medium radius"><option>排版</option></select></p>
						</li>
						<li class="width-large">
							<p class="word"><spring:message code="order.formatConv"/></p>
							<p>
								<select class="select select-medium radius">
									<option><spring:message code="order.formatConv"/></option>
									<option><spring:message code="order.noFormatConv"/></option>
								</select>
							</p>
							<p class="ml-20"><input type="text" class="int-text int-in-bi radius"></p>
						</li>
					</ul>
				</div>
				<div class="right-list-title pb-20 pl-20 mt-40 none-border">
  					<p><spring:message code="order.translateSpeed"/></p>
  				</div>
  				<div class="urgent">
  					<ul>
  						<li><span>1500</span><spring:message code="order.hourThousandWords"/></li>
  						<li class="mt-10">
  							<p><input type="checkbox" checked=""  class="radio" id="urgentOrder"><spring:message code="order.urgentOrder"/></p>
  							<p class="word ml-20"><spring:message code="order.urgentOrderInfo"/></p>
  						</li>
  					</ul>
  				</div>
			</div>	
			<div class="recharge-btn order-btn placeorder-btn ml-0">
 				<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="order.subTranslation"/>">
 				<p><input name="isAgree" type="checkbox" class="radio" checked=""><spring:message code="order.Agreement"/><a href="#"><spring:message code="order.AgreementInfo"/></a></p>
 			</div>
		</div>
		</div>
		
		<!-- 联系人 -->
		<%@ include file="/jsp/order/textOrderContact.jsp" %>
		</form>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
	(function () {
		var pager;
		seajs.use('app/jsp/order/createTextOrder', function(createTextOrderPage) {
			pager = new createTextOrderPage({element : document.body});
			pager.render();
		});
	})();
</script>
</html>
