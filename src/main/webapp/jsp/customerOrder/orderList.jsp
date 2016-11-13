<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>我的订单</title>
	<%@ include file="/inc/inc.jsp" %>
	
	<script src="${_base}/resources/spm_modules/my97DatePicker/WdatePicker.js"></script>
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
	 <jsp:include page="/inc/leftmenu.jsp">
  	 <jsp:param name="current" value="orderList" />
  	 </jsp:include>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	<div class="right-wrapper">	
  		<!--右侧第二块-->
  		<div class="right-list mt-0" ti="<fmt:formatDate value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>">
  			<div class="oder-table">
  				<ul>
  					<li><a href="javaScript:void(0);" name="displayFlagA" class="current"  value="">全部订单</a></li>
  					<li><a href="javaScript:void(0);" name="displayFlagA" value="11">待支付(${UnPaidCount})</a></li>
  					<li><a href="javaScript:void(0);" name="displayFlagA" value="23">翻译中(${TranslateCount})</a></li>
  					<li><a href="javaScript:void(0);" name="displayFlagA" value="50">待确认(${UnConfirmCount})</a></li>
  					<li><a href="javaScript:void(0);" name="displayFlagA" value="52">待评价(${UnEvaluateCount})</a></li>	
  				</ul>
  			</div>
  			<div id="table-da1">
  			<form id="orderQuery">
  			<div class="oder-form-lable mt-20">
  				<ul>
  					<li class="mb-20">
  						<p>订单状态</p> 
  						<p>
	  						<select class="select select-small radius" name="displayFlag" id="displayFlag">
	  							<option value="11">待支付</option>
	  							<option value="13">待报价</option>
	  							<option value="23">翻译中</option>
	  							<option value="50">待确认</option>
	  							<option value="52">待评价</option>
	  							<option value="90">完成</option>
	  							<option value="91">关闭</option>
	  							<option value="92">已退款</option>
	  						</select>
  						</p>
  						<p>订单时间</p>
  						<p><input id="orderTimeStart" name="orderTimeStart" type="text" class="int-text int-small radius" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'stateChgTimeEnd\')}'})" readonly="readonly"></p>
  						<p>－</p>
  						<p><input id="stateChgTimeEnd" name="stateChgTimeEnd" type="text" class="int-text int-small radius" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'orderTimeStart\')}'})" readonly="readonly"></p>
  						<p>翻译内容</p>
  						<p>
  							<select class="select select-small radius" name="translateType" id="translateType">
  								<option value="0 1 2">全部</option>
  								<option value="0 2">文字</option>
  								<option value="1">附件</option>	
  							</select>
  						</p>
  						<p class="iocn-oder"><input id="translateName" name="translateName" type="text" class="int-text int-medium radius pr-30">
  						<i id="submitQuery" href="javaScript:void(0)" class=" icon-search"></i>
  						</p>
  					</li>
  					<!--  暂时只有个人
  					<li>
  						<p><input type="checkbox" class="checkbox-n" checked="checked">个人</p>
  						<p><input type="checkbox" class="checkbox-n">企业</p>
  					</li>
  					-->
  				</ul>
  			</div>
  			</form>
  			</div>
  			
  			<div class="right-list-table">
  				<table class="table table-hover table-bg">
                    <thead>
                       <tr>
                            <th width="16.666%">订单主题</th>
                            <th width="16.666%">下单人</th>
                            <th width="16.666%">翻译语言</th>
                            <th width="16.666%">金额（元）</th>
                            <th width="16.666%">状态</th>
                            <th width="16.666%">操作</th>
                      </tr>
               		</thead>
            	</table>
  			</div>
  			<!-- 订单列表 -->
  			<div class="right-list-table" id="searchOrderData">
  			</div>
  			<!-- 订单列表结束 -->
  			<div id="showMessageDiv"></div>
  			<!--分页-->
  			<div class="biu-paging paging-large">
			 	<ul id="pagination-ul">
			  	</ul>
			</div>
			<!--分页结束-->
  		</div>
  	</div>
  </div><!--内侧内容区域-->
  </div> <!--外侧背景-->

</body>
<%@ include file="/inc/incJs.jsp" %>
<script id="searchOrderTemple" type="text/template">
<table class="table  table-bg tb-border mb-20">
	<thead>
	<tr>
 		<th colspan="6" class="text-l">
 			<div class="table-thdiv">
 				<p></p>
 				<p>订单号：<span>{{:orderId}}</span></p>
    			<p class="right">剩余2天23小时59分钟</p>
      		</div>
    	</th>
  	 </tr>
    </thead>
    <tbody>
		<input type="hidden" name="orderId" value="{{:orderId}}">
		<input type="hidden" name="displayFlag" value="{{:displayFlag}}">
		<tr class="width-16" displayFlag="{{:displayFlag}}">
            <td name="translateName" orderId="{{:orderId}}">{{:translateName}}</td>
            <td>{{:userName}}</td>
  			<td>{{:ordProdExtendList[0].langungePairChName}}</td>
            <td>{{:totalFee}}</td>
			{{if  displayFlag == '11'}}
				<td>待支付</td>
			 	<td>
            		<input type="button" name="payOrder" class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
            		<input type="button" name="cancelOrder" class="btn biu-btn btn-auto-25 btn-red radius10"  value="取 消">
           		</td>
			{{else displayFlag == '13'}}
				<td>待报价</td>
				<td>
					<input name="cancelOrder" class="btn biu-btn btn-auto-25 btn-red radius10" type="button" value="取 消">
				</td>
			{{else displayFlag == '23'}}
				<td>翻译中</td>
			{{else displayFlag == '50'}}
				<td>待确认</td>
				<td>
					<input name="confirmOrder" class="btn biu-btn btn-auto-25 btn-green radius10" type="button" value="确 认">
					<input name="lateConfirmOrder" class="btn biu-btn btn-auto-25 btn-red radius10" type="button" value="延时确认">
				</td>
			{{else displayFlag == '52'}}
				<td>待评价</td>
				<td></td>
				<!-- 
				<td>待评价</td>
				<td>
					<input class="btn biu-btn btn-auto-25 btn-green radius10" type="button" value="评 价">
				</td>
				-->
			{{else displayFlag == '90'}}
				<td>完成</td>
				<td></td>
				<!-- 
				td>完成</td>
				<td>
					<input class="btn biu-btn btn-auto-25 btn-green radius10" type="button" value="评 价">
				</td>
				-->
			{{else displayFlag == '91'}}	
				<td>关闭</td>
				<td></td>
			{{else }}
				<td>已退款</td>
				<td></td>
			{{/if}}
		 </tr>
    </tbody>
</table>
</script>
<script type="text/javascript">
var pager;
(function () {
	seajs.use('app/jsp/customerOrder/orderList', function(oderListPage) {
		pager = new oderListPage({element : document.body});
		pager.render();
	});
	   
	   $("a[name='displayFlagA']").click(function() {
		   $("a[name='displayFlagA']").removeClass('current');
		   $(this).addClass('current');
		   pager._orderListByType($(this).attr('value'));
	   });
	   
       $('#searchOrderData').delegate("td[name='translateName']", 'click', function () {
       	  window.location.href="${_base}/p/customer/order/"+$(this).parent().parent().find("input[name='orderId']").val() +"?displayFlag="+$(this).parent().parent().find("input[name='displayFlag']").val();
       });
       
       <%-- 支付订单 --%>
       $("#searchOrderData").delegate("input[name='payOrder']","click",function(){
       		window.location.href="${_base}/p/customer/order/payOrder?orderId="+$(this).parent().parent().parent().find("input[name='orderId']").val();
       });
       
       <%-- 取消订单 --%>
       $("#searchOrderData").delegate("input[name='cancelOrder']","click",function(){
    		pager._cancelOrder($(this).parent().parent().parent().find("input[name='orderId']").val());
       });
       
       <%-- 确认订单 --%>
       $("#confirmOrder").delegate("input[name='confirmOrder']","click",function(){
       	
       });
       <%-- 延迟确认订单 --%>
       $("#confirmOrder").delegate("input[name='lateConfirmOrder']","click",function(){
       	
       });
       
      
})();
</script>

</html>
