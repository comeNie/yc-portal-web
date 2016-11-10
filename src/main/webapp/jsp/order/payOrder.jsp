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
							<p class="line-40">8180889140117891</p>
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
							<p>金额：1244.00元</p>
						</li>
						<li class="line-none line-20">
							<p class="word">&nbsp;</p>
							<p>已优惠：50.00元</p>
						</li>
						<li class="ml-100 line-none">
							<p class="word">&nbsp;</p>
							<p>应付金额：<span>980.00 </span>元</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="white-bj">
				<div class="right-list-title pb-10 ">
  					<p>选择支付方式</p>
  				</div>
  				<div class="payment-method mt-30">
  					<ul>
  						<li class="union"></li>
  					</ul>
  					<ul>
  						<li class="zhifb"></li>
  					</ul>
  					<ul>
  						<li class="paypal"></li>
  					</ul>
  					<%--<ul class="current">--%>
  						<%--<li>翻译后付费</li>--%>
  						<%--<label><i class="icon iconfont">&#xe617;</i></label>--%>
  					<%--</ul>--%>
  					<ul class="none-ml">
  						<li class="payment-balance">
  							<p>账户余额</p>
  							<p class="word">支付余额：300.00元</p>
  						</li>
  					</ul>
  				</div>
  				<div class="payment-btn">
  					<ul>
  						<li>余额不足，可先<input type="button" class="btn radius20 border-blue btn-80 ml-10" value="充 值"></li>
  					</ul>
  				</div>
  				
  			</div>

			<div class="recharge-btn order-btn placeorder-btn ml-0">
 				<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="支 付">
 			</div>
			
		</div>
		</div>
</body>
</html>
