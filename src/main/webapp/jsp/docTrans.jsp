<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<c:set var="_base" value="${pageContext.request.contextPath}"/>
<c:set var="rootRes" value="${_base}/resources"/>
<c:set var="spmRes" value="${_base}/resources/spm_modules"/>
<c:set var="uedroot" value="${pageContext.request.contextPath}/resources/template"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<%--文档翻译--%>
    <title><spring:message code="doc.trans.view.title"/></title>
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="icon" href="${uedroot}/images/icon32.ico" type="image/x-icon" />
	<link rel="shortcut icon" href="${uedroot}/images/icon32.ico" type="image/x-icon" />
    <link href="${uedroot}/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="${uedroot}/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="${uedroot}/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="${uedroot}/css/modular/headr-footer.css" rel="stylesheet" type="text/css"/>
    <link href="${uedroot}/css/modular/index.css" rel="stylesheet" type="text/css"/>
	<%@ include file="/inc/incJs.jsp" %>
</head>

<body class="homebody">
	<!--面包屑导航-->
	<%@ include file="/inc/topHead.jsp" %>
	<%--图片版本--%>
	<c:set var="lTag"><%= !Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())?"_en":""%></c:set>
	<!--banner-->
	<div class="banner"></div>
	<!--index nav-->
	<div class="index-nav">
		<ul>
			<li><img src="${uedroot}/images/index-logo${lTag}.png" /></li>
			<li class="right">
				<!-- 首页 -->
				<p><a href="${_base}/" ><spring:message code="home.nav.bar.home"/></a></p>
				<%--笔译--%>
				<p><a href="${_base}/written"><spring:message code="home.nav.bar.written"/></a></p>
				<%--口译--%>
				<p><a href="${_base}/oral"><spring:message code="home.nav.bar.oral"/></a></p>
				<%--服务--%>
				<p><a href="${_base}/service"><spring:message code="home.nav.bar.services"/></a></p>
				<%--APP--%>
				<p><a href="${_base}/findyee"><spring:message code="home.nav.bar.app"/></a></p>
			</li>
		</ul>
	</div>
	<div class="translate-box">
		<div class="trans-part">
			<div class="trans-title">
				<div class="pull-left"><spring:message code="doc.trans.source.title"/></div>
			</div>
			<div class="transed-box">
          <textarea name="" id="" class="form-control">译云是中译语通科技（北京）有限公司基于语言大数据和云计算技术的智慧语言服务综合平台，透过译云商业平台、译库工具平台及译云社区互动平台等全方位的语言服务平台作为入口，译云在电话端、PC互联网、移动互联网端都能高效地为商业用户、专业译者和语言服务商提供一体化智能语言服务[1]  。
  “译云”是新一代语言服务智慧应用平台，代表着语言服务业未来发展的趋势，为中华文化走出去项目的实施、提升中华文化国际传播能力提供了以现代技术为支撑的便捷工具平台。译云是中译语通科技（北京）有限公司基于语言大数据和云计算技术的智慧语言服务综合平台，透过译云商业平台、译库工具平台及译云社区互动平台等全方位的语言服务平台作为入口，译云在电话端、PC互联网、移动互联网端都能高效地为商业用户、专业译者和语言服务商提供一体化智能语言服务[1]  。
  “译云”是新一代语言服务智慧应用平台，代表着语言服务业未来发展的趋势，为中华文化走出去项目的实施、提升中华文化国际传播能力提供了以现代技术为支撑的便捷工具平台。</textarea>
			</div>
		</div>
		<div class="trans-part">
			<div class="trans-title">
				<div class="pull-left"><spring:message code="doc.trans.translation.title"/></div>
				<div class="pull-right">
					<span><spring:message code="doc.trans.down.title"/>:</span>
					<button class="btn btn-line" id="downDoc">doc</button>
					<button class="btn btn-line" id="downTxt">txt</button>
				</div>
			</div>
			<div class="transed-box">
				The annual Symposium on Principles of Programming Languages is a forum for the discussion of all aspects
				of programming languages and programming systems. Both theoretical and experimental papers are welcome,
				on topics ranging from formal frameworks to experience reports. Papers discussing new ideas and new
				areas are encouraged, as are papers (often called “pearls”) that elucidate existing concepts in ways
				that yield new insights. We are looking for any submission with the potential to make enduring
				contributions to the theory, design, implementation or application of programming languages.The annual
				Symposium on Principles of Programming Languages is a forum for the discussion of all aspects of
				programming languages and programming systems. Both theoretical and experimental papers are welcome, on
				topics ranging from formal frameworks to experience reports. Papers discussing new ideas and new areas
				are encouraged, as are papers (often called “pearls”) that elucidate existing concepts in ways that
				yield new insights. We are looking for any submission with the potential to make enduring contributions
				to the theory, design, implementation or application of programming languages.
			</div>
		</div>
	</div>
	<%--加载更多--%>
    <p class="show-more" id="loadMore"><spring:message code="doc.trans.load.more"/></p>

	<!--底部-->
	<%@include file="/inc/indexFoot.jsp"%>

</body>
<script src="${_base}/resources/spm_modules/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/drop-down.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/index.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/digital-scroll.js"></script>
<script type="text/javascript">
    var pager;
    (function () {
        seajs.use('app/jsp/docTrans', function(docTrans) {
            pager = new docTrans({element : document.body});
            pager.render();
        });
    })();
</script>
</html>
