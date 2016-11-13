<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>订单详细</title>
    <%@ include file="/inc/inc.jsp" %>
</head>
<body>
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
        	<input type="hidden" id="orderId" value="${OrderDetails.orderId}">
            <div class="breadcrumb">
                <p>我的订单></p>
                <p>订单：${OrderDetails.orderId}</p>
            </div>
           	 <!--订单详细待确认-->
           	 <%@include file="/jsp/customerOrder/orderStep.jsp"%>
            <!--订单table-->
            <div class="confirmation-table mt-20">
                <div class="oder-table">
                    <ul>
                        <li><a href="javaScript:void(0);" class="current">翻译内容</a></li>
                        <li><a href="javaScript:void(0);">订单跟踪</a></li>
                    </ul>
                </div>
                <div id="translate1">
                    <div class="confirmation-list">
                        <ul>
                            <li class="title">原文:</li>
                            <li class="word">${OrderDetails.prod.needTranslateInfo}<A href="javaScript:void(0);">[更多]</A></li>
                        </ul>
                        <ul class="mt-30">
                            <li class="title">译文:</li>
                            <li class="word">${OrderDetails.prod.translateInfo}<A href="javaScript:void(0);">[更多]</A></li>
                        </ul>
                    </div>
                </div>
                <div id="translate2" style="display: none;">
                    <div class="tracking-list">
                        <ul>
                          <c:forEach items="${OrderDetails.orderStateChgs}" var="stateChg">
                          	  <li  class="conduct">
                                <p>${stateChg.stateChgTime}</p>
                                <p class="right">${stateChg.chgDesc}</p>
                              </li>
                       	   </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <!--订单内容-->
            <div class="oder-detailed">
                <div class="right-list-title pb-10 pl-20">
                    <p>订单详细</p>
                </div>
                <div class="oder-information">
                    <div class="info-list">
                        <span>订单信息</span>
                        <ul>
                             <li>
                                <p class="word">订单号:</p>
                                <p>${OrderDetails.orderId}</p>
                            </li>
                            <li>
                                <p class="word">翻译主题:</p>
                                <p>${OrderDetails.translateName}</p>
                            </li>
                            <li>
                                <p class="word">翻译语言:</p>
                                <p>
                                	<c:forEach items="${OrderDetails.prodExtends}" var="prodExtends">
                                		${prodExtends.langungePairName}
                                	</c:forEach>
                                </p>
                            </li>
                            <li>
                                <p class="word">翻译级别:</p>
                                <p>
                                	<c:forEach items="${OrderDetails.prodLevels}" var="prodLevels">
                                		${prodLevels.translateLevel}
                                	</c:forEach>
                                </p>
                            </li>
                             <li>
                                <p class="word">用途:</p>
                                <p>${OrderDetails.prod.useCn}</p>
                            </li>
                            <li>
                                <p class="word">领域:</p>
                                <p>${OrderDetails.prod.fieldCn}</p>
                            </li>
                            <li>
                                <p class="word">创建时间:</p>
                                <p>meixie</p>
                            </li>
                            <li>
                                <p class="word">预计翻译耗时:</p>
                                <p>${OrderDetails.prod.takeTime}小时</p>
                            </li>
                            <li>
                                <p class="word">其他:</p>
                                <p><c:if test="${OrderDetails.prod.isUrgent == '1'}">
                                	加急;
                                	</c:if>
                                	<c:if test="${OrderDetails.prod.isSetType == '1'}">
                                	需要排版
                                	</c:if>
                                </p>
                            </li>
                            <li class="width-large">
                                <p class="word">需求备注:</p>
                                <p class="p-large">${OrderDetails.remark}</p>
                            </li>
                        </ul>
                    </div>
                    <div class="info-list">
                        <span>订单金额</span>
                        <ul>
                            <li class="width-large">
                                <p class="word">订单金额:</p>
                                <p>${OrderDetails.orderFee.paidFee}
                               		<c:if test="${OrderDetails.orderFee.currencyUnit =='1'}">元</c:if>
                               		<c:if test="${OrderDetails.orderFee.currencyUnit =='2'}">美元</c:if></p>
                            </li>
                            <!--  
                            <li class="width-large">
                                <p class="word">折扣:</p>
                                <p>9.0折</p>
                            </li>
                            <li class="width-large">
                                <p class="word">优惠券:</p>
                                <p>-</p>
                            </li>
                            -->
                            <li class="width-large">
                                <p class="word">优惠码:</p>
                                <p>${OrderDetails.orderFee.discountFee}
                               		<c:if test="${OrderDetails.orderFee.currencyUnit =='1'}">元</c:if>
                               		<c:if test="${OrderDetails.orderFee.currencyUnit =='2'}">美元</c:if></p>
                            </li>
                            <li class="width-large red">
                                <p class="word">实付金额:</p>
                                <p><b>${OrderDetails.orderFee.paidFee}
                               		</b><c:if test="${OrderDetails.orderFee.currencyUnit =='1'}">元</c:if>
                               		<c:if test="${OrderDetails.orderFee.currencyUnit =='2'}">美元</c:if>
                               	</p>
                            </li>
                        </ul>
                    </div>
                    <div class="info-list">
                        <span>联系人信息</span>
                        <ul>
                            <li class="width-large">
                                <p>${OrderDetails.contacts.contactName}，${OrderDetails.contacts.contactTel}，${OrderDetails.contacts.contactEmail}</p>
                            </li>
                        </ul>
                    </div>
                    <div class="info-list">
                        <span>发票</span>
                        <ul>
                            <li class="width-large">
                                <p class="word">发票类型:</p>
                                <p>不开发票</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <!--按钮-->
                <div class="recharge-btn order-btn">
                	<c:choose>
	                	<c:when test="${OrderDetails.displayFlag=='11'}">
	                	<!-- 待支付 -->
	                		<input id="payOrder" type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="支付订单">
	                	</c:when>
                		<c:when test="${OrderDetails.displayFlag=='13'}">
                		<!-- 待报价 -->
                			<input  class="btn btn-ash btn-xxxlarge radius10" type="button" value="待报价">
                		</c:when>
                		<c:when test="${OrderDetails.displayFlag=='23'}">
                		<!-- 翻译中 -->
                			<input class="btn btn-ash btn-xxxlarge radius10" type="button" value="翻译中">
                		</c:when>
                		<c:when test="${OrderDetails.displayFlag=='50'}">
                		<!-- 待确认 -->
                			<input id="confirmOrder" class="btn btn-green btn-xxxlarge radius10" type="button" value="确认订单">
                		</c:when>
                		<c:otherwise>
                		<!-- 已完成 已取消 已退款 待评价-->
                		</c:otherwise>
                	</c:choose>
                </div>

            </div>


        </div>


    </div>

</div>
</body>
<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript">
(function () {
       <%-- 支付订单 --%>
       $('#payOrder').click(function(){
           window.location.href="${_base}/p/customer/order/payOrder?orderId="+$("#orderId").val();
       });
   })();
</script>
</html>
