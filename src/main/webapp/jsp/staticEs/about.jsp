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
            <li class="pacbtn"><input  id="trans-btn" type="button" class="btn btn-blue btn-168 radius20" value="Experience instant translation"></li>
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
    <div class="about-enterprise">
        <ul>
            <li class="word">中译语通科技（北京）有限公司是中国对外翻译出版有限公司（经国务院批准成立的国家级翻译出版机构）的控股子公司，致力于以先进大数据技术和互联网为用户提供更全面、更便捷、更具性价比的翻译服务和专业翻译平台。</li>
            <li class="img">
                <p><img src="${uedroot}/images/about1.png"></p>
                <p><img src="${uedroot}/images/about2.png"></p>
            </li>
            <li class="word">中译语通传承中国对外翻译出版有限公司40年的优秀服务品质和海量语料资源，整合中国出版集团及其下属人民文学出版社、商务印书馆、中华书局等14家子公司以及81家相关公司的优质语言资源，将世界领先的创新科技引入语言服务领域。</li>
            <li class="word">曾先后服务于北京奥运会、上海世博会、南京亚青会等多个国家级赛事，是中国境内唯一为联合国提供翻译和出版服务的指定供应商，国家级语言服务提供商。</li>
            <li class="milepost">
                <p class="number1">2015年 译云beta 1.0 正式上线</p>
                <p class="number2">2016年 用户突破2万</p>
                <p class="number3">2016年12月 全新译云上线</p>
            </li>
        </ul>
    </div>
</div>
<!--底部-->
<%@include file="/inc/indexFoot.jsp" %>

<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/jqueryrotate.2.3.js"></script>

<script type="text/javascript">
    $("#trans-btn").click(function () {
        window.location.href = "${_base}/";
    });
</script>
</body>
</html>
