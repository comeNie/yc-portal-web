<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>关于我们</title>
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
            <li class="word">全新译云平台 这只是一个开始</li>
            <li class="pacbtn"><input id="trans-btn" type="button" class="btn btn-blue btn-168 radius20" value="体验即时翻译"></li>
        </ul>
    </div>
</div>
<div class="static-wrapper">
    <!--标题-->
    <div class="static-title">
        <p>关于我们</p>
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
    <div class="contact">
        <div class="contact-main">
            <div class="static-title">
                <p>联系我们</p>
                <p class="line1"></p>
            </div>
            <div class="contact-list">
                <ul>
                    <li>公司位置：北京市石景山区石景山路20号中铁建设大厦16层</li>
                    <li>联系电话：+86 10 5322 3600</li>
                    <li>
                        <p class="icon1"><a href="#"></a></p>
                        <p class="icon2"><a href="#"></a></p>
                    </li>
                </ul>
            </div>
        </div>

    </div>

    <!--服务特色-->
    <div class="service">
        <div class="service-main">
            <div class="static-title">
                <p>服务特色</p>
                <p class="line1"></p>
            </div>
            <div class="service-list">
                <ul>
                    <li class="img1">
                        <p>
                            <span class="title">极致的速度</span>
                            <span>自动化流程</span>
                            <span>国家级专业翻译</span>
                            <span>译审同步</span>
                        </p>
                    </li>
                    <li class="img2"><p>放心的质量</p></li>
                    <li class="img3"><p>全面的服务</p></li>
                    <li class="img4"><p>一流的品质</p></li>
                </ul>
            </div>


        </div>
    </div>
    <!--服务特色-->
    <div class="guarantee">
        <div class="guarantee-main">
            <div class="static-title">
                <p>服务保障</p>
                <p class="line1"></p>
            </div>
            <div class="guarantee-list">
                <ul>
                    <li>
                        <p class="img1"></p>
                        <p>亿万量级语料支持</p>
                    </li>
                    <li>
                        <p class="img2"></p>
                        <p>全球优质翻译资源</p>
                    </li>
                    <li>
                        <p class="img3"></p>
                        <p>专业排版优化设计</p>
                    </li>
                    <li>
                        <p class="img4"></p>
                        <p>免费修改服务保障</p>
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
    $("#trans-btn").click(function () {
        window.location.href = "${_base}/";
    });
</script>
</body>
</html>
