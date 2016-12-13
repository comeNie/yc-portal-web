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
			<li class="pacbtn"><input id="order-btn" type="button" class="btn border-white btn-230 radius20" value="Release translation task"></li>
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
		<div class="static-tab">
			<ul>
				<li class="current">
					<a href="javaScript:void(0);">
					<p class="icon2" id="tab-icon2"></p>
					</a>
					<%--提交翻译任务--%>
					<p class="word word-font">Submit translation tasks</p>
				</li>
				<div class="line"></div>
				<li id="st1-btn">
					<a href="javaScript:void(0);">
					<p class="icon3" id="tab-icon3"></p>
					</a>
					<%--支付订单--%>
					<p class="word word-font">Payment order</p>
				</li>
				<div class="line1"></div>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon5" id="tab-icon5"></p>
					</a>
					<%--获取翻译结果--%>
					<p class="word word-font">Obtain translation results</p>
				</li>
				<div class="line"></div>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon7" id="tab-icon7"></p>
					</a>
					<%--确认评价订单--%>
					<p class="word word-font">Confirm evaluation order</p>
				</li>
			</ul>
		</div>

		<div class="static-list">
			<ul>
				<%--第一步 提交翻译任务--%>
				<li class="word"><span>First step</span> Submit translation tasks</li>
				<%--注册/登录译云账户，点击”立即下单“，选择需要的业务类型，根据提示完成并提交您的翻译任务即可。目前，译云提供了快速翻译、文档翻译、简历翻译、创意翻译、证件翻译、口译翻译几大业务类型。--%>
				<li>Registration / login account and click "order immediately translated cloud,", select the type of business, according to the prompts to complete and submit to your translation task. At present, translation cloud provides fast translation, document translation, translation, creative translation, resume document translation, interpreting several types of business.</li>
			</ul>
		</div>
	</div>
	<div id="st2">
		<div class="static-tab">
			<ul>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon1" id="tab-icon1"></p>
					</a>
					<%--提交翻译任务--%>
					<p class="word word-font">Submit translation tasks</p>
				</li>
				<div class="line"></div>
				<li  class="current">
					<a href="javaScript:void(0);">
					<p class="icon4" id="tab-icon4"></p>
					</a>
					<%--支付订单--%>
					<p class="word word-font">Payment order</p>
				</li>
				<div class="line1"></div>
				<li id="st1-btn1">
					<a href="javaScript:void(0);">
					<p class="icon5" id="tab-icon5"></p>
					</a>
					<%--获取翻译结果--%>
					<p class="word word-font">Obtain translation results</p>
				</li>
				<div class="line"></div>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon7" id="tab-icon7"></p>
					</a>
					<%--确认评价订单--%>
					<p class="word word-font">Confirm evaluation order</p>
				</li>
			</ul>
		</div>

		<div class="static-list">
			<ul>
				<%--第二步 支付订单--%>
				<li class="word"><span>Second step</span> Payment order</li>
				<%--订单完成支付后，才会进入翻译审校环节，为了不耽误您的时间，请您下单后及时付款。其中，文档翻译在提交订单后，将会有客服人员为您报价并引导您完成支付；其它业务类型，系统将会自动计算服务价格。--%>
				<li>In order to complete the payment, will enter the translation verification link, in order not to delay your time, please order immediately after payment. Among them, the document translation in the submission of orders, customer service staff will provide you with a quotation and guide you to complete the payment; other types of business, the system will automatically calculate the price of services.</li>
		</div>
	</div>

	<div id="st3">
		<div class="static-tab">
			<ul>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon1" id="tab-icon1"></p>
					</a>
					<%--提交翻译任务--%>
					<p class="word word-font">Submit translation tasks</p>
				</li>
				<div class="line"></div>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon3" id="tab-icon3"></p>
					</a>
					<%--支付订单--%>
					<p class="word word-font">Payment order</p>
				</li>
				<div class="line1"></div>
				<li class="current">
					<a href="javaScript:void(0);">
					<p class="icon6" id="tab-icon6"></p>
					</a>
					<%--获取翻译结果--%>
					<p class="word word-font">Obtain translation results</p>
				</li>
				<div class="line"></div>
				<li  id="st1-btn2">
					<a href="javaScript:void(0);">
					<p class="icon7" id="tab-icon7"></p>
					</a>
					<%--确认评价订单--%>
					<p class="word word-font">Confirm evaluation order</p>
				</li>
			</ul>
		</div>

		<div class="static-list">
			<ul>
				<%--第三步 获取翻译结果--%>
				<li class="word"><span>Third step</span> Obtain translation results</li>
				<%--订单经过严格的翻译审校后，系统会将第一时间将翻译结果通过Email发送给您，所以，请务必保证邮件地址的准确性。同时，您也可登录译云账户，在“我的订单”中随时查询翻译进度，以及查询&下载译文。--%>
				<li>Order through strict translation and revision, the system will be the first time the translation results through Email sent to you, so please make sure the accuracy of the mail address. At the same time, you can also login account at any time in the query translation cloud, "my order" in the translation process, translation and query &amp; download.</li>
			</ul>
		</div>
	</div>
	<div id="st4">
		<div class="static-tab">
			<ul>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon1" id="tab-icon1"></p>
					</a>
					<%--提交翻译任务--%>
					<p class="word word-font">Submit translation tasks</p>
				</li>
				<div class="line"></div>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon3" id="tab-icon3"></p>
					</a>
					<%--支付订单--%>
					<p class="word word-font">Payment order</p>
				</li>
				<div class="line1"></div>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon5" id="tab-icon5"></p>
					</a>
					<%--获取翻译结果--%>
					<p class="word word-font">Obtain translation results</p>
				</li>
				<div class="line"></div>
				<li class="current">
					<a href="javaScript:void(0);">
					<p class="icon8" id="tab-icon8"></p>
					</a>
					<%--确认评价订单--%>
					<p class="word word-font">Confirm evaluation order</p>
				</li>
			</ul>
		</div>

		<div class="static-list">
			<ul>
				<%--第四步 确认评价订单--%>
				<li class="word"><span>Fourth step</span> Confirm evaluation order</li>
				<%--品质和信誉是译云的生命，译云全流程、全方位保障翻译服务质量，获取翻译结果后，您可以对订单和译员服务进行监督和评价，不满意免费修改。--%>
				<li>Quality and reputation is the life of the whole process of translation cloud, and translation cloud to protect the full range of translation service quality, to obtain the translation results, you can supervise and evaluate to the order and interpreter service, not satisfied with free modification.</li>
			</ul>
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
