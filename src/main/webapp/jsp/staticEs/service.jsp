<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>Service</title>
	<%--相关CSS--%>
	<%@include file="/inc/inc.jsp" %>
</head>
<body class="static-body">
<!--面包屑导航-->
<%@include file="/inc/topHead.jsp" %>
<!--主导航-->
<%@include file="/inc/topMenu.jsp" %>

<!--主体-->
<div class="clothes-banner">
	<div class="clothes-list">
		<ul>
			<li class="word">What is YeeCloud?</li>
			<li>Global Tone Communication Technology has launched a professional translation platform where quality LSP and translators worldwide gather to provide customers with accurate and cost-effective language services. With 40 years of accumulated language resources and language service management experience and the computing power of big data, YeeCloud can meet the need of each and every client.</li>
			<li class="pacbtn"><input id="order-btn"  type="button" class="btn btn-blue btn-230 radius20" value="Release translation task"></li>
		</ul>
	</div>
</div>
<!--服务特色-->
<div class="provide">
	<div class="provide-main">
		<div class="static-title">
			<p>What services can YeeCloud provide</p>
			<p class="line1"></p>
		</div>
		<div class="provide-list">
			<ul>
				<li>
					<p class="img5"></p>
					<p>Different types of translation and interpretation services in various languages</p>
				</li>
				<li>
					<p class="img6"></p>
					<p>Thousands of excellent translators and interpreters from all over the world </p>
				</li>
				<li>
					<p class="img7"></p>
					<p>Mass online orders, fully guaranteed transactions, and a free corpus and toolkit</p>
				</li>
				<li>
					<p class="img8"></p>
					<p>From individual translations for personal use to services for enterprises, YeeCloud can satisfy all your language needs</p>
				</li>
			</ul>
		</div>
	</div>
</div>
<!--服务特色-->
<div class="service">
	<div class="service-main">
		<div class="static-title">
			<p>Why you should choose YeeCloud?</p>
			<p class="line1"></p>
		</div>
		<div class="why-list">
			<ul>
				<li>
					<p class="bj">The only designated translation and publishing service supplier for the United Nations and a national-level language service provider</p>
					<p class="img1"></p>
				</li>
				<li>
					<p class="img2"></p>
					<p class="bj">40 years of accumulated professional corpus resources,to meet your individual needs</p>
				</li>
				<li>
					<p class="bj">Excellent translation service resources from around the globe</p>
					<p class="img3"></p>
				</li>
				<li>
					<p class="img4"></p>
					<p class="bj">Each translation is reviewed many times. Changes to translation will be provided free of charge</p>
				</li>
				<li>
					<p class="bj">Multiple languages/industries are covered to meet your diverse needs</p>
					<p class="img5"></p>
				</li>
			</ul>
		</div>
	</div>
</div>
<!--服务特色-->
<div class="service">
	<div class="service-main">
		<div class="static-title">
			<p>How YeeCloud guarantees transactional security?</p>
			<p class="line1"></p>
		</div>
		<div class="how-list">
			<ul>
				<li class="img1"></li>
				<li class="word">
					<p>It provides an online payment and guarantee service based on a third-party payment platform</p>
					<p>Bank-level data encryption technology guarantees the safety of capital and data in all aspects</p>
					<p>All information is kept strictly confidential to ensure the information security of clients</p>
				</li>
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
