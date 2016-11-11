<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>口译下单页</title>
	<%@ include file="/inc/inc.jsp" %>
</head>
<body>	
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
  					<p>支付订单</p>
  				</div>
  				<div class="selection-select single-select mt-20">
					<ul class="mb-40">
						<li class="none-ml">
							<p class="word">订单号</p>
							<p class="line-40">${orderId}</p>
						</li>
						<%--<li>--%>
							<%--<p class="word">订单性质</p>--%>
							<%--<p><select class="select select-250 radius"><option>企业订单（8折）</option></select></p>--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<p class="word">优惠券</p>--%>
							<%--<p><select class="select select-300 radius"><option>50元优惠券；有效期至2016-11-04</option></select></p>--%>
						<%--</li>--%>
						<%--<li>--%>
							<%--<p class="word">会场数量</p>--%>
							<%--<p><input type="text" class="int-text int-in-300 radius" placeholder="请输入会场数量"></p>--%>
						<%--</li>--%>
					</ul>
					<ul>
						<li class="none-ml line-none line-20">
							<p class="word">订单金额</p>
							<p>金额：100元</p>
						</li>
						<li class="line-none line-20">
							<p class="word">&nbsp;</p>
							<p>已优惠：50.00元</p>
						</li>
						<li class="ml-100 line-none">
							<p class="word">&nbsp;</p>
							<p>应付金额：<span><fmt:formatNumber value="${orderFee.totalFee/1000}" pattern="#,##0.00#"/> </span>元</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="white-bj">
				<div class="right-list-title pb-10 ">
  					<p>选择支付方式</p>
  				</div>
  				<div id="payment-method" class="payment-method mt-30">
					<c:choose>
						<%--人民币--%>
						<c:when test="${orderFee.currencyUnit == '1'}">
							<%--银联--%>
							<ul payType="YL" class="current">
								<li class="union"></li>
								<label><i class="icon iconfont">&#xe617;</i></label>
							</ul>
							<%--支付宝--%>
							<ul payType="ZFB">
								<li class="zhifb"></li>
							</ul>
							<ul payType="YE"  class="none-ml">
								<li class="payment-balance">
									<p>账户余额</p>
									<p class="word">支付余额：300.00元</p>
								</li>
							</ul>
						</c:when>
						<%--美元--%>
						<c:when test="${orderFee.currencyUnit == '2'}">
							<%--paypal--%>
							<ul payType="PP" class="current">
								<li class="paypal"></li>
								<label><i class="icon iconfont">&#xe617;</i></label>
							</ul>
						</c:when>
						<%--<ul class="current">--%>
						<%--<li>翻译后付费</li>--%>
						<%--<label><i class="icon iconfont">&#xe617;</i></label>--%>
						<%--</ul>--%>
					</c:choose>
  				</div>
  				<div class="payment-btn">
					<%--人民币订单,且余额不足--%>
					<c:if test="${orderFee.currencyUnit == '1'}">
  					<ul>
  						<li>余额不足，可先<input type="button" class="btn radius20 border-blue btn-80 ml-10" value="充 值"></li>
  					</ul>
					</c:if>
  				</div>
  			</div>
			<div class="recharge-btn order-btn placeorder-btn ml-0">
 				<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="支 付">
 			</div>
			<form id="toPayForm" method="post" action="${_base}/pay/gotoPay">
				<input type="hidden" name="orderId" value="20161112900034">
				<input type="hidden" name="orderAmount" value="${orderFee.totalFee}">
				<input type="hidden" name="currencyUnit" value="${orderFee.currencyUnit}">
				<input type="hidden" id="payType" name="payOrgCode">
				<%--当前地址--%>
				<input type="hidden" id="merchantUrl" name="merchantUrl">
			</form>
		</div>
		</div>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript" src="${uedroot}/scripts/modular/eject.js"></script>
<script type="text/javascript">
	(function () {
		var pager;
		seajs.use('app/jsp/order/payOrder', function(payOrderPager) {
			pager = new payOrderPager({element : document.body});
			pager.render();
		});
	})();
</script>
</html>
