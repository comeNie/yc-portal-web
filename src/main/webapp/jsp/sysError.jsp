<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>订单报错</title>
    <%@ include file="/inc/inc.jsp" %>
</head>
<body>
<!--头部-->
<%@ include file="/inc/topHead.jsp" %>
<%@ include file="/inc/topMenu.jsp" %>
<!--二级主体-->
<!--外侧背景-->
<div class="cloud-container">
    <!--内侧内容区域-->
    <div class="cloud-wrapper">
        <c:set var="myOrder" value="${_base}/p/customer/order/list/view"/>
        <!--左侧菜单-->
        <c:choose>
            <%--如果为译员，则显示译员菜单--%>
            <c:when test="${isTrans==true}">
                <c:set var="myOrder" value="${_base}/p/trans/order/list/view"/>
                <%@include file="/inc/transLeftmenu.jsp" %>
            </c:when>
            <%--否则为客户菜单--%>
            <c:otherwise><%@include file="/inc/leftmenu.jsp" %></c:otherwise>
        </c:choose>

        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <!--右侧第一块-->
            <!--右侧第二块-->
            <div class="right-list mt-0">
                <!--充值-->
                <div class="recharge mt-30">
                    <!--充值成功-->
                    <div class="recharge-success">
                        <ul>
                            <li><img src="${uedroot}/images/rech-fail.png"/></li>
                            <li class="word"><spring:message code="sys.error.error.msg"/></li>
                            <li class="list mt-50">
                                <spring:message code="sys.error.error.tag.back" arguments="${myOrder}"/><br><spring:message code="sys.error.error.phone"/>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/jqueryrotate.2.3.js"></script>
</body>
</html>
