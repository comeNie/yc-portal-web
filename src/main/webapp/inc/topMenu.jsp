<%--
  Created by IntelliJ IDEA.
  User: jackieliu
  Date: 16/11/2
  Time: 下午2:17
  To change this template use File | Settings | File Templates.
  通用页头
--%>
<%@page import="java.util.Locale"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--主导航-->
<div class="placeorder-subnav-big">
    <div class="placeorder-subnav">
        <ul>
            <li class="logo"><a href="${_base}">
                <img src="${pageContext.request.contextPath}/resources/template/images/logo1<%= !Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())?"_en":""%>.png" /></a></li>
            <li class="right">
                <p><a href="#"><spring:message code="topMenue.home"/></a></p>
                <p><a href="#"><spring:message code="topMenue.written"/></a></p>
                <p><a href="#"><spring:message code="topMenue.oral"/></a></p>
                <p><a href="#"><spring:message code="topMenue.Services"/></a></p>
                <p><a href="#"><spring:message code="topMenue.APP"/></a></p>
                <p><a href="#"><spring:message code="topMenue.YeeCaption"/></a></p>
                <p><a href="#"><spring:message code="topMenue.YeeWeb"/></a></p>
                <p><a href="#"><spring:message code="topMenue.Club"/></a></p>
            </li>
        </ul>
    </div>
</div>