<%@page import="com.ai.paas.ipaas.i18n.ZoneContextHolder"%>
<%@ page import="com.ai.yc.protal.web.constants.OrderConstants" %>
<%@ page language="java" contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title></title>
    <%@ include file="/inc/inc.jsp" %>

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
        <div class="left-subnav interpreter-subanav">
            <%@ include file="/inc/transLeftmenu.jsp" %>
        </div>
        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <input id="interperId" name="interperId" type="hidden" value="${interperInfo.userId}"/>
            <input id="lspId" name="lspId" type="hidden" value="${interperInfo.lspId}"/>
            <input id="lspRole" name="lspRole" type="hidden" value="${interperInfo.lspRole}"/>
            <input id="userId" name="userId" type="hidden" value="${userId}"/>
            <!--右侧第一块-->
            <div class="right-title">
                <div class="right-title-left">
                    <div class="right-title-left-tu"><img src="${userPortraitImg}"></div>
                    <div class="right-title-left-word">
                        <ul>
								<li class="word-red" style="cursor:pointer;" onclick="location.reload();">${sessionScope.user_session_key.username}</li>
								<li class="c-red" style="cursor:pointer;" onclick="location.href='${_base}/p/security/seccenter?source=interpreter'" id="accLevelInfo"></li>
							</ul>
						<ul>
                            <li class="bule" id="lspName"></li>
                        </ul>
                        <ul class="word-li">
                            <li>
                                <p><spring:message code="ycaccountcenter.userIndex.balance"/>:</p>
                                <p class="red" style="cursor:pointer;" onclick="location.href='${_base}/p/balance/account'">
                                    <fmt:formatNumber
                                            value="${balance/1000}" pattern="#,##0.00#"/></p>
                                <%--积分--%>
                                <p><spring:message code="ycaccountcenter.userIndex.integration"/>:</p>
                                <p class="red" style="cursor:pointer;" onclick="location.href='${_base}/p/balance/account'"><fmt:formatNumber
                                        value="${integration}"/></p>
                            </li>
                            <li style="display: none;">
                                <p>积分:</p>
                                <p class="red">8,782</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="right-title-right">
                    <p>
                        <a href="${_base}/p/trans/order/list/view?state=21">
                            <span class="tp1"></span>
                            <span><spring:message code="myOrder.status.Claimed"/><b id="receiveCount">0</b></span>
                        </a>
                    </p>
                    <p>
                        <a href="${_base}/p/trans/order/list/view?state=23">
                            <span class="tp2"></span>
                            <span><spring:message code="myOrder.status.translating"/><b id="translateCount">0</b></span>
                        </a>
                    </p>
                </div>
            </div>


            <!--右侧第二块-->
            <div id="have_order_container" class="right-list" style="display: none;">
                <div class="right-list-title pb-10 pl-20">
                    <p><spring:message code="myOrder.myorders"/></p>
                    <p class="right">
                    <input type="button"
                     onclick="location.href='${_base}/p/trans/order/list/view'"
                     class="btn  btn-od-large btn-blue radius20" value="<spring:message code="myOrder.allOrder"/>">
                    </p>
                </div>
                <div class="right-list-table">
                    <table class="table table-bg  table-striped-even table-height50">
                        <thead>
                        <tr>
                            <th width="20%"><spring:message code="myOrder.SubjectOrder"/></th>
                            <th><spring:message code="myOrder.Amount"/></th>
                            <th><spring:message code="myOrder.DeliveryTime"/></th>
                            <th><spring:message code="myOrder.Status"/></th>
                            <th><spring:message code="myOrder.Operate"/></th>
                        </tr>
                        </thead>
                        <tbody id="order_list">

                        </tbody>
                    </table>
                </div>
                
            </div>
            <div id="no_order_container" class="right-list" style="display: none;" >
            <div class="renz-list"><spring:message code="ycaccountcenter.interpreterIndex.noTaskMsg" arguments="${_base}/p/taskcenter/view"/></div>
            </div>
            <div id="no_rz_container" class="right-list" style="display: none;">
                <div class="no-order no-order-cl">
                    <ul>
                        <li><img src="${uedroot}/images/none-d1.jpg"/></li>
                        <li class="mt-50"><spring:message code="ycaccountcenter.interpreterIndex.noCertificationMsg"/></li>
                        <li class="right mt-t500">
                          <input type="button" class="btn border-blue btn-large radius20 blue" onclick="window.open('http://tran.yeecloud.com/yctranslator/redirect.html?v=page/yctranslator/login/logint&language=zh')" value="<spring:message code="ycaccountcenter.interpreterIndex.certification.interpreter"/>">
                        </li>
                    </ul>
                </div>
                <div class="no-step">
				<ul>
					<li>
						<p class="iocn5"></p>
						<p class="sz-radius">1</p>
						<p class="word"><spring:message code="ycaccountcenter.interpreterIndex.step1"/></p>
					</li>
					<li class="line"></li>
					<li>
						<p class="iocn6"></p>
						<p class="sz-radius">2</p>
						<p class="word"><spring:message code="ycaccountcenter.interpreterIndex.step2"/></p>
					</li>
					<li class="line1"></li>
					<li>
						<p class="iocn7"></p>
						<p class="sz-radius">3</p>
						<p class="word"><spring:message code="ycaccountcenter.interpreterIndex.step3"/></p>
					</li>
					<li class="line"></li>
					<li>
						<p class="iocn8"></p>
						<p class="sz-radius">4</p>
						<p class="word"><spring:message code="ycaccountcenter.interpreterIndex.step4"/></p>
					</li>
				</ul>
			</div>
            </div>

        </div>


    </div>

</div>
<%@ include file="/inc/userFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript">
	var interpretrMsg = {
			"noCertificationMsg" : '<spring:message code="ycaccountcenter.interpreterIndex.noCertificationMsg"/>',
			"goCertificationMsg" : '<spring:message code="ycaccountcenter.interpreterIndex.goAuthentication"/>',
			"cancel":'<spring:message code="ycaccountcenter.interpreterIndex.cancel"/>',
			"showTip":'<spring:message code="ycaccountcenter.js.showTitleMsg"/>',
	}
</script>
<script id="orderTemple" type="text/template">
    
    <tr>
        <input type="hidden" name="orderId" value="{{:orderId}}">
						<input type="hidden" name="unit" value="{{:currencyUnit}}">
						<input type="hidden" name="state" value="{{:state}}">
        <td class="text-l pl-5">
            <div class="fy-sm" orderId="{{:orderId}}" style="cursor:pointer;"> {{:translateName}}</div>
        </td>
        <td>
            {{if  currencyUnit == '1'}}
								<spring:message code="myOrder.rmbSame" arguments="{{:~liToYuan(totalFee)}}" />
								{{else }}
								<spring:message code="myOrder.dollarSame" arguments="{{:~liToYuan(totalFee)}}" />
								{{/if}}
        </td>
        <td>
        {{:~timestampToDate('yyyy-MM-dd hh:mm:ss',endTime,'<%=ZoneContextHolder.getZone()%>')}}
        </td>
            {{if  state  == '21'}}
            <!-- 已领取 -->
            <td><spring:message code="myOrder.status.Claimed"/></td>
            <td>
                <!-- <input type="button"  class="btn biu-btn btn-auto-25 btn-yellow radius10" value="分 配"> -->
                <!-- 翻 译 -->
                <%--若是口译订单，暂时不显示操作--%>
                {{if translateType != '<%=OrderConstants.TranslateType.ORAL%>'}}
                <input name="trans" type="button"  class="btn biu-btn btn-auto-25 btn-green radius10"  value="<spring:message code="myOrder.Translate"/>">
                {{/if}}
            </td>
            {{else state  == '221'}}
            <!-- 已分配 -->
            <td><spring:message code="myOrder.status.Assigned"/></td>
            <td>
                <!-- <input name="assigne" type="button"  class="btn biu-btn btn-auto-25 btn-yellow radius10" value="分 配"> -->
            </td>
            {{else state  == '23'}}
            <!-- 翻译中 -->
            <td><spring:message code="myOrder.status.translating"/></td>
            <td>
                <!-- 提交 -->
                <%--若是口译订单，暂时不显示操作--%>
                {{if translateType != '<%=OrderConstants.TranslateType.ORAL%>'}}
                <input name="submit" type="button"  class="btn biu-btn btn-auto-25 btn-yellow radius10" value="<spring:message code="myOrder.Submit"/>">
                {{/if}}
            </td>
            {{else state  == '40'}}
            <!-- 待审核 -->
            <td><spring:message code="myOrder.status.Review"/></td>
            <td>
                <!--<input name="submit" type="button"  class="btn biu-btn btn-auto-25 btn-yellow radius10" value="提交"> -->
            </td>
            {{else state  == '50'}}
            <!-- 待确认 -->
            <td><spring:message code="myOrder.status.tobeConfirm"/></td>
            <td></td>
            {{else state  == '51'}}
            <!-- 已确认 -->
            <td><spring:message code="myOrder.status.confirmed"/></td>
            <td></td>
            {{else state  == '90'}}
            <!-- 已完成 -->
            <td><spring:message code="myOrder.status.Completed"/></td>
            <td></td>
            {{else state  == '53'}}
            <!-- 已评价 -->
            <td><spring:message code="myOrder.status.Evaluated"/></td>
            <td>
                <!-- <input name="evaluated" type="button"  class="btn biu-btn btn-auto-25 btn-yellow radius10" value="已评价"> -->
            </td>
            {{else state  == '25'}}
            <!-- 修改中 -->
            <td><spring:message code="myOrder.status.Modification"/></td>
            <td>
                <!-- 提交 -->
                {{if translateType != '<%=OrderConstants.TranslateType.ORAL%>'}}
                <input name="submit" type="button"  class="btn biu-btn btn-auto-25 btn-yellow radius10" value="<spring:message code="myOrder.Submit"/>">
                {{/if}}
            </td>
            {{else state  == '92'}}
            <!-- 已退款 -->
            <td><spring:message code="myOrder.status.Refunded"/></td>
            <td></td>
            {{else }}
            <td></td>
            <td></td>
            {{/if}}
    </tr>
</script>
<script type="text/javascript">
    var pager, orderPager;
    var current = "index";
    var showCert = ${showCert==true?true:false};
    (function () {
        seajs.use(['app/jsp/user/interpreter/interpreterIndex', 'app/jsp/customerOrder/order'], function (interpreterIndexPager, orderPage) {
            pager = new interpreterIndexPager({
                element: document.body
            });
            orderPager = new orderPage({element: document.body});
            pager.render();
            orderPager.render();
        });
        //提交按钮
    	$('#order_list').delegate("input[name='submit']", 'click', function () {
            orderPager._orderSubmit($(this).parents("tr").find("input[name='orderId']").val());
    	});
    	
    	//翻译按钮
    	$('#order_list').delegate("input[name='trans']", 'click', function () {
    		 window.location.href="${_base}/p/trans/order/"+$(this).parents("tr").find("input[name='orderId']").val();
    	});

        //订单主题
        $('#order_list').delegate(".fy-sm", 'click', function () {
            window.location.href="${_base}/p/trans/order/"+$(this).parents("tr").find("input[name='orderId']").val();
        });


    })();
	$(function(){
		var securitylevel = "${securitylevel}";
		var accLevelInfo = $("#accLevelInfo");
		if(parseInt(securitylevel) < 60)
		{
			accLevelInfo.html('<spring:message code="ycaccountcenter.acc.level.danger"/>');
		}
		if(parseInt(securitylevel) >= 60 && parseInt(securitylevel) < 100)
		{
			accLevelInfo.html('<spring:message code="ycaccountcenter.acc.level.warn"/>');
		}
		if(parseInt(securitylevel) == 100)
		{
			accLevelInfo.html('<spring:message code="ycaccountcenter.acc.level.safe"/>');
		}
	});
</script>
</html>
