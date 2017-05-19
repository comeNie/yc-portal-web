<%@page import="com.ai.yc.protal.web.constants.Constants"%>
<%@page import="com.ai.opt.sdk.components.ccs.CCSClientFactory"%>
<%@ page import="com.ai.paas.ipaas.i18n.ZoneContextHolder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <%@ include file="/inc/inc.jsp" %>
    <%--我的积分--%>
    <title><spring:message code="integral.credits"/></title>
</head>
<%
    //默认设置成1为开启，0为关闭
    String accountEnable="1";
    try{
        accountEnable=CCSClientFactory.getDefaultConfigClient().get(Constants.Account.CCS_PATH_ACCOUNT_ENABLE);
    }
    catch(Exception e){
        //获取配置出错，直接忽略，视为开启
    }
%>
<body>
<!--头部-->
<%@ include file="/inc/userTopMenu.jsp" %>
<!--二级主体-->
<!--外侧背景-->
<div class="cloud-container">
    <!--内侧内容区域-->
    <div class="cloud-wrapper">
        <!--左侧菜单-->
        <%@ include file="/inc/leftmenu.jsp"%>
        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <!--右侧第一块-->
            <div class="toptitle">
                <%--可用积分--%>
                <span><spring:message code="integral.credits"/>:</span><span class="text-danger">${integration}</span>
                <%--邀请好友送积分--%>
                <button class="btn-line btn-medium"><spring:message code="integral.sendCredits"/></button>
            </div>
            <!--右侧第二块-->
            <div class="right-list">
                <div class="tabs">
                    <ul class="tabs-anm">
                        <input type="hidden" id="flag" name="flag" value=""/>
                        <%--积分明细--%>
                        <li class="current" id="detai" onclick="incomeOut(detai)"><spring:message code="integral.detail"/></li>
                        <%--收入积分--%>
                        <li id="income" onclick="incomeOut(income)"><spring:message code="integral.incomeCredit"/></li>
                        <%--支出积分--%>
                        <li id="out" onclick="incomeOut(out)"><spring:message code="integral.outCredit"/></li>
                        <li class="line"></li>
                    </ul>
                </div>
                <div class="right-list-table">
                    <table class="table table-bg  table-striped-even table-height50">
                        <thead>
                        <tr>
                            <%--时间--%>
                            <th><spring:message code="integral.time"/></th>
                            <%--收入/支出--%>
                            <th><spring:message code="integral.incomeOut"/></th>
                            <%--详细说明--%>
                            <th><spring:message code="integral.detailExplain"/></th>
                        </tr>
                        </thead>
                        <tbody id="searchIntegralData"></tbody>
                    </table>
                </div>
                <div id="showIntegralDiv"></div>
                <!--分页-->
                <div class="biu-paging paging-large jifen">
                    <ul id="pagination-ul">
                    </ul>
                </div>
                <!--分页结束-->
            </div>
        </div>
    </div>
</div>
<%@include file="/inc/userFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script id="searchIntegralTemple" type="text/template">
    <tr>
        <td>{{:~timestampToDate('yyyy-MM-dd hh:mm:ss',logTime,'<%=ZoneContextHolder.getZone()%>')}}</td>
        <td class="red">
            {{if  integralValue > 0}}
            +{{:integralValue}}
            {{else}}
            {{:integralValue}}
            {{/if}}
        </td>
        <td>
            {{:integralSource}}
        </td>
    </tr>
</script>

<script type="text/javascript">
    var pager;
    var current = "integrals";
    (function () {
        seajs.use('app/jsp/integral/integral', function(integralListPage) {
            pager = new integralListPage({element : document.body});
            pager.render();
        });
    })();
    //收支
    function incomeOut(id) {
        if (id==detai){
            $("#flag").val("");
        }
        if(id==income){
            $("#flag").val("0");
        }
        if(id==out) {
            $("#flag").val("1");
        }
    }
</script>
</html>

