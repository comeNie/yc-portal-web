<%@page import="com.ai.yc.protal.web.constants.Constants"%>
<%@page import="com.ai.opt.sdk.components.ccs.CCSClientFactory"%>
<%@ page import="com.ai.paas.ipaas.i18n.ZoneContextHolder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <%--我的帐户--%>
    <%@ include file="/inc/inc.jsp" %>
    <title>译员-LSP账单</title>
</head>
<body>
<!--头部-->
<%@ include file="/inc/transTopMenu.jsp" %>
<!--二级主体-->
<!--外侧背景-->
<div class="cloud-container">
    <!--内侧内容区域-->
    <div class="translate-cloud-wrapper">
        <!--左侧菜单-->
        <%@ include file="/inc/transLeftmenu.jsp"%>
        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper translater-lsp-account">
            <div class="right-list">
                <div class="right-list-title pb-10 pl-20">
                    <p>工作记录</p>
                </div>
            <form id="accountQuery" action="">
                <div class="query-order" id="dates">
                    <ul>
                        <li class="left">
                            <%--今天--%>
                            <p><a href="#" id="today" onclick="todate(this,today)"><spring:message code="account.today"/></a></p>
                            <%--近一个月--%>
                            <p class="current"><a href="#" id="oneMonth" onclick="todate(this,oneMonth)"><spring:message code="account.one.month"/></a></p>
                            <%--近三个月--%>
                            <p><a href="#" id="threeMonth" onclick="todate(this,threeMonth)"><spring:message code="account.three.months"/></a></p>
                            <%--近一年--%>
                            <p><a href="#" id="oneyear" onclick="todate(this,oneyear)"><spring:message code="account.one.year"/></a></p>
                        </li>
                        <li class="right">
                            <p><spring:message code="account.income"/>:<span id="income" style="font-size: 12px;line-height: 25px"></span></p>
                            <p><spring:message code="account.expenditure"/>:<span id="out" style="font-size: 12px;line-height: 25px"></span></p>
                            <p><a href="#" class="is" id="screen-a">高级筛选</a><a href="#" class="is" id="screen-b" style="display:none;">收起筛选</a><i class="icon-angle-down"></i></p>
                        </li>
                    </ul>
                </div>
                <div class="query-order order-hiddn">
                    <ul>
                        <li class="left li-xlarge li-xlarge-ml">
                            <%--起止时间--%>
                            <p><a href="#">起止时间</a></p>
                            <p><input style="width: 140px" id="beginDate" name="beginDate" type="text" value="${beginTime}" class="int-text int-small radius" onClick="WdatePicker({lang:'${my97Lang}',readOnly:true,dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',onpicked:function(dp){begintime();}})"></p>
                            <p>~</p>
                            <p><input style="width: 140px" id="endDate" name="endDate" type="text" value="${endTime}" class="int-text int-small radius" onClick="WdatePicker({lang:'${my97Lang}',readOnly:true,dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'beginDate\')}',maxDate:'%y-%M-%d',onpicked:function(dp){endtime();}})"></p>
                        </li>
                        <li class="left li-xlarge" id="incomes">
                            <input type="hidden" id="incomeFlag" name="incomeFlag" value=""/>
                        <%--收支--%>
                            <p><spring:message code="account.income.expense"/>:</p>
                            <%--全部--%>
                            <p class="current"> <a id="all" aval="" href="#" onclick="shouzhi(this)"> <spring:message code="account.all"/> </a></p>
                            <%--收入--%>
                            <p><a href="#" id="shouru" aval="1" onclick="shouzhi(this)"><spring:message code="account.income"/></a></p>
                            <%--支出--%>
                            <p><a href="#" id="zhichu" aval="0" onclick="shouzhi(this)"><spring:message code="account.expenditure"/></a></p>
                        </li>
                        <li class="left li-xlarge" id="types">
                            <input type="hidden" id="optType" name="optType" value=""/>
                        <%--类型--%>
                            <p><spring:message code="account.type"/>:</p>
                                <%--全部--%>
                            <p class="current"><a href="#" id="allType" aval="" onclick="totype(this)"><spring:message code="account.all"/> </a></p>
                                <%--接单--%>
                            <p><a href="#" id="jiedan" aval="5" onclick="totype(this)">接单</a></p>
                                <%--退款--%>
                            <p><a href="#" id="tuikuan" aval="4" onclick="totype(this)">退款</a></p>
                                <%--译员支出--%>
                            <p><a href="#" id="transFee" aval="6" onclick="totype(this)">译员支出</a></p>
                                <%--平台佣金--%>
                            <p><a href="#" id="platFee" aval="7" onclick="totype(this)">平台佣金</a></p>
                        </li>
                    </ul>
                </div>
            </form>
                <div class="right-list-table">
                    <table class="table table-bg  table-striped-even table-height50">
                        <thead>
                        <tr>
                            <th>时间</th>
                            <th>收入</th>
                            <th>支出</th>
                            <th>类型</th>
                            <th>详细说明</th>
                        </tr>
                        </thead>
                        <tbody id="searchAccountData"></tbody>
                    </table>
                </div>
                <!-- 订单列表结束 -->
                <div id="showAccountDiv"></div>
                <div class="biu-paging paging-large jifen">
                    <ul id="pagination-ul">
                    </ul>
                </div>
            </div>

        </div>
    </div>
</div>

<%@include file="/inc/userFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script src="${_base}/resources/spm_modules/my97DatePicker/WdatePicker.js"></script>

<script id="searchAccountTemple" type="text/template">
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
        <td>
            {{if  optType == '5'}}
            接单
            {{else optType == '6'}}
            译员支出
            {{else optType == '7'}}
            平台佣金
            {{else optType == '4'}}
            退款
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
<script style="text/javascript">
    var pager;
    var current = "lspBill";
    (function () {
        seajs.use('app/jsp/lspBill/lspBill', function(accountListPage) {
            pager = new accountListPage({element : document.body});
            pager.render();
        });
    })();
    //选择结束时间触发
    function endtime() {
        pager._incomeList();
    }
    //选择开始时间触发
    function begintime() {
        pager._incomeList();
    }

    function todate(target,id) {
        var cc = $(target).parent().attr("class");
        if (cc!=null){
            return;
        }
        if (id==today){
            $("#beginDate").val(new Date().format("yyyy-MM-dd"));
            $("#endDate").val(new Date().format("yyyy-MM-dd"));
        }
        if(id==oneMonth){
            var begdate = new Date();
            begdate.setMonth(begdate.getMonth()-1);
            $("#beginDate").val(begdate.format("yyyy-MM-dd"));
            $("#endDate").val(new Date().format("yyyy-MM-dd"));
        }
        if(id==threeMonth){
            var begdate = new Date();
            var date = begdate;
            begdate.setMonth(begdate.getMonth()-3);
            $("#beginDate").val(begdate.format("yyyy-MM-dd"));
            $("#endDate").val(new Date().format("yyyy-MM-dd"));
        }
        if(id==oneyear){
            var begdate = new Date();
            begdate.setYear(begdate.getFullYear()-1);
            $("#beginDate").val(begdate.format("yyyy-MM-dd"));
            $("#endDate").val(new Date().format("yyyy-MM-dd"));
        }
        $("#dates p").each(function(){
            $(this).attr("class",null);
        });
        $(target).parent().attr("class","current");
    }
    //收支切换
    function shouzhi(target) {
        var cc = $(target).parent().attr("class");
        var aval = $(target).attr("aval");
//        alert(aval);
        if (cc!=null){
            return;
        }
        $("#incomes p").each(function(){
            $(this).attr("class",null);
        });
        $(target).parent().attr("class","current");
        $("#incomeFlag").val(aval);
        //收支,类型联动
        if (aval=='1'){
            if($("#platFee").parent().attr("class")=="current"||$("#transFee").parent().attr("class")=="current"){
                $("#allType").parent().attr("class","current");
                var aval = $("#allType").attr("aval");
                $("#optType").val(aval);
                pager._incomeList();
            }
            $("#platFee").removeAttr('onclick');
            $("#transFee").removeAttr('onclick');
            $("#tuikuan").parent().hide();
            $("#platFee").parent().hide();
            $("#transFee").parent().hide();
            $("#jiedan").parent().show();
            $("#jiedan").attr("onclick","totype('#jiedan');");
            $("#jiedan").parent().attr("class",null);
        }else if (aval=='0'){
            if($("#jiedan").parent().attr("class")=="current"||$("#tuikuan").parent().attr("class")=="current"){
                $("#allType").parent().attr("class","current");
                var aval = $("#allType").attr("aval");
                $("#optType").val(aval);
                pager._incomeList();
            }
            $("#tuikuan").parent().show()
            $("#tuikuan").attr("onclick","totype('#tuikuan');");
            $("#jiedan").removeAttr('onclick');
            $("#jiedan").parent().hide();
            $("#platFee").parent().show();
            $("#transFee").parent().show();
            $("#platFee").attr("onclick","totype('#platFee');");
            $("#transFee").attr("onclick","totype('#transFee');");//current-hid
            $("#platFee").parent().attr("class",null);
            $("#transFee").parent().attr("class",null);
        }else {
            $("#jiedan").parent().show();
            $("#tuikuan").parent().show();
            $("#platFee").parent().show();
            $("#transFee").parent().show();
            $("#jiedan").attr("onclick","totype('#jiedan');");
            $("#tuikuan").attr("onclick","totype('#tuikuan');");
            $("#platFee").attr("onclick","totype('#platFee');");
            $("#transFee").attr("onclick","totype('#transFee');");
            $("#jiedan").parent().attr("class",null);
            $("#tuikuan").parent().attr("class",null);
            $("#platFee").parent().attr("class",null);
            $("#transFee").parent().attr("class",null);
        }
        pager._incomeList();
    }
    //类型切换
    function totype(target) {
        var cc = $(target).parent().attr("class");
        var aval = $(target).attr("aval");
//        alert(aval);
        $("#optType").val(aval);
        if (cc!=null){
            return;
        }
        $("#types p").each(function(){
            var current = $(this).attr("class");
            if (current=="current"){
                $(this).attr("class",null);
            }
        });
        $(target).parent().attr("class","current");
        pager._incomeList();
    }
</script>
</html>

