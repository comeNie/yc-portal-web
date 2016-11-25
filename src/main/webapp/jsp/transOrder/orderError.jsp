<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

    <%@ include file="/inc/inc.jsp" %>
    <!-- 订单报错<-->
    <title>订单报错</title>
</head>
<body>
<!--头部-->
<%@include file="/inc/transTopMenu.jsp"%>

<div class="cloud-container">
    <!--内侧内容区域-->
    <div class="cloud-wrapper">
        <!--左侧菜单-->
        <%@include file="/inc/transLeftmenu.jsp"%>
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
                            <li><img src="${uedroot}/images/rech-fail.png" /></li>
                            <li class="word"><spring:message code="myOrder.Systemerror" /> </li>
                            <li class="list mt-50">
                                <spring:message code="myOrder.errorInfoTrains" arguments="${_base}" />
                            </li>
                        </ul>
                    </div>

                </div>

            </div>
        </div>
    </div>
</div>
</body>
</html>
