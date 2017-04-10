<%@ page import="com.ai.paas.ipaas.i18n.ZoneContextHolder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
	
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <%@ include file="/inc/inc.jsp" %>
    <!-- 优惠券 -->
    <title><spring:message code="ycleftmenu.discount"/></title>
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
  	<%@include file="/inc/leftmenu.jsp" %>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	<div class="right-wrapper">	
  		<!--右侧第二块-->
  		<div class="right-list mt-0">
  			<div class="oder-table">
  				<ul id="status">
  					<!-- 未使用 -->
  					<li id="statusN" value="1"><a href="javaScript:void(0);" name="couponStatus" value="1" class="current">未使用(${queryCouponCountNot})</a></li>
  					<!-- 已使用 -->
  					<li id="statusAly"><a href="javaScript:void(0);" name="couponStatus"value="2">已使用(${queryCouponCountAlr})</a></li>
  					<!-- 已过期 -->
  					<li id="statusOve"><a href="javaScript:void(0);" name="couponStatus" value="">已过期(${queryCouponCountExp})</a></li>
  				</ul>
  			</div>
  			<div>
				<!-- 优惠券列表 -->
					<div class="coupon" id="searchCouponData">
		  			</div>
	  			<!-- 优惠券列表结束 -->
  			<div id="showMessageDiv"></div>
			<!-- 分页开始 -->
			<div class="biu-paging paging-large">
			 	<ul id="pagination-ul"></ul>
			</div>
			<!-- 分页结束 -->
  			</div>
  		</div>	
  	</div>
  </div>	
  </div>
  <!-- 底部 -->
<%@include file="/inc/userFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script id="searchCouponTemple" type="text/template">
		<ul class="red">
				<li>
					<p class="money">
					{{if  currencyUnit == '1'}}
		 			¥
		  			{{else currencyUnit == '2'}}
		  			$
		  			{{/if}}<span>{{:faceValue/1000}}</span>
					</p>
					<p><a hrel="#">马上下单</a></p>
				</li>
				<li>
					 {{if  couponUserId == '0'}}
		  				全额抵用
		  			{{else}}
						满
						{{if  currencyUnit == '1'}}
		 				¥
		  				{{else currencyUnit == '2'}}
		  				$
		  				{{/if}}
						<span>
							{{:couponUserId/1000}}
						</span>
						可用
		  			{{/if}}
				</li>
				<li style="margin-bottom:5px;">
					仅可在
				 	{{if  usedScene == '1'}}
		     		译云-中文站
		  			{{else usedScene == '2'}}
		    		译云-英文站
		  			{{else usedScene == '3'}}
		     		百度
		  			{{else usedScene == '4'}}
		     		金山
		  			{{else usedScene == '5'}}
		  			wap-中文
		  			{{else usedScene == '6'}}
		  			wap-英文
		  			{{else usedScene == '7'}}
		    		 找翻译
		  			{{else usedScene == '8'}}
		      		微信助手
		  			{{/if}}
					服务中使用
				</li>
				<li class="bj">
					有效期:
					{{:~timestampToDate('yyyy/MM-dd', effectiveStartTime)}}—{{:~timestampToDate('yyyy/MM/dd', effectiveEndTime)}}
				</li>
		</ul>
	
</script>
<script type="text/javascript">
var pager, orderPager;
(function (){
	 seajs.use('app/jsp/coupon/couponList', function(couponListPage) {
         pager = new couponListPage({element : document.body});
         pager.render();
     });
	 
	//最上面 状态改变 触发
	   $("a[name='couponStatus']").click(function() {
		   $("a[name='couponStatus']").removeClass('current');
		   $(this).addClass('current');
		   pager._searchCouponList($(this).attr('value'));
	   });
})();
</script>
</html>
