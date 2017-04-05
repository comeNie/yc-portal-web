<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<%@ include file="/inc/inc.jsp" %>
	<title><spring:message code="pay.order.payment"/></title>
</head>
<body>
<!--弹出-->
<div class="eject-big">
	<div class="prompt-samll" id="rechargepop">
		<%--支付--%>
		<div class="prompt-samll-title"><spring:message code="pay.order.payment"/> </div>
		<!--确认删除-->
		<div class="prompt-samll-confirm">
			<ul>
				<%--请输入支付密码，完成订单支付--%>
				<li><spring:message code="pay.order.passwd.prompt"/></li>
				<li><input id="payPass" type="password" autocomplete="off"  class="int-text int-large radius" maxlength="16"></li>
				<li class="eject-btn">
					<%--确 定--%>
					<input type="button" id="completed" class="btn btn-green btn-120 btn-120-dialog radius20" value="<spring:message code="pay.order.ok"/>">
					<%--取 消--%>
					<input type="button" id="close-completed" class="btn border-green btn-120 btn-120-dialog radius20" value="<spring:message code="pay.order.cancell"/>">
				</li>
			</ul>
		</div>
	</div>
	<div class="mask" id="eject-mask"></div>
</div>
<!--/弹出结束-->
<!--面包屑导航-->
	<%@ include file="/inc/topHead.jsp" %>
	<%@ include file="/inc/topMenu.jsp" %>
	
		<!--主体-->
		<div class="placeorder-container">
		<div class="placeorder-wrapper">
			<!--步骤-->
			<div class="place-bj">
				<div class="place-step">
					<!--进行的状态-->
			 		<div class="place-step-none adopt-wathet-bj">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60f;</i></li>
							<%--翻译内容--%>
			 				<li class="word"><spring:message code="order.translateLan"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-wathet-bj">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60d;</i></li>
							<%--填写联系方式--%>
			 				<li class="word"><spring:message code="order.contact"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-blue-bj">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe608;</i></li>
							<%--支付--%>
			 				<li class="word"><spring:message code="order.payment"/></li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
				</div>
			</div>
			<!--白色背景-->
			<div class="white-bj">
				<div class="right-list-title pb-10 ">
					<%--支付订单--%>
  					<p><spring:message code="pay.order.title"/></p>
  				</div>
				<form id="toPayForm" method="post" action="${_base}/p/customer/order/gotoPay" target="_blank">
					<input type="hidden" id="orderId" name="orderId" value="${orderId}">
					<input type="hidden" name="totalFee" value="${orderFee.totalFee}">
					<%--应付金额--%>
					<input type="hidden" id="orderAmount" name="orderAmount" value="${orderFee.totalFee}">
					<input type="hidden" id="currencyUnit" name="currencyUnit" value="${orderFee.currencyUnit}">
					<input type="hidden" name="translateName" value="${translateName}">
					<input type="hidden" id="payType" name="payOrgCode">
					<%--当前地址--%>
					<input type="hidden" id="merchantUrl" name="merchantUrl">
					<%--订单类型 默认为个人用户--%>
					<c:set var="orderType" value="1"/>
					<%--若属于企业，则默认为企业用户--%>
					<c:if test="${comBalanceInfo!=null}">
						<c:set var="orderType" value="2"/>
					</c:if>
					<input id="orderType" type="hidden" name="orderType" value="${orderType}">
					<%--企业标识--%>
					<input id="corporaId" type="hidden" name="corporaId" >
					<%--订单折扣--%>
					<input id="discountSum" type="hidden" name="discountSum">
					<%--优惠券金额--%>
					<input id="couponFee" type="hidden" name="couponFee">
					<%--优惠券ID或优惠码--%>
					<input type="hidden" id="couponId" name="couponId">
				</form>

  				<div class="selection-select single-select mt-20">
					<ul class="mb-40">
						<li class="none-ml">
							<%--订单号--%>
							<p class="word"><spring:message code="pay.order.order.id"/></p>
							<p class="line-40">${orderId}</p>
						</li>
						<%--若是企业用户，则选择企业用户--%>
						<c:if test="${comBalanceInfo!=null}">
						<li>
							<%--订单性质--%>
							<p class="word"><spring:message code="pay.order.order.nature"/></p>
							<p>
								<select class="select select-250 radius" id="orderTypeSelect">
									<%--企业订单--%>
									<option value="2"><spring:message code="pay.order.ent.order.title"
																	  arguments="${comBalanceInfo.discountStr}"/></option>
									<%--个人订单--%>
									<option value="1"><spring:message code="pay.order.individual.order.title"/></option>
								</select>
							</p>
						</li>
						</c:if>
						<li>
							<%--优惠券--%>
							<p class="word"><spring:message code="pay.order.coupon.title"/></p>
							<p>
								<select class="select select-300 radius" id="couponSelect">
									<option value="" faceVal=""><spring:message
											code="pay.order.no.coupon.option"/></option>
								</select>
							</p>
						</li>
						<li>
							<%--优惠码--%>
							<p class="word"><spring:message code="pay.order.coupon.code.title"/></p>
								<%--请输入优惠码--%>
							<p><input type="text" class="int-text int-in-300 radius" id="conponCode" maxlength="16"
									  placeholder='<spring:message code="pay.order.coupon.code.placeholder"/>'></p>
						</li>
					</ul>
					<c:set var="isEn" value="<%=Locale.US.equals(response.getLocale())%>"/>
					<ul>
						<li class="none-ml line-none line-20">
							<%--订单金额--%>
							<p class="word"><spring:message code="pay.order.amount.title"/></p>
							<%--金额--%>
							<p><spring:message code="pay.order.amount.order"/>：<c:if
									test="${orderFee.currencyUnit == '2'}">$</c:if><c:if
									test="${orderFee.currencyUnit == '1' && isEn==true}">¥</c:if><fmt:formatNumber
									value="${orderFee.totalFee/1000}" pattern="#,##0.00"/><c:if
									test="${orderFee.currencyUnit == '1' && isEn!=true}">元</c:if></p>
						</li>
						<li class="line-none line-20">
							<p class="word">&nbsp;</p>
							<%--已优惠--%>
							<p><spring:message code="pay.order.discounted.title"/>：<c:if
									test="${orderFee.currencyUnit == '2'}">$</c:if><c:if
									test="${orderFee.currencyUnit == '1' && isEn==true}">¥</c:if><font
									id="discounted">0.00</font><c:if
									test="${orderFee.currencyUnit == '1' && isEn!=true}">元</c:if></p>
						</li>
						<li class="ml-100 line-none">
							<p class="word">&nbsp;</p>
							<%--应付金额--%>
							<p><spring:message code="pay.order.payable.order"/>：<c:if
									test="${orderFee.currencyUnit == '2'}">$</c:if><c:if
									test="${orderFee.currencyUnit == '1' && isEn==true}">¥</c:if><span
									id="payable"><fmt:formatNumber
									value="${orderFee.totalFee/1000}" pattern="#,##0.00"/></span><c:if
									test="${orderFee.currencyUnit == '1'&& isEn!=true}">元</c:if></p>
						</li>
					</ul>
				</div>
			</div>
			<div class="white-bj">
				<div class="right-list-title pb-10 ">
					<%--选择支付方式--%>
					<p><spring:message code="pay.order.pay.method"/></p>
  				</div>
  				<div id="payment-method" class="payment-method mt-30">
  				</div>
  			</div>
			<%--若是人民币--%>
			<c:if test="${orderFee.currencyUnit == '1'}">
				<%--余额支付--%>
				<form id="yePayForm" method="post" action="${_base}/p/customer/order/payOrder/balance">
					<input type="hidden" name="externalId" value="${orderId}">
					<input type="hidden" id="accountId" name="accountId" value="${balanceInfo.accountId}">
					<input type="hidden" id="balancePass" name="password" />
					<input type="hidden" id="yeTotalAmount" name="totalAmount" value="${orderFee.totalFee}">
					<input type="hidden" name="currencyUnit" value="${orderFee.currencyUnit}">
					<%--订单总费用--%>
					<input type="hidden" name="totalPay" value="${orderFee.totalFee}">
						<%--订单类型--%>
					<input id="yeOrderType" type="hidden" name="orderType" value="1">
						<%--企业标识--%>
					<input id="yeCorporaId" type="hidden" name="corporaId" >
						<%--订单折扣--%>
					<input id="yeDiscountSum" type="hidden" name="discountSum">
						<%--优惠券金额--%>
					<input id="yeCouponFee" type="hidden" name="couponFee">
						<%--优惠券ID或优惠码--%>
					<input id="yeCouponId" type="hidden" name="couponId">
				</form>
			</c:if>
			<div class="recharge-btn order-btn placeorder-btn ml-0">
				<%--支 付--%>
 				<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="pay.order.payment"/>">
 			</div>
			<%--翻译后付费--%>
			<script id="hfPayTemp" type="text/template">
				<ul payType="HF" {{if current == 1}} class="current" {{/if}} >
					<%--翻译后付费--%>
					<li><spring:message code="pay.order.pay.after.trans"/></li>
				{{if current == 1}}
				<label><i class="icon iconfont">&#xe617;</i></label>
				{{/if}}
				</ul>
			</script>
			<%--余额支付--%>
			<script id="yePayTemp" type="text/template">
				<ul payType="YE" class="none-ml {{if current == 2}}current{{/if}}" >
					<%--账户余额--%>
					<li class="payment-balance">
						<%--账户余额--%>
						<p><spring:message code="pay.order.account.balance"/></p>
						<%--支付余额--%>
						<p class="word"><spring:message code="pay.order.pay.balance"/>：<c:if
								test="${isEn==true}">¥</c:if>{{:~liToYuan(balance)}}<c:if
								test="${isEn!=true}">元</c:if></p>
						<%--充值--%>
						<c:if test="${accountEnable=='1'}">
							<p><input type="button" id="depositBtn" class="btn radius20 border-blue btn-80 ml-10"
									  value="<spring:message code="pay.order.balance.recharge"/>"></p>
						</c:if>
					</li>
						{{if current == 2}}
						<label><i class="icon iconfont">&#xe617;</i></label>
						{{/if}}
				</ul>
			</script>

			<script id="otherPayTemp" type="text/template">
				<c:choose>
					<%--人民币--%>
					<c:when test="${orderFee.currencyUnit == '1'}">
						<%--银联--%>
						<ul payType="YL" {{if current == 3}}class="current"{{/if}} >
							<li class="union"></li>
						{{if current == 3}}
							<label><i class="icon iconfont">&#xe617;</i></label>
						{{/if}}
						</ul>
						<%--支付宝--%>
						<ul payType="ZFB">
							<li class="zhifb"></li>
						</ul>
					</c:when>
					<%--美元--%>
					<c:when test="${orderFee.currencyUnit == '2'}">
						<%--paypal--%>
						<ul payType="PP" {{if current == 3}}class="current"{{/if}} >
							<li class="paypal"></li>
							<label><i class="icon iconfont">&#xe617;</i></label>
						</ul>
					</c:when>

				</c:choose>
			</script>
		</div>
		</div>
<!--底部-->
<%@include file="/inc/indexFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
	//订单总金额
	var totalFee = ${orderFee.totalFee};
    //是否需要充值
    var needRecharge = ${needPay!=null?needPay:true};
    //账户余额，若为个人用户则为个人账户余额，否则为企业账户余额
    var balance = 0;
    //待支付金额，目前为总金额
    var orderPayFee = ${orderFee.totalFee};
	//是否需要校验密码
	var needPayPass = "${balanceInfo.payCheck}";

	//个人账户余额
	var acctBalance = ${balanceInfo!=null?balanceInfo.balance:0};
	//账户id
	var acctoundId = "${balanceInfo.accountId}";
	//是否已设置支付密码
	var payPassExist = ${payPassExist!=null?payPassExist:false};

	//企业账户信息
	var comAccountId = "${comBalanceInfo.accountId}";
	var compayId = "${comBalanceInfo!=null?comBalanceInfo.objId:null}";
	//企业折扣
	var discount = ${comBalanceInfo!=null?comBalanceInfo.discount:1};
	//企业账户余额
	var compayBalance = ${comBalanceInfo!=null?comBalanceInfo.balance:0};
	//是否允许后付费，适用于企业账户
	var allowAfter = ${comBalanceInfo!=null&&"2"==comBalanceInfo.accountType?true:false};
    //企业优惠金额
    var comDisFee = 0;

    //无可用优惠券
	var noCoupon = "<spring:message code="pay.order.no.coupon.option"/>";
	//优惠券优惠金额
    var couponDisFee = 0;
	(function () {
		var pager;
		seajs.use('app/jsp/order/payOrder', function(payOrderPager) {
			pager = new payOrderPager({element : document.body});
			pager.render();
		});
	})();
</script>
</html>
