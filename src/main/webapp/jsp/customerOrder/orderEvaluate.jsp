<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />

    <%@ include file="/inc/inc.jsp" %>
    <!-- 评价订单 -->
    <title><spring:message code="myOrder.EvaluationOrder"/></title>

    <style>
        .star {cursor:pointer}
    </style>
</head>
<body>
<!--弹出-->
<div class="eject-big">
    <div class="prompt-samll"  id="evaluate-password" style="display:none;">
        <%--评价成功--%>
        <div class="prompt-samll-title"><spring:message code="order.evaluate.prompt.title.success"/></div>
        <!--确认删除-->
        <div class="prompt-samll-confirm">
            <ul class="pass-list">
                <%--感谢您的评价！--%>
                <li><spring:message code="order.evaluate.prompt.msg.success"/></li>
                <li class="eject-btn">
                    <%--确定--%>
                    <input type="button" id="evaluate-determine" class="btn btn-green btn-120 radius20"
                           value="<spring:message code="order.evaluate.prompt.okbtn"/> ">
                </li>
            </ul>
        </div>
    </div>
    <div class="mask" id="eject-mask"  style="display:none;"></div>
</div>
<!--/弹出结束-->
<input id="orderId" type="hidden" value="${orderId}"/>
<!--头部-->
<%@include file="/inc/userTopMenu.jsp"%>
<!--二级主体-->
<!--外侧背景-->
<div class="cloud-container">
    <!--内侧内容区域-->
    <div class="cloud-wrapper">
        <!--左侧菜单-->
        <%@include file="/inc/leftmenu.jsp"%>
        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <!--右侧第一块-->

            <!--右侧第二块-->
            <div class="right-list mt-0">
                <div class="right-list-title pb-10 pl-20">
                    <%--评价订单--%>
                    <p><spring:message code="myOrder.EvaluationOrder"/></p>
                </div>
                <div class="evaluate">
                    <ul>
                        <li>
                            <%--服务质量--%>
                            <p class="title"><spring:message code="myOrder.ServiceQuality"/>：</p>
                            <p id="serviceQuality">
                                <span><img class="star" name="star1" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star2" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star3" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star4" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star5" src="${uedroot}/images/xx-02.jpg"></span>
                            </p>
                        </li>
                        <li>
                            <%--服务速度--%>
                            <p class="title"><spring:message code="myOrder.ServiceSpeed"/>：</p>
                            <p id="serviceSpeed">
                                <span><img class="star" name="star1" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star2" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star3" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star4" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star5" src="${uedroot}/images/xx-02.jpg"></span>
                            </p>
                        </li>
                        <li>
                            <%--服务态度--%>
                            <p class="title"><spring:message code="myOrder.ServiceAttitude"/>：</p>
                            <p id="serviceAttitude">
                                <span><img class="star" name="star1" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star2" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star3" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star4" src="${uedroot}/images/xx-02.jpg"></span>
                                <span><img class="star" name="star5" src="${uedroot}/images/xx-02.jpg"></span>
                            </p>
                        </li>
                        <li>
                            <p class="title"><spring:message code="myOrder.EvaluationContent"/>：</p>
                            <p class="word">
                                <textarea id="evaluateContent" class="int-text textarea-big-xlarge"
                                          onkeyup="textLimit(this,200);" onkeydown="textLimit(this,200);"
                                          oninput="textLimit(this,200);"  onpropertychange="textLimit(this,200);"
                                ></textarea>
                            </p>
                        </li>
                    </ul>
                </div>
                <!--按钮-->
                <div class="recharge-btn order-btn">
                    <input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="<spring:message code="myOrder.Evaluation"/>" id="evaluate-btn">
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="/inc/incJs.jsp" %>
<script src="${_base}/resources/template/scripts/modular/eject.js"></script>

<script type="text/javascript">
    var pager;
    (function () {
        seajs.use('app/jsp/customerOrder/orderEvaluate', function (orderInfoPage) {
            pager = new orderInfoPage({element: document.body});
            pager.render();
        });

        $("#serviceQuality img").click(function () {
            pager._clickSatr(this);
        });

        $("#serviceSpeed img").click(function () {
            pager._clickSatr(this);
        });

        $("#serviceAttitude img").click(function () {
            pager._clickSatr(this);
        });

        //IE8的输入框提示信息兼容
        $("input,textarea").placeholder();
    })();

    function textLimit(field, maxlimit) {
        // 函数，3个参数，表单名字，表单域元素名，限制字符；
        if (field.value.length > maxlimit){
            //如果元素区字符数大于最大字符数，按照最大字符数截断；
            field.value = field.value.substring(0, maxlimit);
        }
    }
</script>
</body>
</html>