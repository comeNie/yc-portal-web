<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>首页</title>
    <%@ include file="/inc/inc.jsp" %>
    <link href="${uedroot}/css/modular/index.css" rel="stylesheet" type="text/css"/>
</head>

<body class="homebody">
<!--面包屑导航-->
<%@ include file="/inc/topHead.jsp" %>
<!--banner-->
<div class="banner<%= !Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())?"-en":""%>"></div>
<!--index nav-->
<div class="index-nav">
    <ul>
        <li><img src="${uedroot}/images/index-logo<%= !Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())?"_en":""%>.png" /></li>
        <li class="right">
            <!-- 首页 -->
            <p><a href="${_base}" class="current"><spring:message code="home.nav.bar.home"></spring:message></a></p>
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
<!--index nav-->
<!--bigmo-->
<div class="index-wrapper">
    <!--翻译区-->
    <div class="translate">
        <div class="translate-title">
            <ul>
                <li>
                    <select tabindex="5" class="dropdown" id="showa" data-settings='{"cutOff": 12}'>
                        <option value="" class="label">自动检测</option>
                        <option value="自动检测">自动检测</option>
                        <option value="中文简体">中文简体</option>
                        <option value="葡萄牙语">葡萄牙语</option>
                        <option value="英语">英语</option>
                        <option value="俄语">俄语</option>
                        <option value="法语">法语</option>
                    </select>
                </li>
                <li class="change"><a href="#"><i class="icon-exchange"></i></a></li>
                <li>
                    <select tabindex="5" class="dropdown" id="showb" data-settings='{"cutOff": 12}'>
                        <option value="" class="label">自动检测</option>
                        <option value="自动检测">自动检测</option>
                        <option value="中文简体">中文简体</option>
                        <option value="葡萄牙语">葡萄牙语</option>
                        <option value="英语">英语</option>
                        <option value="俄语">俄语</option>
                        <option value="法语">法语</option>
                    </select>
                </li>
                <%--翻译--%>
                <li><input type="button"  class="btn btn-blue trans-btn-zh radius2"
                           value="<spring:message code="home.interpret_btn"/>"></li>
            </ul>
        </div>
        <!--翻译主体-->
        <div class="translate-wapper">
            <div class="before-translation">
                <textarea  class="int-before" id="int-before"></textarea>
            </div>
            <div class="before-translation ml-20">
                <textarea  class="int-post"></textarea>
                <div class="post-cion">
                    <p>
                        <a href="#" class="ord-icon"><i class="icon iconfont">&#xe62e;</i></a>
                        <a href="#" class="radio-icon"><i class="icon iconfont">&#xe61b;</i></a>
                        <a href="#" class="stars-icon"><i class="icon iconfont">&#xe754;</i></a>
                    </p>
                    <p class="right">
                        <a href="#" class="edit-icon">
                            <span><i class="icon iconfont">&#xe62a;</i></span>
                            <span><spring:message code="home.translation_error_btn"/>?</span>
                        </a>
                    </p>
                </div>
            </div>
        </div>
        <!--file-->
        <div class="translate-file">
            <ul>
                <li>
                    <%--<p><input type="button" class="btn btn-blue btn-trans radius2" value="上传文档"><input type="file"  class="pop-file"></p>
                    <p>（支持5000字以内的.doc（X）.TXT文件）</p>--%>
                </li>
                <li class="right"><input type="button" class="btn border-blue btn-trans-b radius2"
                                         value="<spring:message code="home.human_translation_btn"/>"></li>
            </ul>
        </div>
    </div>
    <!--说明-->
    <div class="explain-big">
        <div class="explain-wapper">
            <div class="explain-cont">
                <div class="item2">
                    <img src="${uedroot}/images/explain1.jpg"/>
                    <div class="item2-txt">
                        <%--翻译论文、稿件--%>
                        <span class="word"><spring:message code="home.paper_translation_tips"/></span>
                            <%--提供各种论文、稿件的翻译、审校、排版等服务，不满意免费修改--%>
                        <span><spring:message code="home.paper_translation_content_tips"/></span>
                            <%--立即下单--%>
                        <span><input type="button" class="btn btn-blue place-btn radius20" purpose="1"
                                     value="<spring:message code="home.manual_order_now_btn"/>"></span>
                    </div>
                    <div class="caption" purpose="1">
                        <%--翻译论文、稿件--%>
                        <p class="title"><spring:message code="home.paper_translation_tips"/></p>
                        <p class="exp-icon1"></p>
                        <%--立即下单--%>
                        <p><input type="button" class="btn border-blue place-btn-none radius20" purpose="1"
                                  value="<spring:message code="home.manual_order_now_btn"/>"></p>
                    </div>
                </div>
            </div>
            <div class="explain-cont ml-20">
                <div class="item2">
                    <img src="${uedroot}/images/explain2.jpg"/>
                    <div class="item2-txt">
                        <%--翻译中英文简历--%>
                        <span class="word"><spring:message code="home.resume_translation_tips"/></span>
                            <%--按模板填写简历内容，简单、便捷、译审结合，不满意免费修改--%>
                        <span><spring:message code="home.resume_translation_content_tips"/></span>
                        <%--立即下单--%>
                        <span><input type="button" class="btn btn-blue place-btn radius20" purpose="2"
                                     value="<spring:message code="home.manual_order_now_btn"/>"></span>
                    </div>
                    <div class="caption" purpose="2">
                        <%--翻译中英文简历--%>
                        <p class="title"><spring:message code="home.resume_translation_tips"/></p>
                        <p class="exp-icon2"></p>
                        <%--立即下单--%>
                        <p><input type="button" class="btn border-blue place-btn-none radius20" purpose="2"
                                  value="<spring:message code="home.manual_order_now_btn"/>"></p>
                    </div>
                </div>
            </div>
            <div class="explain-cont ml-20">
                <div class="item2">
                    <img src="${uedroot}/images/explain3.jpg"/>
                    <div class="item2-txt">
                        <%--翻译产品说明--%>
                        <span class="word"><spring:message code="home.manual_translation_tips"/></span>
                            <%--提供最快速最精准的翻译服务，译员时刻待命，立等可取--%>
                        <span><spring:message code="home.manual_translation_content_tips"/></span>
                        <%--立即下单--%>
                        <span><input type="button" class="btn btn-blue place-btn radius20" purpose="3"
                                     value="<spring:message code="home.manual_order_now_btn"/>"></span>
                    </div>
                    <div class="caption" purpose="3">
                        <%--翻译产品说明--%>
                        <p class="title"><spring:message code="home.manual_translation_tips"/></p>
                        <p class="exp-icon3"></p>
                        <%--立即下单--%>
                        <p><input type="button" class="btn border-blue place-btn-none radius20" purpose="3"
                                  value="<spring:message code="home.manual_order_now_btn"/>"></p>
                    </div>
                </div>
            </div>
            <div class="explain-cont ml-20">
                <div class="item2">
                    <img src="${uedroot}/images/explain4.jpg"/>
                    <div class="item2-txt">
                        <%--翻译各种证件--%>
                        <span class="word"><spring:message code="home.certificate_translation_tips"/></span>
                            <%--提供身份证、护照、驾照等证件的翻译服务，可加盖公章--%>
                            <span><spring:message code="home.certificate_translation_content_tips"/></span>
                        <%--立即下单--%>
                        <span><input type="button" class="btn btn-blue place-btn radius20" purpose="5"
                                     value="<spring:message code="home.manual_order_now_btn"/>"></span>
                    </div>
                    <div class="caption" purpose="5">
                        <%--翻译各种证件--%>
                        <p class="title"><spring:message code="home.certificate_translation_tips"/></p>
                        <p class="exp-icon4"></p>
                        <%--立即下单--%>
                        <p><input type="button" class="btn border-blue place-btn-none radius20" purpose="5"
                                  value="<spring:message code="home.manual_order_now_btn"/>"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--广告-->
    <div class="banner-wapper">
        <div class="banner-sm">
            <a href="${_base}/oral">
                <img src="${uedroot}/images/banner-sm<%= !Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())?"_en":""%>.jpg" />
            </a>
        </div>
        <div class="banner-hover">
            <p><i class="icon-angle-down"></i></p>
        </div>
    </div>
    <!--服务平台-->
    <div class="service-wapper">
        <div class="service-container">
            <%--一站式翻译服务平台--%>
            <div class="service-title"><spring:message code="home.title.tips"/></div>
            <div class="service-list">
                <ul class="none">
                    <li class="tp">
                        <p class="sev-icon1"></p>
                        <%--智能自动翻译--%>
                        <p><spring:message code="home.auto_translation_tips"/></p>
                    </li>
                    <%--智能自动翻译  亿万级语料支持，通过强大的云端数据处理技术为用户提供精准、快速、人性的智能翻译服务。--%>
                    <li class="word"><spring:message code="home.auto_translation_content_tips"/></li>
                </ul>
                <ul class="tow">
                    <li>
                        <p class="sev-icon2"></p>
                        <%--精准人工翻译--%>
                        <p class="p-word"><spring:message code="home.manual_translation"/></p>
                    </li>
                </ul>
                <ul class="tow right">
                    <li>
                        <p class="sev-icon3"></p>
                        <%--全终端翻译工具--%>
                        <p class="p-word"><spring:message code="home.allchannel_translation"/></p>
                    </li>
                </ul>
            </div>
        </div>
    </div>

    <!--数据-->
    <div class="data-wapper">
        <div class="data-container">
            <ul>
                <li>
                    <p class="icon-a"></p>
                    <p class="shuz timer" id="count-number" data-to="${homeData.lgdataNum}" data-speed="4500"></p>
                    <%--语料--%>
                    <p class="word"><spring:message code="home.foot.tips.corpus"/></p>
                </li>
                <li>
                    <p class="icon-b"></p>
                    <p class="shuz timer" id="count-number" data-to="${homeData.customNum}" data-speed="4500"></p>
                    <p class="word"><spring:message code="home.foot.tips.customer"/></p>
                    <%--客户--%>
                </li>
                <li>
                    <p class="icon-c"></p>
                    <p class="shuz timer" id="count-number" data-to="${homeData.interpreterNum}" data-speed="4500"></p>
                    <p class="word"><spring:message code="home.foot.tips.interpreter"/></p>
                    <%--译员--%>
                </li>
                <li>
                    <p class="icon-d"></p>
                    <p class="shuz timer" id="count-number" data-to="${homeData.orderNum}" data-speed="4500"></p>
                    <p class="word"><spring:message code="home.foot.tips.order"/></p>
                    <%--订单--%>
                </li>
                <li class="non-ml">
                    <p class="icon-e"></p>
                    <p class="shuz timer" id="count-number" data-to="${homeData.languageNum}" data-speed="4500"></p>
                    <p class="word"><spring:message code="home.foot.tips.language"/></p>
                    <%--语种--%>
                </li>
            </ul>
        </div>
    </div>
    <!--底部-->
    <%@include file="/inc/indexFoot.jsp"%>
</div>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript" src="${uedroot}/scripts/modular/drop-down.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/index.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/digital-scroll.js"></script>
<script type="text/javascript">
    (function () {
        <%-- 笔译下单 --%>
        $('.item2').delegate('div.caption','click',function(){
            //用途编码
            var purpose = $(this).attr('purpose');
            window.location.href="${_base}/order/create/text?selPurpose="+purpose;
        });
        var pager;
        seajs.use('app/jsp/home', function(homePage) {
            pager = new homePage({element : document.body});
            pager.render();
        });
    })();
</script>
</html>