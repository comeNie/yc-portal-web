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
                                <%--适用于短文本翻译服务，最快30分钟即可获得翻译结果。仅限2000字以内的翻译业务；支持中文同英、法、俄、西、日、韩间的互译。--%>
                            <p>Quick translation is available for short texts of less than 2,000 characters. You can receive your translation in as little as 30 minutes. Translation from Chinese to English, French, Russian, Spanish, Japanese, Korean, and vice versa is provided.</p>
                        </li>
                        <li>
                            <p class="blue">Creative translation</p>
                            <p>Your language needs regarding advertisements, names (brand names, company names, store names, and product names) and literary texts (lyrics and poetry) can be met by creative translation. After the translation is completed, we will provide an interpretation alongside the translation. Translation from Chinese to English, French, Russian, Spanish, Japanese, Korean, and vise versa is provided.</p>
                        </li>
                        <li>
                            <%--证件翻译--%>
                            <p class="blue">Credential translation</p>
                            <p>Credential translation provides you with professional translation services regarding various credentials, certificates, and other approval documents, including ID cards, passports, driving licenses, business licenses, diplomas, degree certificates, certificates of honor, and medical evidence. After the translation is completed, in addition to an electronic edition of your translation, you can also apply for a hard copy with our company stamp. Translation from Chinese to English, French, Russian, Spanish, Japanese, Korean, and vise versa is provided.</p>
                        </li>
                        <li>
                            <%--文档翻译--%>
                            <p class="blue">Document translation</p>
                            <p>Our document translation service is recommended if you need a long text translated. The documents to be submitted can be in the following formats: .doc, .docx, .txt, .paf, .ppt, .pptx, .xlsx, and others. Please contact us via telephone if the document needing translation is in the format of .jpg, .png, .tif, or similar formats, or has a size exceeding 20M. Translation from Chinese to English, French, Russian, Spanish, Japanese, Korean, and vise versa is provided.</p>
                        </li>
                        <li>
                            <%--简历翻译--%>
                            <p class="blue">Resume translation</p>
                            <p>You can enjoy a range of special services, including professional resume translation, translation review, and resume polishing by native speakers. Our many professional resume translators will provide guidance in your resume translation. Online translation is supported, and your resume can be automatically generated through a template.</p>
                        </li>
                        <li>
                            <%--口译--%>
                            <p class="blue">Interpretation</p>
                            <p>National-level interpretation services are provided, including escort interpretation, consecutive interpretation, and simultaneous interpretation. Please submit your request at least three working days in advance. Interpretation from Chinese to English, French, Russian, Spanish, Japanese, and Korean, is provided.</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div id="tab-xy2" style="display: none;">
                <div class="agreement-word">
                    <ul>
                        <li>
                            <%--快速翻译 | 创意翻译 | 证件翻译 | 文档翻译 | 简历翻译--%>
                            <p class="blue">Quick translation/Creative translation/Credential translation/Document translation/Resume translation</p>
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
                            <%--快速翻译--%>
                            <p class="blue">Quick translation</p>
                                <%--根据不同语种按字收费，提交订单时会提示预计完成时间--%>
                            <p>Translation of different languages will be charged by the number of characters/words, and the estimated time of completion will be provided when the order is submitted</p>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <%--语言--%>
                                    <th>language</th>
                                        <%--价格  元/字--%>
                                    <th>Price CNY/word</th>
                                    <th>language</th>
                                    <th>Price CNY/word</th>
                                    <th>language</th>
                                    <th>Price CNY/word</th>
                                    <th>language</th>
                                    <th>Price CNY/word</th>
                                </tr>
                                <tr>
                                    <%--中→英--%>
                                    <td>Chinese→English</td>
                                    <td>0.28</td>
                                    <td>English→Chinese</td>
                                    <td>0.4</td>
                                    <td>Chinese→Spanish</td>
                                    <td>0.6</td>
                                    <td>Spanish→Chinese</td>
                                    <td>0.6</td>
                                </tr>
                                <tr>
                                    <td>Chinese→French</td>
                                    <td>0.4</td>
                                    <td>French→Chinese</td>
                                    <td>0.6</td>
                                    <td>Chinese→Japanese</td>
                                    <td>0.4</td>
                                    <td>Japanese→Chinese</td>
                                    <td>0.4</td>
                                </tr>
                                <tr>
                                    <td>Chinese→Russian</td>
                                    <td>0.4</td>
                                    <td>Russian→Chinese</td>
                                    <td>0.6</td>
                                    <td>Chinese→Korean</td>
                                    <td>0.4</td>
                                    <td>Korean→Chinese</td>
                                    <td>0.4</td>
                                </tr>
                            </table>
                        </li>
                        <li class="mt-20">
                            <%--译员配置：专业级译员服务；实时待命，立等可取--%>
                            <p>Translator configuration： instant translation services will be provided by professional translators who are on standby</p>
                            <%--售后服务：翻译完成48小时内，不满意可以申请译员免费修改--%>
                            <p>After-sales service: if you are unsatisfied with your translation, you can apply for free changes to be done by your translator within 48 hours after translation completion</p>
                        </li>
                        <li>
                            <%--创意翻译--%>
                            <p class="blue">Creative translation</p>
                                <%--每笔订单仅提供1条内容的翻译服务，采取按条收费，翻译完成后的译文字数需控制在50字以内；服务价格， 100元/条。--%>
                            <p>One item of translation is provided for each order, and the price will be charged by item. The number of words for translation shall not exceed 50. The service price is 100 yuan/item.</p>
                        </li>
                        <li>
                            <%--证件翻译--%>
                            <p class="blue">Credential translation</p>
                                <%--每笔订单仅提供1份证件的翻译服务，采取按份收费；服务价格，200元/份。--%>
                            <p>Translation for one credential is provided for each order, and is charged per copy. The service price is 200 yuan/copy.</p>
                        </li>
                        <li>
                            <%--文档翻译--%>
                            <p class="blue">Document translation</p>
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
                        <li>
                            <%--简历翻译--%>
                            <p class="blue">Resume translation</p>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <%--等级分类--%>
                                    <th>Classification</th>
                                        <%--产品介绍--%>
                                    <th>Product introduction</th>
                                        <%--适合人群--%>
                                    <th>Target group</th>
                                </tr>
                                <tr>
                                    <%--普通级别--%>
                                    <td>General level</td>
                                    <%--<td>直接将简历翻译成英文，内容不做修改，<br>与原文意思保持一致。</td>--%>
                                    <td>Resumes will be translated directly into English without content modification, <br>and will be consistent with the original.</td>
                                        <%--对英文简历有普通需求的白领及刚毕业人群--%>
                                    <td>White-collar workers and new graduates with general requirements for an English resume</td>
                                </tr>
                                <tr>
                                    <%--母语润色--%>
                                    <td>Polishing by native speakers</td>
                                    <%--<td>将中文简历内容进行校正后，根据所属专业领域<br>译成英文，翻译后的文章能准确传达简历内涵，<br>并按照外籍人士阅读习惯进行简历翻译。</td>--%>
                                    <td>After revision of the Chinese resume, it will be<br> translated into English according to the areas of<br> expertise; the translated resume will accurately convey<br> the original’s meaning, and will in line with the<br> reading habits of native speakers.</td>
                                    <%--<td>有外企面试需求、对英文简历专业化程度有一定<br>要求的高级白领人群，对内容专业度、英文简历<br>质量有高端要求的精英白领人</td>--%>
                                    <td>Senior white-collar workers who have foreign interview<br> needs and certain requirements as to English resume<br>
                                        specialization; elite white-collar workers who have high<br>
                                        requirements for the professional content and quality<br> of their English resumes.</td>
                                </tr>
                            </table>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <th></th>
                                    <%--简历翻译--%>
                                    <th>Resume</th>
                                    <%--译文审校--%>
                                    <th>Translation review</th>
                                    <%--英文简历排版--%>
                                    <th>Resume type setting</th>
                                    <%--简历修改--%>
                                    <th>Resume modification</th>
                                    <%--格式转换--%>
                                    <th>Format conversion</th>
                                    <%--母语润色--%>
                                    <th>Polishing by native speakers</th>
                                </tr>
                                <tr>
                                    <%--普通级别--%>
                                    <td>General level</td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"></td>
                                    <td class="blue"></td>
                                    <td class="blue"></td>
                                </tr>
                                <tr>
                                    <%--母语润色--%>
                                    <td>Polishing by native speakers</td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                    <td class="blue"><i class="icon iconfont">&#xe64d;</i></td>
                                </tr>
                            </table>
                        </li>
                        <li>
                            <table  class="table table-border table-bg  table-bordered  table-height65">
                                <tr class="bj">
                                    <th></th>
                                    <%--处理时间--%>
                                    <th>Handling time</th>
                                    <%--优惠价--%>
                                    <th>Discount prices</th>
                                </tr>
                                <tr>
                                    <%--普通级别--%>
                                    <td>General level</td>
                                        <%--千字以内1个工作日；每超过一千字顺延1个工作日<--%>
                                    <td>One working day for texts within 1,000 characters; for every additional thousand characters, another working day will be added.</td>
                                    <%--千字以内20元；超出部分，每超过500字，加收10元--%>
                                    <td>20 yuan for texts less of than 1,000 characters; for every 500 characters added, another 10 yuan will be charged.</td>
                                </tr>
                                <tr>
                                    <%--母语润色--%>
                                    <td>Polishing by native speakers</td>
                                    <%--千字以内1个工作日；每超过一千字顺延1个工作日--%>
                                    <td>One working day for texts within 1,000 characters; for every additional thousand characters, another working day will be added.</td>
                                    <%--千字以内200元；超出部分，每超过500字，加收100元--%>
                                    <td>200 yuan for texts of less than 1,000 characters; for every 500 characters added, another 100 yuan will be charged.</td>
                                </tr>
                            </table>
                        </li>
                        <li class="mt-20">
                            <%--注：--%>
                            <p>Note:</p>
                                <%--1、简历模板内的内容均为非必填项，您可以按需填写，将只收取所填部分的费用；--%>
                            <p>1. all the fields in the resume template are required; fill them in as needed, and only the completed fields will be charged; </p>
                                <%--2、20元为基本价格，限千字以内，超出部分需加收相应的费用；--%>
                            <p>2. The basic price is 20 yuan for texts of less than 1,000 characters, and texts exceeding that amount will be charged accordingly.</p>
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
                            <%--译云传承40年的服务品质，整合全球服务资源，承诺保证所有译文的质量，不满意免费修改。--%>
                            <p>Inheriting 40 years of quality service from China Translation and Publishing Corporation (CPTC) and bringing together global service resources, YeeCloud guarantees the quality of all translations and will provide changes free of charge for unsatisfactory translations.</p>
                        </li>
                        <li>
                            <%--快速翻译--%>
                            <p class="blue">Quick translation</p>
                                <%--最快每分钟10个字，具体时间需根据翻译内容多少和难度而定；翻译完成48小时内，不满意可以提出申请，我们提供免费修改服务。--%>
                            <p>You can receive your translation in as little as 30 minutes. The specific timeframe depends on the volume of content and level of difficulty. If you are unsatisfied with the translation, changes free of charge will be provided upon your application within 48 hours after the translation is completed.</p>
                        </li>
                        <li>
                            <%--创意翻译--%>
                            <p class="blue">Creative translation</p>
                                <%--翻译完成后，除译文外，我们将同时提供翻译解释；翻译完成48小时内，不满意可以提出申请，我们提供免费修改服务。--%>
                            <p>After the translation is completed, we will provide an interpretation alongside the translation. If you are unsatisfied with the translation, changes free of charge will be provided upon your application within 48 hours after the translation is completed.</p>
                        </li>
                        <li>
                            <%--证件翻译--%>
                            <p class="blue">Credential translation</p>
                                <%--翻译完成后，除了获得一份电子版的译文外，还可申请获得一份加盖我司公章的打印件；翻译完成48小时内，不满意可以提出申请，我们提供免费修改服务。/--%>
                            <p>After the translation is completed, in addition to the electronic edition of translation, you can also apply for a hard copy with our company stamp. If you are unsatisfied with the translation, changes free of charge will be provided upon your application within 48 hours after the translation is completed.</p>
                        </li>
                        <li>
                            <%--文档翻译--%>
                            <p class="blue">Document translation</p>
                                <%--一般性的文档译员处理速度在2000-3000字/天，专业性特别强的内容，译员处理速度1500-2500字/天，处理速度和内容的领域和难度有关，具体时间请下单后咨询我们客服。--%>
                            <p>The translation speed for general documents is 2,000 to 3,000 characters per day, while the speed for professional document translation is 1,500 to 2,500 characters per day. The translation speed depends on the field and difficulty of contents. Please contact our customer service personnel for a specific timeframe after placing an order.</p>
                        </li>
                        <li>
                            <%--简历翻译--%>
                            <p class="blue">Resume translation</p>
                            <p>One working day for general resume translation within 1,000 characters; for every additional 1,000 characters, one working day will be added. Resume translation within 1,000 characters that is also polished by native speakers will be handled in two working days; for every additional 1,000 characters, one working day will be added. Translation speed depends on the field and difficulty of the content. Please contact our customer service personnel for a specific timeline after placing an order.</p>
                                <%--普通级别的简历翻译千字以内1个工作日，每超过一千字顺延1个工作日；母语润色级别的简历翻译千字以内1个工作日，每超过一千字顺延1个工作日；处理速度和内容的领域和难度有关，具体时间请下单后咨询我们客服。--%>
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
