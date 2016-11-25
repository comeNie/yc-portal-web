<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <%--关于我们--%>
    <title>About Us</title>
    <%--相关CSS--%>
    <%@include file="/inc/inc.jsp" %>
</head>
<body class="static-body">
<!--面包屑导航-->
<%@include file="/inc/topHead.jsp" %>
<!--主导航-->
<%@include file="/inc/topMenu.jsp" %>
<!--主体-->
<div class="about-banner">
    <div class="about-list">
        <ul>
            <li class="word">A new yiyun platform this is just a start</li>
            <%--体验即时翻译 --%>
            <li class="pacbtn"><input type="button" class="btn btn-blue btn-168 radius20" value="Experience instant translation"></li>
        </ul>
    </div>
</div>
<div class="static-wrapper">
    <!--标题-->
    <div class="static-title">
        <!-- 译者认证 -->
        <p>Translator certification</p>
        <p class="line1"></p>
    </div>

</div>
<!--底部-->
<%@include file="/inc/indexFoot.jsp" %>

<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/jqueryrotate.2.3.js"></script>
</body>
</html>
