<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>服务</title>
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
			<li class="word">译云是什么？</li>
			<li>译云是中译语通科技（北京）有限公司推出的专业语言服务平台，汇聚世界各地的优质语言服务提供商和职业译员，为全球客户提供精准专业且具有性价比的语言服务。得益于中译语通40年积累的亿万量级专业语料资源、全流程的语言服务管理经验和强大的大数据计算能力，译云能够满足客户的每一个个性化需求。</li>
			<li class="pacbtn"><input id="order-btn" type="button" class="btn btn-blue btn-230 radius20" value="立即发布翻译任务"></li>
		</ul>
	</div>
</div>
<!--服务特色-->
<div class="provide">
	<div class="provide-main">
		<div class="static-title">
			<p>译云能提供什么服务？</p>
			<p class="line1"></p>
		</div>
		<div class="provide-list">
			<ul>
				<li>
					<p class="img5"></p>
					<p>提供各种类型的翻译服务<br>从笔译到同传<br>全方位满足您的翻译需求</p>
				</li>
				<li>
					<p class="img6"></p>
					<p>汇聚了数万全球各类优秀的翻译服务人才提供各语种的翻译服务</p>
				</li>
				<li>
					<p class="img7"></p>
					<p>海量在线订单，交易全程担保免费语料工具，这里就是译员的家</p>
				</li>
				<li>
					<p class="img8"></p>
					<p>从个人翻译到企业服务可以满足您所有的个性化需求</p>
				</li>
			</ul>
		</div>
	</div>
</div>
<!--服务特色-->
<div class="service">
	<div class="service-main">
		<div class="static-title">
			<p>为什么选择译云平台？</p>
			<p class="line1"></p>
		</div>
		<div class="why-list">
			<ul>
				<li>
					<p class="bj">唯一为联合国提供翻译和出版服务的指定供应商，国家级的语言服务提供商</p>
					<p class="img1"></p>
				</li>
				<li>
					<p class="img2"></p>
					<p class="bj">40年积累的亿万量级专业语料资源，满足您的每一个个性化需求</p>
				</li>
				<li>
					<p class="bj">汇集全球的优质翻译服务资源</p>
					<p class="img3"></p>
				</li>
				<li>
					<p class="img4"></p>
					<p class="bj">译文多重审核，全方位保障翻译质量，不满意免费修改</p>
				</li>
				<li>
					<p class="bj">涵盖多语种，多行业，满足各种需求</p>
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
			<p>译云如何保障交易安全？</p>
			<p class="line1"></p>
		</div>
		<div class="how-list">
			<ul>
				<li class="img1"></li>
				<li class="word">
					<p>提供基于第三方支付平台的在线支付和担保服务，平台全程信用担保</p>
					<p>银行级数据加密技术，全方位保证资金和数据安全</p>
					<p>对所有信息实行严格保密，保证客户信息及文件的安全</p>
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
