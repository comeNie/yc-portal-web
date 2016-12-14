<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<%--合作客户--%>
    <title>Cooperative client</title>
	<%@include file="/inc/inc.jsp" %>
</head>
<body class="static-body">
<!--面包屑导航-->
<%@include file="/inc/topHead.jsp" %>
<!--主导航-->
<%@include file="/inc/topMenu.jsp" %>

<!--主体-->
<div class="cooperation-banner">
		<div class="cooperation-big">
		<%--他们这样评价译云--%>
		<div class="cooperation-title">They evaluate the translation cloud</div>
		<div class="cooperation-list" id="scrollDiv">
			<ul>
				<li>
					<p class="img-icon"><img src="${uedroot}/images/Jinshan-icon1.png" /></p>
					<p class="word">
						<span class="bigword">Kingsoft PowerWord：</span>
						<span>With more diversified translation needs, the users are having increasingly higher demand for quality, so simple machine translation already falls short to meet their needs. Here we recommend the human translation service of YeeCloud which is provided by tens of thousands of online translators from across the globe. The fast and high quality translation service will bring users surprises, and here we sincerely recommend you the YeeCloud Translation.</span>
					</p>
				</li>
				<li>
					<p class="img-icon"><img src="${uedroot}/images/zhongj-icon1.jpg" /></p>
					<p class="word">
						<span class="bigword">CCCC Group:</span>
						<span>As one of the world's top 500 enterprises, we set our business footprint in more than 100 countries and regions in the world. With huge translation demand, high translation requirements, YeeCloud covers a wide variety of fields, saves us a lot of time in looking for translators and communicating with them, improves work efficiency and reduces cost. With translators completing the translation on the cloud terminal, we have achieved a more smooth business process.</span>
					</p>
				</li>
				<li>
					<p class="img-icon"><img src="${uedroot}/images/alibb.jpg" /></p>
					<p class="word">
						<span class="bigword">Alibaba:</span>
						<span>As an international Internet company, we need to make the products on Ali platform benefit global customers anytime and anywhere. Thanks to the support of YeeCloud’s efficient translation services and high-level technical support, our sellers are selling products to customers worldwide. We have to say that YeeCloud is the strongest supporter of Alibaba's localization strategy.</span>
					</p>
				</li>
			</ul>
		</div>
		<div class="cooperation-icon"><a href="javaScript:void(0);" id="but_down"><img src="${uedroot}/images/cooper-icon.png" /></a></div>
	</div>
</div>
<div class="static-wrapper">
	<!--标题-->
	<div class="static-title">
		<%--更多客户--%>
		<p>More customers</p>
		<p class="line1"></p>
	</div>
	<div class="cooperation-logo">
		<ul>
			<li class="bj"><a href="javascript:"><p class="c-icon1"></p></a></li>
			<li><a href="javascript:"><p class="c-icon2"></p></a></li>
			<li class="bj"><a href="javascript:"><p class="c-icon3"></p></a></li>
			<li><a href="javascript:"><p class="c-icon4"></p></a></li>
			<li class="bj"><a href="javascript:"><p class="c-icon5"></p></a></li>
			<li><a href="javascript:"><p class="c-icon6"></p></a></li>
			<li class="bj"><a href="javascript:"><p class="c-icon7"></p></a></li>
			<li><a href="javascript:"><p class="c-icon8"></p></a></li>
			<li class="bj"><a href="javascript:"><p class="c-icon9"></p></a></li>
			<li><a href="javascript:"><p class="c-icon10"></p></a></li>
			<li class="bj"><a href="javascript:"><p class="c-icon11"></p></a></li>
			<li><a href="javascript:"><p class="c-icon12"></p></a></li>
			<li class="bj"><a href="javascript:"><p class="c-icon13"></p></a></li>
			<li><a href="javascript:"><p class="c-icon14"></p></a></li>
			<li class="bj"><a href="javascript:"><p class="c-icon15">……</p></a></li>
		</ul>
	</div>

</div>
<!--底部-->
<%@include file="/inc/indexFoot.jsp" %>
			
<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/jqueryrotate.2.3.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/jq_scroll.js"></script>
<script type="text/javascript">
$(document).ready(function(){
        $("#scrollDiv").Scroll({line:1,speed:500,timer:5000,up:"but_down"});
});
</script>
</body>
</html>
