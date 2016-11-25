<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>合作客户</title>
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
		<div class="cooperation-title">他们这样评价译云</div>
		<div class="cooperation-list" id="scrollDiv">
			<ul>
				<li class="img-icon"><img src="${uedroot}/images/Jinshan-icon1.png" /></li>
				<li class="word">
					<p class="bigword">金山词霸：</p>
					<p>现在用户翻译的需求越来越多样化，对质量要求越来越高，简单的机器翻译已经不能满足用户的需求，在这里我们推荐译云的人工翻译服务。它向用户提供了全球上万名译员在线t的人工翻译服务，快速且优质的翻译服务让用户感到惊喜，在这里我们真诚的向您推荐译云翻译。</p>
				</li>
			</ul>
			<ul>
				<li class="img-icon"><img src="${uedroot}/images/Jinshan-icon1.png" /></li>
				<li class="word">
					<p class="bigword">金山词霸：</p>
					<p>现在用户翻译的需求越来越多样化，对质量要求越来越高，简单的机器翻译已经不能满足用户的需求，在这里我们推荐译云的人工翻译服务。它向用户提供了全球上万名译员在线t的人工翻译服务，快速且优质的翻译服务让用户感到惊喜，在这里我们真诚的向您推荐译云翻译。</p>
				</li>
			</ul>
		</div>
		<div class="cooperation-icon"><a href="javaScript:void(0);" id="but_up"><img src="${uedroot}/images/cooper-icon.png" /></a></div>
	</div>
</div>
<div class="static-wrapper">
	<!--标题-->
	<div class="static-title">
		<p>更多客户</p>
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
        $("#scrollDiv").Scroll({line:1,speed:500,timer:5000,up:"but_up"});
});
</script>
</body>
</html>
