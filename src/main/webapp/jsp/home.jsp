<%@ page import="com.ai.yc.protal.web.controller.IndexController" %>
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
    <meta property="wb:webmaster" content="d8bcb31352dcbeda" />
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title><spring:message code="home.nav.title"/></title>
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <link rel="icon" href="${uedroot}/images/icon32.ico" type="image/x-icon" />
    <link rel="shortcut icon" href="${uedroot}/images/icon32.ico" type="image/x-icon" />
    <link href="${uedroot}/css/bootstrap/font-awesome.css" rel="stylesheet" type="text/css">
    <link href="${uedroot}/css/iconfont.css" rel="stylesheet" type="text/css">
    <link href="${uedroot}/css/modular/global.css" rel="stylesheet" type="text/css"/>
    <link href="${uedroot}/css/modular/headr-footer.css" rel="stylesheet" type="text/css"/>
    <link href="${uedroot}/css/modular/index.css" rel="stylesheet" type="text/css"/>
    <link rel="stylesheet" type="text/css" href="${_base}/resources/spm_modules/webuploader/webuploader.css">

    <style type="text/css">
        /**弹出框**/
        .prompt-samll{ width:350px; background:#fff; position:fixed;top:50%;left:50%;margin-top:-200px;margin-left:-175px;z-index:999;border-radius:5px;display:none;padding-bottom:10px;}
        .prompt-samll-title{ width:100%; float:left;height:50px;background:#39d5b0;border-radius:5px 5px 0 0;text-align:center;line-height:50px;color:#fff;font-size:16px}
        .prompt-samll-confirm{ width:100%;float:left; margin-top:25px;padding:0 40px;}
        .prompt-samll-confirm ul{ width:100%;float:left; }
        .prompt-samll-confirm ul li{ text-align:center;margin-bottom: 10px;font-size:14px;}
        .prompt-samll-confirm ul .eject-btn{margin-top: 28px;text-align: center;}
        .prompt-samll-confirm ul .eject-btn .btn{margin-left:10px;}
        .prompt-samll-confirm .pass-list li{width:100%;float:left}
        .prompt-samll-confirm ul  p{float:left;line-height:40px;}
        .prompt-samll-confirm ul .word{width:80px;float:left;text-align: right;}
        .mask{position:fixed;top:0;left:0;width:100%;height:100%;background:#000;opacity:0.4;filter:alpha(opacity=40);z-index:199;display:none;}

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

        .uploadDiv { width:80px;  height: 26px; float: left;}

        .uploadDiv .webuploader-pick{
            border:2px;
            background-color:#2361ea;
            color:#fff;
            width:80px;height:26px;
            border-radius:2px;
            font-weight: normal;
            cursor:pointer;
            text-align:center;
            outline:none;
            font-size:14px;
            transition:.3s;
            padding:0;
        }
    </style>
    <%@ include file="/inc/incJs.jsp" %>
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
                <c:set var="lgFrom" value=""/>
                <c:set var="lgTo" value=""/>
                <c:if test="${userCollectTemp!=null}">
                    <c:set var="lgFrom" value="${userCollectTemp.sourceLanguage}"/>
                    <c:set var="lgTo" value="${userCollectTemp.targetLanguage}"/>
                </c:if>
                <li>
                    <select tabindex="5" class="dropdown" id="showa" data-settings='{"cutOff": 12}'>
                        <%--自动检测--%>
                        <option value="auto" <c:if test="${lgFrom==''}">selected = "selected"</c:if>>
                            <spring:message code="home.trans_language_auto"/></option>
                        <%--中文简体--%>
                        <option value="zh" <c:if test="${lgFrom=='zh'}">selected = "selected"</c:if>>
                            <spring:message code="home.trans_language_zh"/></option>
                        <%--英语--%>
                        <option value="en" <c:if test="${lgFrom=='en'}">selected = "selected"</c:if>>
                            <spring:message code="home.trans_language_en"/></option>
                        <%--法语--%>
                        <%--<option value="fr"><spring:message code="home.trans_language_fr"/></option>--%>
                        <%--俄语--%>
                        <option value="ru" <c:if test="${lgFrom=='ru'}">selected = "selected"</c:if>>
                            <spring:message code="home.trans_language_ru"/></option>
                        <%--葡萄牙语--%>
                        <option value="pt" <c:if test="${lgFrom=='pt'}">selected = "selected"</c:if>>
                            <spring:message code="home.trans_language_pt"/></option>
                    </select>
                </li>
                <li class="change"><a href="javaScript:void(0)"><i class="icon-exchange"></i></a></li>
                <li>
                    <select tabindex="5" class="dropdown" id="showb" data-settings='{"cutOff": 12}'>
                        <%--中文简体--%>
                        <option value="zh" <c:if test="${lgTo=='zh'}">selected = "selected"</c:if>>
                            <spring:message code="home.trans_language_zh"/></option>
                        <%--英语--%>
                        <option value="en" <c:if test="${lgTo=='en'}">selected = "selected"</c:if>>
                            <spring:message code="home.trans_language_en"/></option>
                        <%--法语--%>
                        <%--<option value="fr"><spring:message code="home.trans_language_fr"/></option>--%>
                        <%--俄语--%>
                        <option value="ru" <c:if test="${lgTo=='ru'}">selected = "selected"</c:if>>
                            <spring:message code="home.trans_language_ru"/></option>
                        <%--葡萄牙语--%>
                        <option value="pt" <c:if test="${lgTo=='pt'}">selected = "selected"</c:if>>
                            <spring:message code="home.trans_language_pt"/></option>
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
                    <textarea
                            onkeyup="pager.textCounter('inputsLen',2000);" onkeydown="pager.textCounter('inputsLen',2000);"
                            oninput="pager.textCounter('inputsLen',2000);"  onpropertychange="pager.textCounter('inputsLen',2000);"
                            class="int-before" id="int-before"><c:if test="${userCollectTemp!=null}">${userCollectTemp.original}</c:if></textarea>
                    <div class="already"><spring:message code="home.Alreadyinput" arguments="0,2000"/></div>
                 </div>

            </div>
            <div class="before-translation ml-20">
                <div id="tgtNew" class="int-post tb_text" onmousemove="srcMove()" onmouseout="srcOut()"  style="display: none">
                </div>
                <div id="tgtOld" class="int-post" style="display: block;">
                    <textarea class="int-post" id="transRes" readonly="readonly"><c:if
                            test="${userCollectTemp!=null}">${userCollectTemp.translation}</c:if></textarea>
                    <textarea class="int-post" id="transResBak" style="display: none"><c:if
                            test="${userCollectTemp!=null}">${userCollectTemp.translation}</c:if></textarea>
                </div>
                <label id="transError"></label>
                <div class="post-cion" <c:if test="${empty userCollectTemp || empty userCollectTemp.translation}">style="visibility: hidden"</c:if>>

					<p>
						<a id="sus-top1" href="javaScript:void(0)" class="ord-icon"><i id="copy" class="icon iconfont">&#xe639;</i>
                            <!-- 复制译文-->
                            <span class="suspension1"><spring:message code="home.Copytranslation"/></span>
                        </a>
						<a  id="sus-top2" href="javaScript:void(0)" class="radio-icon"><i class="icon iconfont">&#xe636;</i>
                            <!-- 朗诵译文-->
                            <span class="suspension2"><spring:message code="home.Readtrans"/></span>
                        </a>
                        <%--收藏译文--%>
                        <a id="sus-top3" href="javaScript:void(0)" class="stars-icon" collectId=""><i class="icon iconfont">&#xe637;</i>
						    <span class="suspension3"><spring:message code="home.collect.title"/></span>
                        </a>
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
                    <%--上传文档--%>
                    <div id="selectFile" class="uploadDiv"><spring:message code="home.upload_file_btn"/></div>
                    <%--支持100K以内的.doc（X）.TXT文件--%>
                    （<spring:message code="home.file_tips"/>）
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
                    <div class="caption caption2" purpose="8">
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
                    <div class="caption caption3" purpose="4">
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
                    <div class="caption caption4" purpose="6">
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
    <c:set var="showTb" value="true"/>
    <%@include file="/inc/indexFoot.jsp"%>
</div>
</body>

<script type="text/javascript" src="${uedroot}/scripts/modular/drop-down.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/index.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/digital-scroll.js"></script>
<script type="text/javascript" src="${spmRes}/jquery-zclip-master/jquery.zclip.js"></script>
<script type="text/javascript" src="${spmRes}/app/jsp/index.js"></script>
<script type="text/javascript">
    var pager;
    //ajax的登录跳转地址
    var ajaxPLogin = window.location.protocol+"//"+window.location.host+"${_base}/p/index";
    //是否需要触发译文收藏功能
    var needCollect = false;
    <c:if test="${userCollectTemp!=null && not empty userCollectTemp.translation}">
        needCollect = true;
    </c:if>

    (function () {
        var _webProtocol = (("https:" == document.location.protocol) ? " https://" : " http://");
        //百度统计
        var hm = document.createElement("script");
        hm.src =  "//hm.baidu.com/hm.js?abc0c1bd59df490d1d8c8e6a44b09fdc";
        var s = document.getElementsByTagName("script")[0];
        s.parentNode.insertBefore(hm, s);
        //百度商桥统计
        document.write(unescape("%3Cscript src='" + _webProtocol
            + "hm.baidu.com/h.js%3F0f7edd714a27976c6673e5db7079b08a' type='text/javascript'%3E%3C/script%3E"));
        <%-- 笔译下单 --%>
        $('.item2').delegate('div.caption','click',function(){
            //用途编码
            var purpose = $(this).attr('purpose');
            window.location.href="${_base}/order/create/text?selPurpose="+purpose;
        });

        seajs.use('app/jsp/home', function(homePage) {
            pager = new homePage({element : document.body});
            pager.render();
        });

        $("#sus-top1").zclip({
            path:"${_base}/resources/spm_modules/jquery-zclip-master/ZeroClipboard.swf",
            copy:function(){
                return $('#transRes').val();
            },
            afterCopy:function () {
            }
        });

//        $(".post-cion").hide();
    })();
</script>

</html>
