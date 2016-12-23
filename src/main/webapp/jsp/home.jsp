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
    <title>首页</title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="icon" href="${uedroot}/images/icon32.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="${uedroot}/images/icon32.ico" type="image/x-icon" />
    <link href="${uedroot}/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="${uedroot}/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="${uedroot}/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="${uedroot}/css/modular/headr-footer.css" rel="stylesheet" type="text/css"/>
    <link href="${uedroot}/css/modular/index.css" rel="stylesheet" type="text/css"/>


    <style type="text/css">
        /*分词高亮*/
        .before-translation span.b_cur {background: #fff444 none repeat scroll 0 0;}

        .ta_text {
            height: 198px;
            word-wrap: break-word;
            word-break: break-all;
            overflow: auto;
            overflow-x: hidden;
        }

        .tb_text {
            height: 166px;
            line-height: 22px;
            word-wrap: break-word;
            word-break: break-all;
            overflow: auto;
            overflow-x: hidden;
        }

        .mcpd_icon .audiojs{float:left;}
        .audiojs{overflow:hidden;}
        .audiojs div{display:none;}
        .audiojs .error-message{display:none;}


    </style>
    </head>

<body class="homebody">
<!--面包屑导航-->
<%@ include file="/inc/topHead.jsp" %>
<%--图片版本--%>
<c:set var="lTag"><%= !Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())?"_en":""%></c:set>
<!--banner-->
<div class="banner"><p><img src="${uedroot}/images/banner-word${lTag}.png"></p></div>
<!--index nav-->
<div class="index-nav">
    <ul>
        <li><img src="${uedroot}/images/index-logo${lTag}.png" /></li>
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
                        <%--自动检测--%>
                        <option value="auto" selected = "selected"><spring:message code="home.trans_language_auto"/></option>
                            <%--中文简体--%>
                            <option value="zh"><spring:message code="home.trans_language_zh"/></option>
                            <%--英语--%>
                            <option value="en"><spring:message code="home.trans_language_en"/></option>
                            <%--法语--%>
                            <%--<option value="fr"><spring:message code="home.trans_language_fr"/></option>--%>
                            <%--俄语--%>
                            <option value="ru"><spring:message code="home.trans_language_ru"/></option>
                            <%--葡萄牙语--%>
                            <option value="pt"><spring:message code="home.trans_language_pt"/></option>
                    </select>
                </li>
                <li class="change"><a href="javaScript:void(0)"><i class="icon-exchange"></i></a></li>
                <li>
                    <select tabindex="5" class="dropdown" id="showb" data-settings='{"cutOff": 12}'>
                        <%--中文简体--%>
                        <option value="zh"><spring:message code="home.trans_language_zh"/></option>
                        <%--英语--%>
                        <option value="en"><spring:message code="home.trans_language_en"/></option>
                        <%--法语--%>
                        <%--<option value="fr"><spring:message code="home.trans_language_fr"/></option>--%>
                        <%--俄语--%>
                        <option value="ru"><spring:message code="home.trans_language_ru"/></option>
                        <%--葡萄牙语--%>
                        <option value="pt"><spring:message code="home.trans_language_pt"/></option>
                    </select>
                </li>
                <%--翻译--%>
                <li><input id="trante" type="button"  class="btn btn-blue trans-btn-zh radius2"
                           value="<spring:message code="home.interpret_btn"/>"></li>
            </ul>
        </div>
        <!--翻译主体-->
        <div class="translate-wapper">
            <div class="before-translation">
                <div id="srcNew" class="int-before ta_text"  style="display: none;">
                </div>
                <div id="srcOld" class="int-before"  style="display: block;">
                    <textarea maxlength="2000" class="int-before" id="int-before"></textarea>
                 </div>

            </div>
            <div class="before-translation ml-20">
                <div id="tgtNew" class="int-post tb_text" onmousemove="srcMove()" onmouseout="srcOut()"  style="display: none">
                </div>
                <div id="tgtOld" class="int-post"  style="display: block;">
                    <textarea  class="int-post"  id="transRes" ></textarea>
                    <textarea  class="int-post"  id="transResBak" style="display: none"></textarea>
                </div>
                <label id="transError"></label>
                <div class="post-cion" style="display: none;">

					<p>
						<a id="sus-top1" href="javaScript:void(0)" class="ord-icon"><i id="copy" class="icon iconfont">&#xe639;</i>
                            <!-- 复制译文-->
                            <span class="suspension1"><spring:message code="home.Copytranslation"/></span>
                        </a>
						<a  id="sus-top2" href="javaScript:void(0)" class="radio-icon"><i class="icon iconfont">&#xe636;</i>
                            <!-- 朗诵译文-->
                            <span class="suspension2"><spring:message code="home.Readtrans"/></span>
                        </a>
						 <!--<a id="sus-top3" href="javaScript:void(0)" class="stars-icon"><i class="icon iconfont">&#xe637;</i>
						    <span class="suspension3">收藏译文</span>
						 </a>-->
					</p>
					<p class="right" id="error">
						<a href="javaScript:void(0)" class="edit-icon" id="sus-top">
							<span><i class="icon iconfont">&#xe638;</i></span>
							<!-- 翻译有误 -->
							<span><spring:message code="home.translation_error_btn"/>?</span>
						</a>
                    <!-- 修改译文 -->
                    <div class="suspension">	<spring:message code="home.Modifytranslation"/></div>
                    </p>
					<p class="right" id="error-oc"  style="display: none;">
						<a href="javaScript:void(0)" class="edit-icon" id="preser-btn">
							<span><i class="icon iconfont">&#xe651;</i></span>
							<!-- 保存 -->
							<span><spring:message code="home.save"/></span>
						</a>
						<a href="javaScript:void(0)"  class="edit-icon"  id="preser-close">
							<span><i class="icon iconfont">&#xe652;</i></span>
							<!-- 取消 -->
							<span><spring:message code="home.cancel"/></span>
						</a>
					</p>
				</div>
                <!-- 播放器 -->
                <div class="mcpd_icon clearfix">
                 <audio src=""  id="audioPlay"   />
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
                <li class="right">
                    <%--人工翻译--%>
                    <input id="humanTranBtn" type="button" class="btn border-blue btn-trans-b radius2"
                                         value="<spring:message code="home.human_translation_btn"/>">
                </li>
            </ul>
        </div>
    </div>
    <!--说明-->
    <div class="explain-big">
        <div class="explain-wapper">
            <div class="explain-cont">
                <div class="item2">
                    <div class="img"></div>
                    <div class="item2-txt">
                        <%--翻译论文、稿件--%>
                        <span class="word"><spring:message code="home.paper_translation_tips"/></span>
                        <span class="exp-icon1"></span>
                            <%--立即下单--%>
                        <span><input type="button" class="btn border-blue place-btn-none radius20" purpose="1"
                                     value="<spring:message code="home.manual_order_now_btn"/>"></span>
                    </div>
                    <div class="caption caption1" purpose="1">
                        <%--翻译论文、稿件--%>
                        <p class="title"><spring:message code="home.paper_translation_tips"/></p>
                            <%--提供各种论文、稿件的翻译、审校、排版等服务，不满意免费修改--%>
                        <p class="text-l"><spring:message code="home.paper_translation_content_tips"/></p>
                            <%--立即下单--%>
                        <p><input type="button" class="btn btn-blue place-btn radius20" purpose="1"
                                  value="<spring:message code="home.manual_order_now_btn"/>"></p>
                    </div>
                </div>
            </div>
            <div class="explain-cont ml-20">
                <div class="item2">
                    <div class="img"></div>
                    <div class="item2-txt">
                        <%--翻译中英文简历--%>
                        <span class="word"><spring:message code="home.resume_translation_tips"/></span>
                        <span class="exp-icon2"></span>
                            <%--立即下单--%>
                        <span><input type="button" class="btn border-blue place-btn-none radius20" purpose="2"
                                     value="<spring:message code="home.manual_order_now_btn"/>"></span>
                    </div>
                    <div class="caption caption2" purpose="2">
                        <%--翻译中英文简历--%>
                        <p class="title"><spring:message code="home.resume_translation_tips"/></p>
                            <%--按模板填写简历内容，简单、便捷、译审结合，不满意免费修改--%>
                        <p class="text-l"><spring:message code="home.resume_translation_content_tips"/></p>
                            <%--立即下单--%>
                        <p><input type="button" class="btn btn-blue place-btn radius20" purpose="2"
                                  value="<spring:message code="home.manual_order_now_btn"/>"></p>
                    </div>
                </div>
            </div>
            <div class="explain-cont ml-20">
                <div class="item2">
                    <div class="img"></div>
                    <div class="item2-txt">
                        <%--翻译产品说明--%>
                        <span class="word"><spring:message code="home.manual_translation_tips"/></span>
                        <span class="exp-icon3"></span>
                            <%--立即下单--%>
                        <span><input type="button" class="btn border-blue place-btn-none radius20" purpose="3"
                                     value="<spring:message code="home.manual_order_now_btn"/>"></span>
                    </div>
                    <div class="caption caption3" purpose="3">
                        <%--翻译产品说明--%>
                        <p class="title"><spring:message code="home.manual_translation_tips"/></p>
                            <%--提供最快速最精准的翻译服务，译员时刻待命，立等可取--%>
                        <p class="text-l"><spring:message code="home.manual_translation_content_tips"/></p>
                            <%--立即下单--%>
                        <p><input type="button" class="btn btn-blue place-btn radius20" purpose="3"
                                  value="<spring:message code="home.manual_order_now_btn"/>"></p>
                    </div>
                </div>
            </div>
            <div class="explain-cont ml-20">
                <div class="item2">
                    <div class="img"></div>
                    <div class="item2-txt">
                        <%--翻译各种证件--%>
                        <span class="word"><spring:message code="home.certificate_translation_tips"/></span>
                        <span class="exp-icon4"></span>
                            <%--立即下单--%>
                        <span><input type="button" class="btn border-blue place-btn-none radius20" purpose="4"
                                     value="<spring:message code="home.manual_order_now_btn"/>"></span>
                    </div>
                    <div class="caption caption4" purpose="4">
                        <%--翻译各种证件--%>
                        <p class="title"><spring:message code="home.certificate_translation_tips"/></p>
                            <%--提供身份证、护照、驾照等证件的翻译服务，可加盖公章--%>
                        <p class="text-l"><spring:message code="home.certificate_translation_content_tips"/></p>
                            <%--立即下单--%>
                        <p><input type="button" class="btn btn-blue place-btn radius20"
                                  value="<spring:message code="home.manual_order_now_btn"/>"></p>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!--广告-->
    <div class="banner-wapper">
        <div class="banner-sm">
            <p class="left">
                <%--口译翻译--%>
                <span class="word"><spring:message code="home.oral_translation_tips"/></span>
                    <%--全球多领域，全语种高端口译人才，提供国际会议，商务活动等各种服务--%>
                <span><spring:message code="home.oral_translation_content_tips"/></span>
            </p>
            <%--立即下单--%>
            <p class="right"><input type="button" id="oralBtn" class="btn btn-blue banner-place-btn radius20"
                                    value="<spring:message code="home.manual_order_now_btn"/>"
                                    onclick="javaScript:window.location.href='${_base}/oral'"></p>
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
            <div class="hot_role">
                <ul id="centerwell">
                    <li>
                        <h3>
                            <p><img src="${uedroot}/images/icon-16.png" id="img1"><i class="icon-plus jiaicon1"></i></p>
                            <%--智能自动翻译--%>
                            <p class="word"><spring:message code="home.auto_translation_tips"/></p>
                        </h3>
                        <div class="hot_content">
                            <%--智能自动翻译  亿万级语料支持，通过强大的云端数据处理技术为用户提供精准、快速、人性的智能翻译服务。--%>
                            <div class="hot_top">
                                <spring:message code="home.auto_translation_content_tips"/>
                            </div>
                        </div>
                    </li>
                    <li>
                        <h3>
                            <p><img src="${uedroot}/images/icon-17.png"  id="img2"><i class="icon-plus jiaicon2"></i></p>
                            <%--精准人工翻译--%>
                            <p class="word"><spring:message code="home.manual_translation"/></p>
                        </h3>
                        <div class="hot_content">
                            <%--一流的译员翻译团队，覆盖全球资源，高速响应客户需求，做精准的人工翻译，让客户随时享有翻译服务--%>
                            <div class="hot_top">
                                <spring:message code="home.manual_translation_content"/>
                            </div>
                        </div>
                    </li>
                    <li style="margin-right:0">
                        <h3>
                            <p><img src="${uedroot}/images/icon-18.png"  id="img3"><i class="icon-plus jiaicon3"></i></p>
                            <%--全终端翻译工具--%>
                            <p class="word"><spring:message code="home.allchannel_translation"/></p>
                        </h3>
                        <div class="hot_content">
                            <%--平台提供字幕翻译、会议翻译、网页插件等免费翻译工具，通过网页、app，微信等各种终端尽可享有--%>
                            <div class="hot_top">
                                <spring:message code="home.allchannel_translation_content"/>
                            </div>
                        </div>
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
<script type="text/javascript" src="${uedroot}/scripts/modular/drop-down.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/index.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/digital-scroll.js"></script>
<script type="text/javascript" src="${spmRes}/app/jsp/index.js"></script>

</html>
