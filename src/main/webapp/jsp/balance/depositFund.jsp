
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <%@ include file="/inc/inc.jsp" %>
    <title><spring:message code="account.recharge"/></title>
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

            <!--右侧第二块-->
            <div class="right-list mt-0">
                <div class="right-list-title pb-10 pl-20">
                    <p><spring:message code="account.account.recharge"/></p>
                </div>
                <!--充值-->
                <form id="toPayForm" method="post" action="${_base}/p/balance/gotoPay">
                    <input type="hidden" name="currencyUnit" value="1">
                    <input type="hidden" id="payType" name="payOrgCode" value="YL">
                    <%--当前地址--%>
                    <input type="hidden" id="merchantUrl" name="merchantUrl">
                <div class="recharge mt-30">
                    <div class="recharge-content">
                        <div class="recharge-unionPay">
                            <ul>
                                <a href="#" id="YL"  class="current" onclick="changePayType(this)"><li class="unicon"></li></a>
                                <a href="#" id="ZFB"  style="margin-left: 50px" onclick="changePayType(this)"><li  class="zhifb"></li></a>
                            </ul>
                        </div>
                        <div class="recharge-form-label mt-50">
                            <ul>
                                <li>
                                    <p class="word"><spring:message code="account.account.to.be.recharged"/>:</p>
                                    <p>${loginName }</p>
                                </li>
                                <li>
                                    <p class="word"><spring:message code="account.amount.to.be.recharged"/>:</p>
                                    <p><input type="text" name="orderAmount" class="int-text int-rech-medium radius"></p>
                                    <p><spring:message code="account.yuan"/></p>
                                </li>
                                <li class="tishi">
                                    <p><spring:message code="account.tips"/></p>
                                    <p><spring:message code="account.tip1"/></p>
                                    <p><spring:message code="account.tip2"/></p>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <!--按钮-->
                    <div class="recharge-btn">
                        <input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="account.recharge.recharge"/>">
                    </div>
                </div>
                </form>

            </div>
        </div>
    </div>

</div>
<script type="text/javascript" src="${_base}/resources/template/scripts/modular/jquery-1.11.1.min.js"></script>
<%--
<script type="text/javascript" src="${_base}/resources/template/scripts/modular/frame.js"></script>
--%>
<script type="text/javascript" src="${_base}/resources/template/scripts/modular/eject.js"></script>
<%@include file="/inc/indexFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
    var current = "myaccount";
    (function () {
        var pager;
        seajs.use('app/jsp/balance/depositFund', function(depositFundPager) {
            pager = new depositFundPager({element : document.body});
            pager.render();
        });
    })();
    function changePayType(target) {
        var payType = target.id.valueOf();
        $("#payType").val(payType)
        $($(target).siblings()).removeClass("current");
        $(target).attr("class","current");
        $("#payType").val(target.id)
    }
</script>
</html>

