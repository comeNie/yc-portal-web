<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

    <%@ include file="/inc/inc.jsp" %>
    <!-- 评价订单 -->
    <title><spring:message code="myOrder.EvaluationOrder"/></title>
</head>
<body>
<!--弹出-->
<div class="eject-big">
    <div class="prompt-samll"  id="evaluate-password" style="display:none;">
        <div class="prompt-samll-title">评价成功</div>
        <!--确认删除-->
        <div class="prompt-samll-confirm">
            <ul class="pass-list">
                <li>感谢您的评价！</li>
                <li class="eject-btn">
                    <input type="button" id="evaluate-determine" class="btn btn-green btn-120 radius20" value="确 定">

                </li>
            </ul>
        </div>
    </div>
    <div class="mask" id="eject-mask"  style="display:none;"></div>
</div>
<!--/弹出结束-->
<input id="orderId" type="hidden" value=""${orderId}"/>
<!--头部-->
<%@include file="/inc/userTopMenu.jsp"%>
<!--二级主体-->
<!--外侧背景-->
<div class="cloud-container">
    <!--内侧内容区域-->
    <div class="cloud-wrapper">
        <!--左侧菜单-->
        <%@include file="/inc/leftmenu.jsp"%>
        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <!--右侧第一块-->

            <!--右侧第二块-->
            <div class="right-list mt-0">
                <div class="right-list-title pb-10 pl-20">
                    <%--评价订单--%>
                    <p><spring:message code="myOrder.EvaluationOrder"/></p>
                </div>
                <div class="evaluate">
                    <ul>
                        <li>
                            <%--服务质量--%>
                            <p class="title"><spring:message code="myOrder.ServiceQuality"/>：</p>
                            <p>
                                <c:forEach begin="0" end="4" step="1" varStatus="status">
                                    <c:choose>
                                        <c:when  test="${status.current < orderEvaluateInfo.serveQuality/8}">
                                            <span><img src="${uedroot}/images/xx-01.jpg"></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span><img src="${uedroot}/images/xx-02.jpg"></span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </p>
                        </li>
                        <li>
                            <%--服务速度--%>
                            <p class="title"><spring:message code="myOrder.ServiceSpeed"/>：</p>
                            <p>
                                <c:forEach begin="0" end="4" step="1" varStatus="status">
                                    <c:choose>
                                        <c:when  test="${status.current < orderEvaluateInfo.serveSpeed/6}">
                                            <span><img src="${uedroot}/images/xx-01.jpg"></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span><img src="${uedroot}/images/xx-02.jpg"></span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </p>
                        </li>
                        <li>
                            <%--服务态度--%>
                            <p class="title"><spring:message code="myOrder.ServiceAttitude"/>：</p>
                            <p>
                                <c:forEach begin="0" end="4" step="1" varStatus="status">
                                    <c:choose>
                                        <c:when  test="${status.current < orderEvaluateInfo.serveManner/6}">
                                            <span><img src="${uedroot}/images/xx-01.jpg"></span>
                                        </c:when>
                                        <c:otherwise>
                                            <span><img src="${uedroot}/images/xx-02.jpg"></span>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </p>
                        </li>
                        <li>
                            <p class="title"><spring:message code="myOrder.EvaluationContent"/>：</p>
                            <p class="word">${orderEvaluateInfo.evaluateContent}</p>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/inc/incJs.jsp" %>
<script src="${_base}/resources/template/scripts/modular/eject.js"></script>

</body>
</html>