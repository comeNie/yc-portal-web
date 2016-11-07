<%--
  Created by IntelliJ IDEA.
  User: jackieliu
  Date: 16/11/4
  Time: 下午9:12
  To change this template use File | Settings | File Templates.
--%>
<%@page import="java.util.Locale"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--面包屑导航-->
<div class="placeorder-breadcrumb-big">
    <div class="placeorder-breadcrumb">
        <ul>
            <%--<li class="left"><i class="icon-volume-off"></i><A href="#">网站公告栏，通知网站各种事件</A></li>--%>
            <li class="right">
                <p><a href="#"><spring:message code="topMenue.Login"/></a><a href="#" class="blue"><spring:message code="topMenue.Regist"/></a></p>
                <%--我的订单--%>
                <p><a href="${_base}/p/customer/order/list/view"><spring:message code="topMenue.myOrder"/></a></p>
                <p><a href="#"><spring:message code="topMenue.Customers"/></a></p>
                <p><a href="#"><spring:message code="topMenue.Suppliers"/></a></p>
                <p class="none-border"><i class="icon iconfont">&#xe60b;</i><a href="#"><spring:message code="topMenue.Mobile"/></a></p>
                <p class="none-border none-top">
                    <select id="langHeadSel" class="select select-topmini none-select ash-select"
                            onchange="changeLang()">
                        <option value="<%= Locale.SIMPLIFIED_CHINESE%>">简体中文</option>
                        <option value="<%= Locale.US%>"
                                <%= !Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())?"selected":""%>
                        >ENGLISH</option>
                    </select>
                    <i class="icon-caret-down"></i>
                </p>
            </li>
        </ul>
    </div>
</div>
<script type="application/javascript">
    function changeLang(){
        var toLang = document.getElementById("langHeadSel").value;
        if (window.console){
            console.log("the new lange is "+toLang);
        }
        var nowUrl = window.location.href;
        var lInd = nowUrl.indexOf("lang=");
        //已存在
        if (lInd>0){
            var i = nowUrl.indexOf("&",lInd);
            var endStr = i>0?nowUrl.substring(i):"";
            nowUrl = nowUrl.substring(0,lInd)+"lang="+toLang+endStr;
        }//不存在
        else if(nowUrl.indexOf("?")>0){
            nowUrl = nowUrl + "&lang="+toLang;
        }else {
            nowUrl = nowUrl + "?lang="+toLang;
        }

        window.location.replace(nowUrl);//刷新当前页面
    }
</script>