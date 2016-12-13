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
            <li class="word">a new YeeCloud, this is just a start</li>
            <%--体验即时翻译 --%>
            <li class="pacbtn"><input  id="trans-btn" type="button" class="btn btn-blue btn-168 radius20" value="Instant translation"></li>
        </ul>
    </div>
</div>
<div class="static-wrapper">
    <!--标题-->
    <div class="static-title">
        <!-- 关于我们 -->
        <p>About Us</p>
        <p class="line1"></p>
    </div>
    <div class="about-enterprise">
        <ul>
            <%--中译语通科技（北京）有限公司是中国对外翻译出版有限公司（经国务院批准成立的国家级翻译出版机构）的控股子公司，致力于以先进大数据技术和互联网为用户提供更全面、更便捷、更具性价比的翻译服务和专业翻译平台。--%>
            <li class="word">Global Tone Communication Technology Co., Ltd., a holding subsidiary of China Translation and Publishing Corporation (a state-level translation and publication agency established under the approval of the State Council), is committed to providing users with a platform of more comprehensive and more convenient, more cost-effective translation services and professional translation through advanced Big Data technology and the Internet. </li>
            <li class="img">
                <p><img src="${uedroot}/images/about1.png"></p>
                <p><img src="${uedroot}/images/about2.png"></p>
            </li>
                <%--中译语通传承中国对外翻译出版有限公司40年的优秀服务品质和海量语料资源，整合中国出版集团及其下属人民文学出版社、商务印书馆、中华书局等14家子公司以及81家相关公司的优质语言资源，将世界领先的创新科技引入语言服务领域。--%>
            <li class="word">Global Tone Communication Technology Co., Ltd. has inherited 40 years of excellent service quality and massive corpus resources from China Translation and Publishing Corporation, integrated the quality language resources of CTPC and its subordinates, including People's Literature Publishing House, the Commercial Press, Zhonghua Book Company and other 14 subsidiaries and 81 associated companies, and introduced the world's leading innovative technology into the language services field.</li>
            <%--曾先后服务于北京奥运会、上海世博会、南京亚青会等多个国家级赛事，是中国境内唯一为联合国提供翻译和出版服务的指定供应商，国家级语言服务提供商。--%>
            <li class="word">GTC has served a number of state-level games and events, including Beijing Olympic Games, Shanghai World Expo, Nanjing Asian Youth Games. It is China’s only designated language service provider of translation and publishing for the United Nations.</li>
            <li class="milepost">
                <%--2015年 译云beta 1.0 正式上线--%>
                <p class="number1">2015 YeeCloud beta 1.0 officially launched</p>
                    <%--2016年 用户突破2万--%>
                <p class="number2">2016 users breakthrough 2 million</p>
                    <%--2016年12月 全新译云上线--%>
                <p class="number3">2016 launch new cloud translation</p>
            </li>
        </ul>
    </div>

    <div class="contact">
        <div class="contact-main">
            <div class="static-title">
                <%--联系我们--%>
                <p>About Us</p>
                <p class="line1"></p>
            </div>
            <div class="contact-list">
                <ul>
                    <%--公司位置：北京市石景山区石景山路20号中铁建设大厦16层--%>
                    <li>F/16, China Railway Construction Building, No. 20 Shijingshan Road, Shijingshan District, Beijing</li>
                    <%--联系电话--%>
                    <li>Contact number;：+86 10 5322 3600</li>
                    <li>
                        <p class="icon1"><a href="javaScrpt:void(0);"></a></p>
                        <p class="icon2"><a href="javaScrpt:void(0);"></a></p>
                    </li>
                </ul>
            </div>
        </div>

    </div>

    <!--服务特色-->
    <div class="service">
        <div class="service-main">
            <div class="static-title">
                <p>Service Features</p>
                <p class="line1"></p>
            </div>
            <div class="service-list">
                <ul>
                    <li class="img1">
                        <p>
                            <span class="title">Super speed</span>
                            <span>Automation process</span>
                            <span>State-level professional translation</span>
                            <span>Synchronized operation of translation and proofreading</span>
                        </p>
                    </li>
                    <li class="img2"><p>Guaranteed quality</p></li>
                    <li class="img3"><p>Comprehensive service</p></li>
                    <li class="img4"><p>First-class quality</p></li>
                </ul>
            </div>


        </div>
    </div>
    <!--服务特色-->
    <div class="guarantee">
        <div class="guarantee-main">
            <div class="static-title">
                <p>Service Guarantee</p>
                <p class="line1"></p>
            </div>
            <div class="guarantee-list">
                <ul>
                    <li>
                        <p class="img1"></p>
                        <p>Hundreds of millions of corpus entries</p>
                    </li>
                    <li>
                        <p class="img2"></p>
                        <p>Global quality translation resources</p>
                    </li>
                    <li>
                        <p class="img3"></p>
                        <p>Professional DTP optimization design</p>
                    </li>
                    <li>
                        <p class="img4"></p>
                        <p>Free translation changes</p>
                    </li>
                </ul>
            </div>
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
