<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>常见问题</title>
<%@include file="/inc/inc.jsp" %>
</head>
<body class="agreement-body">
<!--面包屑导航-->
<%@include file="/inc/topHead.jsp" %>
<!--主导航-->
<%@include file="/inc/topMenu.jsp" %>
<!--主体-->
<div class="agreement-wrapper-big">
<div class="agreement-wrapper">
<div class="subnav-left">
    <ul>
        <%--翻译服务问题--%>
        <li><a href="javascript:" class="current">Translation service issues</a></li>
            <%--支付问题--%>
        <li><a href="javascript:">Payments problems</a></li>
            <%--账户问题--%>
        <li><a href="javascript:">Account problem</a></li>
            <%--售后服务--%>
        <li><a href="javascript:">After - sales service</a></li>
            <%--发票问题--%>
        <!--<li><a href="javascript:">Invoices problems</a></li>
        <%--积分说明--%>
        <li><a href="javascript:">Integral descriptions</a></li>
        <%--客户等级--%>
        <li><a href="javascript:">The customer hierarchy</a></li>-->
            <%--译员等级--%>
        <li><a href="javascript:">Level translator</a></li>
    </ul>
</div>
<div class="agreement-right">
    <div id="tab-xy1">
        <div class="agreement-word">
            <ul>
                <li>
                    <%--1.译云专业翻译提供哪些语种的服务？--%>
                    <p class="blue">1.What languages are provided by YeeCloud?</p>
                    <p>Currently, we provide translation services between Chinese and English, Chinese and French, Chinese and Russian, Chinese and Spanish, Chinese and Japanese as well as Chinese and Korean. If you have translation needs of other languages, please call 400-119-8080 for more information.</p>
                </li>
                <li>
                    <%--2.短文翻译、文档翻译、创意翻译和证件翻译的区别在哪里？--%>
                    <p class="blue">2.What kinds of language services are provided by YeeCloud?</p>
                        <%--目前提供笔译和口译两种翻译服务。笔译翻译：用途包括不限、起名标语、专业论文、简历简介、产品说明、合同标书、留学移民、证书证件、出版书籍、视频字幕、其他。口译翻译：国家级口译服务，提供陪同翻译、交替传译、同声传译等服务。为了更好的为您服务，建议提前三个工作日以上进行申请；提供中英、中俄、中法、中西、中日、中韩间的互译。--%>
                    <p>Currently, we provide two kinds of language services, namely translation and interpretation. Translation: purposes include but not limited to names and slogans, professional papers, resumes and profiles, product descriptions, contracts and tenders, foreign study and immigration materials, certificates and credentials, publications and books, video subtitles and so on. Interpretation: We provide escort interpretation, consecutive interpretation and simultaneous interpretation services of national level. To better meet your needs, please apply for the service three days in advance. We provide translations between Chinese and English, Chinese and Russian, Chinese and French, Chinese and Spanish, Chinese and Japanese as well as Chinese and Korean.</p>
                </li>
                <li>
                    <%--3.翻译需要多长时间？--%>
                    <p class="blue">3.How long does it take to complete the translation?</p>
                </li>
                <li>
                    <table  class="table table-border table-bg  table-bordered  table-height65">
                        <tr class="bj">
                            <th>Translation level</th>
                            <th>Number of words</th>
                            <th>Translation time</th>
                        </tr>
                        <tr>
                            <td rowspan="2">Normal</td>
                            <td>≤1000 words</td>
                            <td>2 hours</td>
                        </tr>
                        <tr>
                            <td>for every 1,000 words increased</td>
                            <td>Additional 2 hours</td>
                        </tr>
                        <tr>
                            <td rowspan="2">≤1000 words</td>
                            <td>≤1000字</td>
                            <td>3 hours</td>
                        </tr>
                        <tr>
                            <td>for every 1,000 words increased</td>
                            <td>Additional 3 hours</td>
                        </tr>
                        <tr>
                            <td rowspan="2">Publishing</td>
                            <td>≤1000 words/td>
                            <td>4 hours</td>
                        </tr>
                        <tr>
                            <td>for every 1,000 words increased</td>
                            <td>Additional 4 hours</td>
                        </tr>
                    </table>
                </li>
                <li>
                    <%--4.翻译字数如何统计？--%>
                    <p class="blue">4.How to count the words for translation?</p>
                    <p>If the original text is in Chinese, use the number of characters showing in MS Word (without counting spaces) for price calculation. The number of characters in header, footer, text box and picture shall be counted separately; if the original text is in foreign language, the count of foreign words will be taken in price calculation.<p>
                </li>
                <li>
                    <%--5.如何付款？--%>
                    <p class="blue">5.How to complete payment?</p>
                    <p>You may complete the payment online via account balance, Alipay, China UnionPay or Paypal, the platform will provide guarantees for the two transaction sides. After you have received the translation and are satisfied with the service, the platform will transfer the money to the receiving side. <p>
                </li>
                <li>
                    <%--6.对翻译结果不满意怎么办？--%>
                    <p class="blue">6.What to do if you are not satisfied with the translation result?</p>
                    <p>After receiving the translation, if you are not satisfied, you may apply for modification, we will provide free revision services.<p>
                </li>
                <li>
                    <%--7.如何索要发票？--%>
                    <p class="blue">7.How to claim invoice?</p>
                    <p>In case you want the invoice, you can apply for issuing of invoice in the invoice management section. <p>
                </li>
                <li>
                    <%--8.如何联系客服？--%>
                    <p class="blue">8.How to contact customer service?</p>
                    <p>If you have other questions, please contact our online customer service or call 400-119-8080.</p>
                </li>
            </ul>
        </div>
    </div>
    <div id="tab-xy2" style="display: none;">
        <div class="agreement-word">
            <ul>
                <%--您可以选择账户余额，支付宝，中国银联，Pappal完成在线支付，由平台为交易双方提供支付担保，在您收到译文且满意后，才正式付款--%>
                <li>You may complete the payment online via account balance, Alipay, China UnionPay or Paypal, the platform will provide guarantees for the two transaction sides. After you have received the translation and are satisfied with the service, the platform will transfer the money to the receiving side. </li>
            </ul>
        </div>
    </div>
    <div id="tab-xy3" style="display: none;">
        <div class="agreement-word">
            <ul>
                <li>
                    <%--1.忘记密码如何找回--%>
                    <p class="blue">1.How to retrieve password </p>
                    <p>You may retrieve the password through the email or phone number that are linked to your account.</p>
                </li>
                <li>
                    <%--2.资金账户说明--%>
                    <p class="blue">2.Instructions for capital account </p>
                    <p>Capital account can be used to trace the capital sources and purposes, it can be recharged, after charging, the balance can be used for order payment and cash withdrawal.</p>
                </li>
                <li>
                    <%--3.账户资料保密机制--%>
                    <p class="blue">3.Security mechanism for account information</p>
                    <p>We are fully aware of the importance of your information, your data may concern marketing strategy, development orientation and even the success of an enterprise, or involve your personal privacy. YeeCloud has established strict confidential regulations that integrates both technology and law, we implement strict confidential measures for all the information delivered to us, and keep all the files received from clients properly.  </p>
                </li>
            </ul>
        </div>
    </div>
    <div id="tab-xy4" style="display: none;">
        <div class="agreement-word">
            <ul>
                <li>
                    <%--译云平台特色服务--%>
                    <p class="blue">Features of YeeCloud platform service include:</p>
                </li>
                <li>1.The platform guarantees the trading and ensures the service quality, clients can claim if they are not satisfied with the service.</li>
                <li>2.YeeCloud has established strict confidential regulations that integrates both technology and law, we implement strict confidential measures for all the information delivered to clients, and keep all the files received from clients properly.</li>
                <li>3.The platform gathers translators from worldwide, who are ready to respond to clients’ requirements immediately.</li>
                <li>4.With the support of the corpus which contains hundreds of millions of entries, translators can meet clients’ needs better.</li>
                <li>5.Translators are able to create and manage their own language assets.</li>
                <li>6.YeeCloud provides open API interfaces, realizing real-time content interaction between the platform and the third-party system.</li>
            </ul>
        </div>
    </div>
    <!--<div id="tab-xy5" style="display: none;">
        <div class="agreement-word">
            <ul>
                <li>发票问题</li>
            </ul>
        </div>
    </div>
    <div id="tab-xy6" style="display: none;">
        <div class="agreement-word">
            <ul>
                <li>积分说明</li>
            </ul>
        </div>
    </div>
    <div id="tab-xy7" style="display: none;">
        <div class="agreement-word">
            <ul>
                <li>客户等级</li>
            </ul>
        </div>
    </div>-->
    <div id="tab-xy5" style="display: none;">
        <div class="agreement-word">
            <ul>
                <li>
                    <%--1.译员级别说明：--%>
                    <p class="blue">1.Explanation of translators’ level:</p>
                    <p>Translators’ operation on the platform will create contribution values, which are seen as measurement of a translator’s degree of participation; when a translator’s contribution values reach certain extent, his level will be promoted, and he will be able to claim more advanced tasks. Currently, translators are divided into three levels: first level translator, second level translator, and third level translator.</p>
                </li>
                <li>
                    <%--2.怎样增加贡献值，提升议员级别？--%>
                    <p class="blue">2.How to increase contribution value and enhance translator’s level?</p>
                </li>
                <li>
                    <table  class="table table-border table-bg  table-bordered  table-height65">
                        <tr class="bj">
                            <th>Activity</th>
                            <th>Contribution value</th>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Get a language certificate</td>
                            <td>+500</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Upload qualification certificate</td>
                            <td>+50</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Personal profile</td>
                            <td>+50</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Fill in work experience</td>
                            <td>+50</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Fill in education background</td>
                            <td>+50</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Submit orders before delivering translation</td>
                            <td>+(Actual order amount X100)X2%</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Number of order accepted≥3/month, with the average unit price≥100/td>
                            <td>+200</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Number of order accepted≥3/month, with the average unit price≤99</td>
                            <td>+50</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Translator gets additional 10% points if a translation task is completed between 9 p.m. to 8 a.m. of the next day (within deadline of the order)</td>
                            <td>+(Actual order amount X100)X12%</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Translation evaluated as good</td>
                            <td>+400</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Translation evaluated as fair </td>
                            <td>+100</td>
                        </tr>
                        <tr>
                            <td class="text-l" style="padding-left:100px;">Translation evaluated as poor</td>
                            <td>-500</td>
                        </tr>
                    </table>
                </li>
            </ul>
        </div>
    </div>

</div>

</div>
</div>
<a href="#0" class="cd-top"><i class="icon-angle-down"></i></a>
<!--底部-->
<%@include file="/inc/indexFoot.jsp" %>

<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/script.js"></script>
</body>
</html>
