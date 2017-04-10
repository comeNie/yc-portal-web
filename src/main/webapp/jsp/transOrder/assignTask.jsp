<%@ page import="com.ai.paas.ipaas.i18n.ZoneContextHolder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>译员-分配订单</title>
    <%@ include file="/inc/inc.jsp" %>
    <%--菜单定位--%>
    <script type="text/javascript">
        //一级菜单
        var current = "lookOrders";
        //二级菜单
        var divEleId = "assignTask";
    </script>
    <style type="text/css">
        .int-small{width:133px;height:26px;padding:0 10px;line-height:26px;font-size:12px;}
    </style>
</head>
<body>
<!--头部-->
<%@include file="/inc/transTopMenu.jsp" %>
<!--二级主体-->
<!--外侧背景-->
<div class="cloud-container">
    <!--内侧内容区域-->
    <div class="translate-cloud-wrapper">
        <!--左侧菜单-->
        <%@include file="/inc/transLeftmenu.jsp" %>
        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <!--右侧第二块-->
            <div class="right-list mt-0">
                <div class="right-list-title pb-10 pl-20">
                    <%--分配订单--%>
                    <p><spring:message code="assign.order.title"/></p>
                </div>
                <div class="oder-form-lable mt-20">
                    <form id="orderQuery">
                        <input type="hidden" name="interperId" value="<%=UserUtil.getUserId()%>">
                        <%--升降序标记--%>
                        <input type="hidden" name="sortFlag" id="sortFlag" value="0">
                        <%--升降序字段--%>
                        <input type="hidden" name="sortField" id="sortField" value="0">
                    <ul>
                        <li class="mb-20">
                            <%--翻译阶段--%>
                            <p class="none-left"><spring:message  code="assign.order.stage"/></p>
                            <p><select name="operType" id="stage" class="select select-small radius">
                                <%--全部--%>
                                <option value=""><spring:message code="task.center.select.all"/></option>
                                <%--翻译--%>
                                    <option value="0"><spring:message code="assign.order.stage.trans"/></option>
                                    <%--审校--%>
                                    <option value="1"><spring:message code="assign.order.stage.proofread"/></option>
                            </select></p>
                            <%--领域--%>
                            <p><spring:message  code="order.Fields"/></p>
                            <p><select name="fieldCode" id="fieldCode" class="select select-small radius">
                                <%--全部--%>
                                <option value=""><spring:message code="task.center.select.all"/></option>
                                <c:forEach var="obj" items="${domainList}">
                                    <option value="${obj.domainId}"><c:choose><c:when
                                            test="<%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>">${obj.domainCn}</c:when><c:otherwise>${obj.domainEn}</c:otherwise>
                                    </c:choose></option>
                                </c:forEach>
                            </select></p>
                            <%--用途--%>
                            <p><spring:message code="order.purpose"/></p>
                            <p><select name="useCode" id="useCode" class="select select-small radius">
                                <%--全部--%>
                                <option value=""><spring:message code="task.center.select.all"/></option>
                                <c:forEach var="obj" items="${purposeList}">
                                    <option value="${obj.purposeId}"><c:choose><c:when
                                            test="<%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>"
                                    >${obj.purposeCn}</c:when><c:otherwise>${obj.purposeEn}</c:otherwise>
                                    </c:choose></option>
                                </c:forEach>
                            </select></p>
                                <%--订单时间--%>
                            <p><spring:message code="task.center.order.date"/></p>
                            <p><input id="startDate" name="startDateStr" class="int-text int-small radius"
                                       readonly type="text"
                                      onfocus="WdatePicker({lang:'${my97Lang}',el:id,readOnly:true,
                                              dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')||\'%y-%M-%d\';}',
                                              onpicked:function(dp){_changeStartDate();}})"/>
                            </p>
                            <p>－</p>
                            <p><input id="endDate" name="endDateStr" class="int-text int-small radius"
                                      type="text" readonly
                                      onfocus="WdatePicker({lang:'${my97Lang}',el:id,readOnly:true,dateFmt:'yyyy-MM-dd',
                                      minDate:'#F{$dp.$D(\'startDate\');}',maxDate:'%y-%M-%d',
                                              onpicked:function(dp){_changeEndDate();}})"/>
                            </p>
                        </li>
                        <li class="mb-20">
                            <p class="iocn-oder right">
                                <%--订单主题--%>
                                <input type="text" name="translateName" class="int-text int-medium radius pr-30 in-x"
                                       maxlength="16" placeholder="<spring:message code="myOrder.inputContent"/>" >
                                <i class="icon-search" id="searchBtn"></i></p>
                        </li>
                    </ul>
                        </form>
                </div>

                <div class="right-list-table mt-0">
                    <table class="table table-hover table-bg">
                        <thead>
                        <tr id="headDiv">
                            <%--订单主题--%>
                            <th width="16.666%" class="dinda"><spring:message code="task.center.order.subject"/><i class="icon-caret-down"></i></th>
                                <%--翻译语言--%>
                                <th width="16.666%"><spring:message code="task.center.order.language"/></th>
                                <%--金额（元）--%>
                            <th width="16.666%"><spring:message code="task.center.order.amount"/><a href="javaScript:void(0);" id="feeSort"
                                                        sortFlag="0"><i class="icon iconfont" >&#xe615;</i></a></th>
                                <%--剩余时间--%>
                            <th width="16.666%"><spring:message code="task.center.time.remaining"/><a href="javaScript:void(0);" id="endSort"
                                                        sortFlag="0"><i class="icon iconfont" >&#xe615;</i></a></th>
                                <%--操作--%>
                            <th width="16.666%"><spring:message code="task.center.order.operate"/> </th>
                        </tr>
                        <div class="table-show">
                            <ul> <%--订单主题--%>
                                <li><a href="javaScript:void(0);"><spring:message code="task.center.order.subject"/></a></li>
                                <%--发布时间升序--%>
                                <li><a href="javaScript:void(0);" id="pdateAec"><spring:message code="task.center.release.time.asc"/> </a></li>
                                <%--发布时间降序--%>
                                <li><a href="javaScript:void(0);" id="pdateDesc"><spring:message code="task.center.release.time.desc"/> </a></li>
                            </ul>
                        </div>
                        </thead>
                    </table>
                </div>
                <div class="right-list-table" id="orderInfoTable">
                </div>
                <!-- 订单列表结束 -->
                <div id="showMessageDiv"></div>
                <div class="biu-paging paging-large">
                    <ul id="pagination-ul">
                    </ul>
                </div>
                <script id="searchOrderTemple" type="text/template">
                    <table class="table  table-bg tb-border mb-20">
                        <thead>
                        <tr>
                            <th colspan="6" class="text-l">
                                <div class="table-thdiv">
                                    <p>{{:~timestampToDate('yyyy-MM-dd hh:mm:ss',orderTime,'<%=ZoneContextHolder.getZone()%>')}}</p>
                                    <%--订单号--%>
                                    <p><spring:message code="task.center.order.id"/><span name="orderIdTh" orderId="{{:orderId}}" style="cursor:pointer;">{{:orderId}}</span></p>
                                </div>
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr class="width-16">
                            <td class="text-l pl-20" name="orderName" orderId="{{:orderId}}" style="cursor:pointer;">{{:translateName}}</td>
                            <td>{{if <%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>}}{{:languagePairName}}{{else}}{{:languageNameEn}}{{/if}}</td>
                            <td>
                                {{if currencyUnit == '1'}}
                                <spring:message code="task.center.rmbSame" arguments="{{:~liToYuan(totalFee)}}" />
                                {{else }}
                                <spring:message code="task.center.dollarSame" arguments="{{:~liToYuan(totalFee)}}" />
                                {{/if}}
                            </td>
                            <td><spring:message code="task.center.time.rest" arguments="{{:finishTakeDays}},{{:finishTakeHours}},{{:finishTakeMinutes}}"/></td>
                            <td  class="text-r">
                                <%--领取--%>
                                <input type="button" name="getOrder" orderId="{{:orderId}}"
                                       class="btn biu-btn btn-auto-25 btn-green radius10" value="<spring:message code='task.center.order.claim'/>">
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </script>
            </div>
        </div>
    </div>
</div>
<%@include file="/inc/userFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/jqueryrotate.2.3.js"></script>
<script type="text/javascript">
    var pager;
    var lspId="${lspId}";
    (function () {
        //订单详情 点击订单标题
        $('#orderInfoTable').delegate("td[name='orderName']", 'click', function () {
            var orderId = $(this).attr('orderId');
            window.location.href="${_base}/p/trans/order/"+orderId;
        });

        //订单详情 点击订单号
        $('#orderInfoTable').delegate("span[name='orderIdTh']", 'click', function () {
            var orderId = $(this).attr('orderId');
            window.location.href="${_base}/p/trans/order/"+orderId;
        });
        //订单领取
        $("#orderInfoTable").delegate("input[name='getOrder']", 'click', function () {
            var orderId = $(this).attr("orderId");
            window.location.href="${_base}/p/trans/order/"+orderId;
        });
        seajs.use('app/jsp/transOrder/assignTask', function (assignTaskPage) {
            pager = new assignTaskPage({element: document.body});
            pager.render();
        });
        $("input").placeholder();

    })();
    //时间变更处理
    function _changeStartDate() {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        //若时间发生变更且dateObj不为空,则刷新页面
        if (window.console){
            console.log("end:"+endDate+",start:"+startDate);
        }
        //结束时间不为空时，进行查询
        if(endDate!=null && endDate!=""){
            pager._getOrderList();
        }
    }
    //时间变更处理
    function _changeEndDate() {
        var startDate = $("#startDate").val();
        var endDate = $("#endDate").val();
        //若时间发生变更且dateObj不为空,则刷新页面
        if (window.console){
            console.log("start:"+startDate+"，end:"+endDate);
        }
        //开始时间不为空时，进行查询
        if(startDate !=null && startDate!=""){
            pager._getOrderList();
        }
    }
</script>
</html>
