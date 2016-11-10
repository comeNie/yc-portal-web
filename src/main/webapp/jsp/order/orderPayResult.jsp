<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>支付页成功</title>
    <%@ include file="/inc/inc.jsp" %>
</head>
<body>
<!--面包屑导航-->
<%@ include file="/inc/topHead.jsp" %>
<!--主导航-->
<%@ include file="/inc/topMenu.jsp" %>
<!--主体-->
<div class="placeorder-container">
    <div class="placeorder-wrapper">
        <!--步骤-->
        <div class="place-bj">
            <div class="place-step">
                <!--进行的状态-->
                <div class="place-step-none adopt-wathet-bj">
                    <ul>
                        <li class="circle"><i class="icon iconfont">&#xe60f;</i></li>
                        <%--翻译内容--%>
                        <li class="word"><spring:message code="order.translateLan"/></li>
                    </ul>
                    <p class="line"></p>
                </div>
                <!--未进行的状态-->
                <div class="place-step-none adopt-wathet-bj">
                    <ul>
                        <li class="circle"><i class="icon iconfont">&#xe60d;</i></li>
                        <%--填写联系方式--%>
                        <li class="word"><spring:message code="order.contact"/></li>
                    </ul>
                    <p class="line"></p>
                </div>
                <!--未进行的状态-->
                <div class="place-step-none adopt-blue-bj">
                    <ul>
                        <li class="circle"><i class="icon iconfont">&#xe608;</i></li>
                        <%--支付--%>
                        <li class="word"><spring:message code="order.payment"/></li>
                    </ul>
                    <p class="line"></p>
                </div>
            </div>
        </div>
        <!--白色背景-->
        <div class="white-bj   pdd-150">
            <div class="recharge-success">
                <ul>
                    <c:choose>
                        <c:when test="${payResult == '1'}">
                            <li><img src="${uedroot}/images/rech-win.png" /></li>
                            <li class="word">充值成功</li>
                        </c:when>
                        <c:otherwise>
                            <li><img src="${uedroot}/images/rech-fail.png" /></li>
                            <li class="word">充值失败</li>
                        </c:otherwise>
                    </c:choose>
                    <li class="list mt-50">
                        <p>请您牢记充值单号： <a href="#">${orderId}</a>,您可以在“<a href="${_base}/p/customer/order/list/view">我的订单</a>”中查看您的充值信息</p>
                        <p>若有任何疑问，欢迎致电咨询：400-119-8080</p>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>
</body>
</html>
