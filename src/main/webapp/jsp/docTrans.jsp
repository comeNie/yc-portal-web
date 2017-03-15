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
				<p><a href="${_base}/" class="current"><spring:message code="home.nav.bar.home"/></a></p>
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
		<div class="translate-title nofloat">
			<div class="pull-left"><span><spring:message code="doc.trans.source.title"/></span></div>
			<div class="pull-right">
				<span class="pull-left text-left"><spring:message code="doc.trans.translation.title"/></span>
				<span><spring:message code="doc.trans.down.title"/>:</span>
				<button class="btn btn-line" id="downDoc">doc</button>
				<button class="btn btn-line" id="downTxt">txt</button>
			</div>
		</div>
		<div class="translate-table-wrap">
			<table class="translate-table">
				<tbody>
				<%--从session取出翻译结果 docTrans--%>
				<c:forEach var="transInfo" items="${docTrans}">
					<tr>
						<td>${transInfo.sourceText}</td>
						<td>${transInfo.translation}</td>
					</tr>
				</c:forEach>
				</tbody>
			</table>
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
