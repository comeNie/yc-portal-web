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
    <title><spring:message code="account.my.account"/></title>
    <style>
        .query-order ul .aright{float:right;}
        .query-order ul .aright p{margin-left:35px;display:inline;}
        .query-order ul .aright p a{color:#2361ea}
        .query-order ul .aright p i{color:#2361ea}
        .query-order ul .aright p i{margin-left:12px;}
    </style>
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
                <span>可用积分:</span><span class="text-danger">90207102</span>
                <button class="btn-line btn-medium">邀请好友送积分</button>
            </div>
            <!--右侧第二块-->
            <div class="right-list">
                <div class="tabs">
                    <ul class="tabs-anm">
                        <li class="current">积分明细</li>
                        <li>收入积分</li>
                        <li>支出积分</li>
                        <li class="line"></li>
                    </ul>
                </div>
                <div class="right-list-table">
                    <table class="table table-bg  table-striped-even table-height50">
                        <thead>
                        <tr>
                            <th>时间</th>
                            <th>收入/支出</th>
                            <th>详细说明</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>1987-11-04 08:18:08</td>
                            <td class="red">+$23.00</td>
                            <td>注册译云账户，赠送积分（注册时间：2015-04-07 09:53:51）</td>
                        </tr>
                        <tr>
                            <td>1987-11-04 08:18:08</td>
                            <td class="green">+$23.00</td>
                            <td>注册译云账户，赠送积分（注册时间：2015-04-07 09:53:51）</td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="biu-paging paging-large jifen">
                    <ul>
                        <li class="prev-up"><a href="#"><</a></li>
                        <li class="active"><a href="#">1</a></li>
                        <li><a href="#">2</a></li>
                        <li><a href="#">3</a></li>
                        <li><a href="#">4</a></li>
                        <li><a href="#">5</a></li>
                        <li><a href="#">6</a></li>
                        <li><a href="#">……</a></li>
                        <li><a href="#">100</a></li>
                        <li class="next-down"><a href="#">></a></li>
                        <p>
                            <span>到</span>
                            <span><input type="text" class="int-verysmall radius"></span>
                            <span>页</span>
                        </p>
                        <p class="taiz"><a href="#">跳转</a></p>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>

<%@include file="/inc/userFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript" src="${_base}/resources/template/scripts/modular/jquery-1.11.1.min.js"></script>
<%--<script type="text/javascript" src="${_base}/resources/template/scripts/modular/frame.js"></script>--%>
<script src="${_base}/resources/spm_modules/my97DatePicker/WdatePicker.js"></script>
<script id="searchAccountTemple" type="text/template">
    <%--<tbody>--%>
    <%--<input type="hidden" name="unit" value="{{:incomeFlag}}">
    <input type="hidden" name="unit" value="{{:optType}}">--%>
    <tr>
        <td >{{:~timestampToDate('yyyy-MM-dd hh:mm:ss',payTime,'<%=ZoneContextHolder.getZone()%>')}}</td>
        <td class="red" >
            {{if  incomeFlag == '1'}}
            +
            {{if  currencyUnit == '1'}}
            ¥
            {{else currencyUnit == '2'}}
            $
            {{/if}}
            {{:~liToYuan(totalAmount)}}
            {{else }}

            {{/if}}
        </td>
        <td class="green" >
            {{if  incomeFlag == '0'}}
            -
            {{if  currencyUnit == '1'}}
            ¥
            {{else currencyUnit == '2'}}
            $
            {{/if}}
            {{:~liToYuan(-totalAmount)}}
            {{else }}

            {{/if}}
        </td><%--{{:~liToYuan()}}--%>
        <td >
            {{if  currencyUnit == '1'}}
            ¥
            {{else currencyUnit == '2'}}
            $
            {{/if}}
            {{:~liToYuan(balancePre)}}
        </td>
        <td>
            {{if  optType == '1'}}
            <spring:message code="account.recharge"/>
            {{else optType == '2'}}
            <spring:message code="account.place.order"/>
            {{else optType == '3'}}
            <spring:message code="account.withdraw.cash"/>
            {{else optType == '4'}}
            <spring:message code="account.refund"/>
            {{/if}}
        </td>
        <td>
            {{if channel!=null && channel.length > 8}}
            {{:~subStr(8,channel)}}
            {{else}}
            {{:channel}}
            {{/if}}
        </td>
        <td>
            {{if remark!=null && remark.length > 8}}
            {{:~subStr(8,remark)}}
            {{else}}
            {{:remark}}
            {{/if}}
        </td>
    </tr>
    <%--</tbody>--%>
</script>

<script type="text/javascript">
    var pager;
    var current = "integrals";
    (function () {
        seajs.use('app/jsp/balance/account', function(accountListPage) {
            pager = new accountListPage({element : document.body});
            pager.render();
        });
    })();
</script>
</html>

