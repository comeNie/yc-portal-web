<%@ page import="com.ai.paas.ipaas.i18n.ZoneContextHolder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <%--我的帐户--%>
    <%@ include file="/inc/inc.jsp" %>
    <title><spring:message code="account.my.account"/></title>
</head>
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
            <div class="right-title">
                <div class="right-title-left user-account-title">
                    <div class="right-title-left-word user-account-title-word">
                        <ul>
                            <li class="user-word"><spring:message code="account.balance"/></li>
                        </ul>
                        <ul>
                            <li class="word"><span>${balance}</span>
                                <c:choose>
                                    <c:when test="${currencyUnit==2}">
                                        <spring:message code="account.dollar"/>
                                    </c:when>
                                    <c:otherwise><spring:message code="account.yuan"/></c:otherwise>
                                </c:choose>
                            </li>
                            <% if(Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())){ %>
                            <li class="c-bj-bule"><a href="${_base}/p/balance/depositFund"><spring:message code="account.recharge"/></a></li>
                            <% } %>
                        </ul>
                        <ul class="word-li">
                            <li><spring:message code="account.claim"/></li>
                        </ul>
                    </div>
                </div>
                <div class="user-title-right"><img src="${uedroot}/images/user-bj.jpg" /></div>
            </div>
            <!--右侧第二块-->
            <form id="accountQuery" action="">

            <div class="right-list">
                <div class="query-order" id="dates">
                    <ul>
                        <li class="left">
                            <p><a href="#" id="today" onclick="todate(this,today)"><spring:message code="account.today"/></a></p>
                            <p class="current"><a href="#" id="oneMonth" onclick="todate(this,oneMonth)"><spring:message code="account.one.month"/></a></p>
                            <p><a href="#" id="threeMonth" onclick="todate(this,threeMonth)"><spring:message code="account.three.months"/></a></p>
                            <p><a href="#" id="oneyear" onclick="todate(this,oneyear)"><spring:message code="account.one.year"/></a></p>
                        </li>
                        <li class="right">
                            <p><spring:message code="account.income"/>:<span id="income" style="font-size: 12px;line-height: 25px"></span></p>
<%--
                            <p id="income" val=""></p>
--%>
                            <p><spring:message code="account.expenditure"/>:<span id="out" style="font-size: 12px;line-height: 25px"></span></p>
<%--
                            <p id="out" val=""></p>
--%>
                            <%--<p id="income"></p>
                            <p id="out"></p>--%>
                            <p><a href="#" class="is"><spring:message code="account.advanced.screening"/><i class="icon-angle-down"></i></a></p>
                        </li>
                    </ul>
                </div>

                <div class="query-order order-hiddn">
                    <ul>
                        <li class="left li-xlarge li-xlarge-ml">
                            <p><a href="#"><spring:message code="account.starting.endingtime"/></a></p>
                            <p><input style="width: 140px" id="beginDate" name="beginDate" type="text" value="" class="int-text int-small radius" onClick="WdatePicker({lang:'${my97Lang}',dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',onpicked:function(dp){begintime();}})" readonly="readonly"></p>
                            <p>~</p>
                            <p><input style="width: 140px" id="endDate" name="endDate" type="text" class="int-text int-small radius" onClick="WdatePicker({lang:'${my97Lang}',dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'beginDate\')}',onpicked:function(dp){endtime();}})" readonly="readonly"></p>
                        </li>
                        <li class="left li-xlarge" id="incomes">
                            <input type="hidden" id="incomeFlag" name="incomeFlag" value=""/>
                            <p><spring:message code="account.income.expense"/>:</p>
                            <p class="current"> <a id="all" aval="" href="#" onclick="shouzhi(this)"> <spring:message code="account.all"/> </a></p>
                            <p><a href="#" id="shouru" aval="1" onclick="shouzhi(this)"><spring:message code="account.income"/></a></p>
                            <p><a href="#" id="zhichu" aval="0" onclick="shouzhi(this)"><spring:message code="account.expenditure"/></a></p>
                        </li>
                        <li class="left li-xlarge" id="types">
                            <input type="hidden" id="optType" name="optType" value=""/>
                            <p><spring:message code="account.type"/>:</p>
                            <p class="current"><a href="#" id="allType" aval="" onclick="totype(this)"><spring:message code="account.all"/> </a></p>
                            <p><a href="#" id="chongzhi" aval="1" onclick="totype(this)"><spring:message code="account.recharge"/></a></p>
                            <p><a href="#" id="tixian" aval="3" onclick="totype(this)"><spring:message code="account.withdraw.cash"/></a></p>
                            <p><a href="#" id="xiadan" aval="2" onclick="totype(this)"><spring:message code="account.place.order"/></a></p>
                            <p><a href="#" id="tuikuan" aval="4" onclick="totype(this)"><spring:message code="account.refund"/></a></p>
                        </li>
                    </ul>
                </div>

                <div class="right-list-table">
                    <table class="table table-bg  table-striped-even table-height50">
                        <thead>
                        <tr>
                            <th style="width: 200px"><spring:message code="account.time"/></th>
                            <th style="width: 108px"><spring:message code="account.income"/>( <c:choose>
                                <c:when test="${currencyUnit==2}">
                                    <spring:message code="account.dollar"/>
                                </c:when>
                                <c:otherwise><spring:message code="account.yuan"/></c:otherwise>
                            </c:choose>)</th>
                            <th style="width: 134px"><spring:message code="account.expenditure"/>( <c:choose>
                                <c:when test="${currencyUnit==2}">
                                    <spring:message code="account.dollar"/>
                                </c:when>
                                <c:otherwise><spring:message code="account.yuan"/></c:otherwise>
                            </c:choose>)</th>
                            <th style="width: 125px"><spring:message code="balance"/></th>
                            <th style="width: 52px"><spring:message code="account.type"/></th>
                            <th style="width: 78px"><spring:message code="account.counterpart"/></th>
                            <th ><spring:message code="account.detailed.instruction"/></th>
                        </tr>
                        </thead>

                    </table>

                </div>
                <!-- 订单列表 -->
                <div class="right-list-table" id="searchAccountData">
                </div>
                <!-- 订单列表结束 -->
                <div id="showAccountDiv"></div>
                <!--分页-->
                <div class="biu-paging paging-large">
                    <ul id="pagination-ul">
                    </ul>
                </div>
                <!--分页结束-->
            </div>
            </form>
        </div>
    </div>
</div>
<script type="text/javascript" src="${_base}/resources/template/scripts/modular/jquery-1.11.1.min.js"></script>
<%--<script type="text/javascript" src="${_base}/resources/template/scripts/modular/frame.js"></script>--%>
<script src="${_base}/resources/spm_modules/my97DatePicker/WdatePicker.js"></script>
<%@include file="/inc/indexFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script id="searchAccountTemple" type="text/template">
    <table class="table table-bg  table-striped-even table-height50">
        <tbody>
        <input type="hidden" name="unit" value="{{:incomeFlag}}">
        <input type="hidden" name="unit" value="{{:optType}}">
        <tr>
            <td style="width: 200px">{{:~timestampToDate('yyyy-MM-dd hh:mm:ss',payTime,'<%=ZoneContextHolder.getZone()%>')}}</td>
            <td class="red" style="width: 108px;size: 18px">
                {{if  incomeFlag == '1'}}
                +{{:~liToYuan(totalAmount)}}
                {{else }}
                0
                {{/if}}
            </td>
            <td class="green" style="width: 134px">
                {{if  incomeFlag == '0'}}
                -{{:~liToYuan(-totalAmount)}}
                {{else }}
                    0
                {{/if}}
            </td><%--{{:~liToYuan()}}--%>
            <td style="width: 125px">{{:~liToYuan(balancePre)}}</td>
            <td style="width: 52px">
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
            <td style="width: 78px">{{:channel}}</td>
            <td>{{:remark}}</td>
        </tr>
        </tbody>
    </table>
</script>

<script type="text/javascript">
    var pager;
    var current = "myaccount";
    (function () {
        seajs.use('app/jsp/balance/account', function(accountListPage) {
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
    }
    //日期切换
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
            $(this).attr("class",null);
        });
        $(target).parent().attr("class","current");
    }

</script>
</html>

