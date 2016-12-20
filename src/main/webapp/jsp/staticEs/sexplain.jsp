<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>服务说明</title>
    <%@include file="/inc/inc.jsp" %>
</head>
<body>
<!--面包屑导航-->
<%@include file="/inc/topHead.jsp" %>
<!--主导航-->
<%@include file="/inc/topMenu.jsp" %>

<!--主体-->
<div class="agreement-wrapper-big">
    <div class="agreement-wrapper">
        <div class="subnav-left">
            <ul>
                <%--服务内容--%>
                <li><a href="javascript:" class="current">Service Content</a></li>
                    <%--服务时间--%>
                <li><a href="javascript:">Service Time</a></li>
                    <%--服务价格--%>
                <li><a href="javascript:">Service Price</a></li>
                    <%--付费方式--%>
                <li><a href="javascript:">Payment Methods</a></li>
                    <%--售后服务--%>
                <li><a href="javascript:">After-sales Service</a></li>
                    <%--保密机制--%>
                <li><a href="javascript:">Confidentiality</a></li>
            </ul>
        </div>
        <div class="agreement-right">
            <div id="tab-xy1">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <%--快速翻译--%>
                            <p class="blue">Quick translation</p>
                            <p>Currently, we provide two kinds of language services, namely translation and interpretation. Translation: purposes include but not limited to names and slogans, professional papers, resumes and profiles, product descriptions, contracts and tenders, foreign study and immigration materials, certificates and credentials, publications and books, video subtitles and so on. Interpretation: We provide escort interpretation, consecutive interpretation and simultaneous interpretation services of national level. To better meet your needs, please apply for the service three days in advance. We provide translations between Chinese and English, Chinese and Russian, Chinese and French, Chinese and Spanish, Chinese and Japanese as well as Chinese and Korean.</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="tab-xy2" style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <%--笔译--%>
                            <p class="blue">Written translation</p>
                                <%--周一至周五09:00-18:00 (重大节假日除外)，非工作时间提交的订单将顺延至工作时间处理。--%>
                            <p>Working hours are from 09:00-18:00, Monday to Friday (excluding major holidays and festivals). Orders submitted on non-working days will be processed during the next working days.</p>
                        </li>
                        <li>
                            <%--口译--%>
                            <p class="blue">Interpretation</p>
                                <%--周一至周五09:00-18:00 (重大节假日除外)，非工作时间提交的订单将顺延至工作时间处理，建议提前三个工作日以上进行申请。--%>
                            <p>Working hours are from 09:00-18:00, Monday to Friday (excluding major holidays and festivals). Orders submitted on non-working days will be processed during the next working days. It is advisable to submit your request at least three working days in advance.</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="tab-xy3"  style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <%--笔译--%>
                            <p class="blue">Written translation</p>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <%--语言--%>
                                    <th>language</th>
                                        <%-->普通级别<br>(千字/元)--%>
                                    <th>Standard<br>(1,000 characters/CNY)</th>
                                    <th>Professional<br>(1,000 characters/CNY)</th>
                                    <th>Publishing<br>(1,000 characters/CNY)</th>
                                        <%--语言/等级--%>
                                    <th>language/level</th>
                                    <th>Standard<br>(1,000 characters/CNY)</th>
                                    <th>Professional<br>(1,000 characters/CNY)</th>
                                    <th>Publishing<br>(1,000 characters/CNY)</th>
                                </tr>
                                <tr>
                                    <td>Chinese→English</td>
                                    <td>150</td>
                                    <td>280</td>
                                    <td>450</td>
                                    <td>English→Chinese</td>
                                    <td>220</td>
                                    <td>360</td>
                                    <td>800</td>
                                </tr>
                                <tr>
                                    <td>Chinese→French</td>
                                    <td>240</td>
                                    <td>300</td>
                                    <td>500</td>
                                    <td>French→Chinese</td>
                                    <td>350</td>
                                    <td>420</td>
                                    <td>640</td>
                                </tr>
                                <tr>
                                    <td>Chinese→Russian</td>
                                    <td>240</td>
                                    <td>300</td>
                                    <td>500</td>
                                    <td>Russian→Chinese</td>
                                    <td>350</td>
                                    <td>420</td>
                                    <td>640</td>
                                </tr>
                                <tr>
                                    <td>Chinese→Spanish</td>
                                    <td>280</td>
                                    <td>380</td>
                                    <td>650</td>
                                    <td>Spanish→Chinese</td>
                                    <td>400</td>
                                    <td>500</td>
                                    <td>700</td>
                                </tr>
                                <tr>
                                    <td>Chinese→Japanese</td>
                                    <td>240</td>
                                    <td>260</td>
                                    <td>500</td>
                                    <td>Japanese→Chinese</td>
                                    <td>240</td>
                                    <td>300</td>
                                    <td>500</td>
                                </tr>
                                <tr>
                                    <td>Chinese→Korean</td>
                                    <td>240</td>
                                    <td>300</td>
                                    <td>500</td>
                                    <td>Korean→Chinese</td>
                                    <td>240</td>
                                    <td>300</td>
                                    <td>500</td>
                                </tr>
                            </table>
                        </li>
                        <li class="mt-20">
                            <%--文档翻译，不足300字按照300字计算--%>
                            <p>Document translation，Any number of characters less than 300 will be charged as 300</p>
                            <%--原文是中文，按照word文档中字符数（不计空格）计算价格，页眉、页脚、文本框、图片另行统计计算--%>
                            <p>he price is calculated according to the number of characters (without spaces) in Word (characters in headers, footers, text boxes, and images will be calculated separately) when the source text is written in Chinese</p>
                            <%--原文是外文，按照外文单词数计算价格--%>
                            <p>the price is calculated according to the number of words when the source text is written in foreign languages.</p>
                                <%--翻译按照级别分为以下内容--%>
                            <p>translation in accordance with the levels are divided into the following</p>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <%--等级分类--%>
                                    <th>Classification</th>
                                        <%--适用范围--%>
                                    <th>Application scope</th>
                                        <%--译员配置--%>
                                    <th>Translator configuration/th>
                                        <%--售后服务--%>
                                    <th>After-sales service</th>
                                </tr>
                                <tr>
                                    <%--普通级别--%>
                                    <td>General level</td>
                                    <td>Personal reading and comprehension</td>
                                    <td>1-2 years experience, Translated words 1 million</td>
                                    <%--<td rowspan="3">翻译完成5天内，<br>可以申请译员免费<br>修改</td>--%>
                                    <td rowspan="3">Free translation changes <br>will be provided if an application <br>is submitted within five days <br>after the translation is completed</td>
                                </tr>
                                <tr>
                                    <%--专业级别--%>
                                    <td>Professional level</td>
                                    <td>Professional area or important occasion<br>that have high requirements for translators</td>
                                    <td>More than 3 years,Translated words 5 million,<br>Translator was assigned by field</td>
                                </tr>
                                <tr>
                                    <%--出版级别--%>
                                    <td>Publishing level</td>
                                    <td>Academic exchange and essay publication<br>that have high requirements for the background and fields of translators</td>
                                    <td>More than 5 years,Translated words 5 million<br>Rich book, paper published experience</td>
                                </tr>
                            </table>
                        </li>
                        <li class="mt-20">
                            <%--为了帮助您获得更好的服务体验，我们极力推荐您使用“专业级别”以上的翻译服务--%>
                            <p>For a better service experience,we highly recommend you to use our translation service at the professional level or above</p>
                        </li>
                        <li class="mt-20">
                            <%--口译--%>
                            <p class="blue">Interpretation</p>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <%--服务类别--%>
                                    <th width="13%">Service category</th>
                                        <%--服务项目--%>
                                    <th width="13%">Service item</th>
                                        <%--服务等级--%>
                                    <th width="13%">Service level</th>
                                        <%--服务价格--%>
                                    <th width="61%">Service price</th>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td style="padding:0;">
                                        <table class="table">
                                            <tr style="border:none">
                                                <%--A类语种--%>
                                                <td class="leftborder" colspan="2"  width="40%">Class-A language</td>
                                                <%--B类语种--%>
                                                <td colspan="3" width="60%">Class-B language</td>
                                            </tr>
                                            <tr>
                                                <%--英语--%>
                                                <td class="leftborder bottomborder"  width="20%">English</td>
                                                    <%--日语/韩语--%>
                                                <td class="bottomborder" width="20%">Japanese/Korean</td>
                                                    <%--俄语/法语/德语<--%>
                                                <td class="bottomborder" width="20%">Russian/French/German</td>
                                                    <%--西班牙语--%>
                                                <td class="bottomborder" width="20%">Spanish</td>
                                                    <%--葡萄牙语--%>
                                                <td class="bottomborder" width="20%">Portuguese</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <%--陪同翻译--%>
                                    <td style="padding: 0;">Escort interpretation</td>
                                        <%--短期陪同<br>（元/天）--%>
                                    <td style="padding: 0;">Short-term escort <br> (CNY/day)）</td>
                                    <td style="padding: 0;">
                                        <table class="table">
                                            <tr>
                                                <%--技术陪同--%>
                                                <td class="leftborder">Technological escort</td>
                                            </tr>
                                            <tr>
                                                <%--商务陪同--%>
                                                <td class="leftborder">Business escort</td>
                                            </tr>
                                            <tr>
                                                <%--生活陪同--%>
                                                <td class="bottomborder leftborder">Life escort</td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="padding: 0;">
                                        <table class="table">
                                            <tr>
                                                <td class="leftborder"  width="20%">1800</td>
                                                <td class="" width="20%">2200</td>
                                                <td class="" width="20%">2400</td>
                                                <td class="" width="20%">2600</td>
                                                <td class="" width="20%">3000</td>
                                            </tr>
                                            <tr>
                                                <td class=" leftborder"  width="20%">1600</td>
                                                <td class="" width="20%">1800</td>
                                                <td class="" width="20%">2000</td>
                                                <td class="" width="20%">2200</td>
                                                <td class="" width="20%">2500</td>
                                            </tr>
                                            <tr>
                                                <td class="bottomborder leftborder"  width="20%">1000</td>
                                                <td class="bottomborder" width="20%">1600</td>
                                                <td class="bottomborder" width="20%">1800</td>
                                                <td class="bottomborder" width="20%">2000</td>
                                                <td class="bottomborder" width="20%">2200</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <%--陪同翻译--%>
                                    <td style="padding: 0;">Escort interpretation</td>
                                    <td style="padding:0;" >
                                        <table class="table" width="100%">
                                            <tr>
                                                <%--同声传译<br>（元/天/人）--%>
                                                <td class="leftborder" >Simultaneous interpretation<br>(CNY/day/person)</td>
                                            </tr>
                                            <tr>
                                                <%--交替传译--%>
                                                <td class="leftborder bottomborder">Consecutive interpretation<br>(CNY/day/person)</td>
                                            </tr>

                                        </table>
                                    </td>
                                    <td style="padding: 0;">
                                        <table class="table">
                                            <tr>
                                                <%--技术陪同--%>
                                                <td class="leftborder">Technological escort </td>
                                            </tr>
                                            <tr>
                                                <%--商务陪同--%>
                                                <td class="leftborder">Business escort </td>
                                            </tr>
                                            <tr>
                                                <%--商务陪同--%>
                                                <td class="leftborder">Business escort </td>
                                            </tr>
                                            <tr>
                                                <%--生活陪同--%>
                                                <td class="bottomborder leftborder">Life escort </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="padding: 0;">
                                        <table class="table">
                                            <tr>
                                                <td class="leftborder"  width="20%">6000</td>
                                                <td class="" width="20%">8000</td>
                                                <td class="" width="20%">10000</td>
                                                <td class="" width="20%">12000</td>
                                                <td class="" width="20%">17000</td>
                                            </tr>
                                            <tr>
                                                <td class=" leftborder"  width="20%">8000</td>
                                                <td class="" width="20%">10000</td>
                                                <td class="" width="20%">12000</td>
                                                <td class="" width="20%">14000</td>
                                                <td class="" width="20%">20000</td>
                                            </tr>
                                            <tr>
                                                <td class=" leftborder"  width="20%">5000</td>
                                                <td class="" width="20%">6000</td>
                                                <td class="" width="20%">8000</td>
                                                <td class="" width="20%">9000</td>
                                                <td class="" width="20%">10000</td>
                                            </tr>
                                            <tr>
                                                <td class="bottomborder leftborder"  width="20%">6000</td>
                                                <td class="bottomborder" width="20%">7000</td>
                                                <td class="bottomborder" width="20%">10000</td>
                                                <td class="bottomborder" width="20%">11000</td>
                                                <td class="bottomborder" width="20%">15000</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="tab-xy4"  style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <span class="icon1"></span>
                            <span class="icon2"></span>
                            <span class="icon3"></span>
                        </li>

                    </ul>
                </div>
            </div>
            <div id="tab-xy5"  style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <p>1.The platform guarantees the trading and ensures the service quality, clients can claim if they are not satisfied with the service. </p>
                        </li>
                        <li>
                            <p>2.YeeCloud has established strict confidential regulations that integrates both technology and law, we implement strict confidential measures for all the information delivered to clients, and keep all the files received from clients properly.</p>
                        </li>
                        <li>
                            <p>3.The platform gathers translators from worldwide, who are ready to respond to clients’ requirements immediately. </p>
                        </li>
                        <li>
                            <p>4.With the support of the corpus which contains hundreds of millions of entries, translators can meet clients’ needs better.</p>
                        </li>
                        <li>
                            <p>5.Translators are able to create and manage their own language assets.</p>
                        </li>
                        <li>
                            <p>6.YeeCloud provides open API interfaces, realizing real-time content interaction between the platform and the third-party system.</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="tab-xy6" style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <%--我们深知您的资料的重要性，您的数据资料可能是关乎市场战略、企业发展，甚至是企业的成败，或者牵涉到您的个人隐私。译云建立了集技术与法律一体化的严格保密制度，对客户交付的所有资料，都实施严格的保密措施，妥善保管客户所交付的资料文件。--%>
                        <li>We are well aware of the importance of your information. Your data may relate to the marketing strategies, development, or even the success or failure of your enterprise, or may involve matters of your personal privacy. YeeCloud has set up a strict confidentiality system integrating technological and legal aspects, and will keep all information submitted by clients strictly confidential and properly store all related data.</li>
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
