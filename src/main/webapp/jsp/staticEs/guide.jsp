<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>Single guide</title>
	<%@include file="/inc/inc.jsp" %>
</head>
<body class="static-body">
<!--面包屑导航-->
<%@include file="/inc/topHead.jsp" %>
<!--主导航-->
<%@include file="/inc/topMenu.jsp" %>
<!--主体-->
<div class="place-baner">
	<div class="place-list">
		<ul>
			<li>
				<p class="line">_________________</p>
				<p class="word">
					<%--找翻译，就选译云--%>
					<span class="large">YeeCloud, your better choice</span>
					<%--在线发布您的翻译需求，全球译员为您翻译--%>
					<span>Online publishing your translation needs, the global translator for you</span>
				</p>
				<p class="line">_________________</p>
			</li>
			<%--立即发布翻译任务--%>
			<li class="pacbtn"><input id="order-btn" type="button" class="btn border-white btn-230 radius20" value="Need Translation Service"></li>
		</ul>
	</div>
</div>
<div class="static-wrapper">
	<!--标题-->
	<div class="static-title">
		<%--下单流程--%>
		<p>Single process</p>
		<p class="line"></p>
	</div>

	<div id="st1">
		<div class="static-tab static-tab2">
			<ul>
				<li class="current">
					<a href="javascript:">
						<p class="icon1" id="tab-icon1" style="display:none;"></p>
						<p class="icon2" id="tab-icon2"></p>
					</a>
					<%--提交翻译任务--%>
					<p class="word word-font">Submit</p>
				</li>
				<div class="line"></div>
				<li id="st1-btn">
					<a href="javascript:">
						<p class="icon3" id="tab-icon3"></p>
						<p class="icon4" id="tab-icon4" style="display:none;"></p>
					</a>
					<%--支付订单--%>
					<p class="word word-font">Payment</p>
				</li>
				<div class="line1"></div>
				<li>
					<a href="javascript:">
						<p class="icon5" id="tab-icon5"></p>
						<p class="icon6" id="tab-icon6" style="display:none;"></p>
					</a>
					<%--获取翻译结果--%>
					<p class="word word-font">Results</p>
				</li>
				<div class="line"></div>
				<li>
					<a href="javascript:">
						<p class="icon7" id="tab-icon7"></p>
						<p class="icon8" id="tab-icon8" style="display:none;"></p>
					</a>
					<%--确认评价订单--%>
					<p class="word word-font">Confirm</p>
				</li>
			</ul>
		</div>


		<div id="renz-table1">
			<div class="static-list">
				<ul>
					<%--第一步 提交翻译任务--%>
					<li class="word"><span>Step 1 </span>Submit translation task</li>
					<%--注册/登录译云账户，点击”立即下单“，选择需要的业务类型，根据提示完成并提交您的翻译任务即可。目前，译云提供了快速翻译、文档翻译、简历翻译、创意翻译、证件翻译、口译翻译几大业务类型。--%>
					<li>Register for/login to your YeeCloud account, then click "Order Now." Choose the type of services required, and then submit your translation task based on our guidelines. Currently, YeeCloud's translation services fall into several categories, including quick translation, document translation, resume translation, creative translation, credential translation, and interpretation.</li>
				</ul>
			</div>
		</div>
		<div id="renz-table2"  style="display: none;">
			<div class="static-list">
				<ul>
					<%--第二步 支付订单--%>
					<li class="word"><span>Step 2 </span>Pay for order</li>
					<%--订单完成支付后，才会进入翻译审校环节，为了不耽误您的时间，请您下单后及时付款。其中，文档翻译在提交订单后，将会有客服人员为您报价并引导您完成支付；其它业务类型，系统将会自动计算服务价格。--%>
					<li>The translation and proofreading will not become active until payment is finished. In order to save your time, please pay immediately after placing an order. For document translation, our customer service personnel will provide a quote to you and guide you through your payment options after you place an order; for other translation services, the system will calculate the service price automatically.</li>
				</ul>
			</div>
		</div>
		<div id="renz-table3"  style="display: none;">
			<div class="static-list">
				<ul>
					<%--第三步 获取翻译结果--%>
					<li class="word"><span>Step 3 </span>Receive translation</li>
					<%--订单经过严格的翻译审校后，系统会将第一时间将翻译结果通过Email发送给您，所以，请务必保证邮件地址的准确性。同时，您也可登录译云账户，在“我的订单”中随时查询翻译进度，以及查询&下载译文。--%>
					<li>The system will send you the finished translation via email at the earliest possible time, but only after the document has gone through our strict translation and proofreading procedures. With this in mind, please ensure to provide an accurate email address. Meanwhile, you can log into your YeeCloud account to check the progress of the translation in the "My Order" at any time; you can also download the translation there.</li>
			</div>
		</div>
		<div id="renz-table4"  style="display: none;">
			<div class="static-list">
				<ul>
					<%--第四步 确认评价订单--%>
					<li class="word"><span>Step 4 </span>Confirm and comment</li>
					<%--品质和信誉是译云的生命，译云全流程、全方位保障翻译服务质量，获取翻译结果后，您可以对订单和译员服务进行监督和评价，不满意免费修改。--%>
					<li>Quality and reputation are vital to YeeCloud, which guarantees translation service quality through the entire process and in all aspects. You can comment on and monitor your order and the translator after you receive the finished translation. If you are not satisfied with the finished translation, changes will be provided free of charge.</li>
				</ul>
			</div>
		</div>

	</div>

</div>
<!--底部-->
<%@include file="/inc/indexFoot.jsp" %>

<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/jqueryrotate.2.3.js"></script>

<script type="text/javascript">
	$("#order-btn").click(function () {
		window.location.href = "${_base}/written";
	});
</script>
</body>
</html>
