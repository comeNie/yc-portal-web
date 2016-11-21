<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>译员中心-通过认证</title>
    <%@ include file="/inc/inc.jsp"%>
    <%@ include file="/inc/incJs.jsp"%>
</head>
<body>
	<!--头部-->
  <jsp:include page="/inc/transTopMenu.jsp"/>
  <!--二级主体-->
  <!--外侧背景-->
  <div class="cloud-container">
  <!--内侧内容区域-->
   <div class="translate-cloud-wrapper">
  	<!--左侧菜单-->
  	<div class="left-subnav interpreter-subanav">
  	 <jsp:include page="/inc/transLeftmenu.jsp">
  	    <jsp:param name="current" value="index" />
  	 </jsp:include>
  	</div>
  	<!--右侧内容-->
  	<!--右侧大块-->
  	<div class="right-wrapper">	
  	<input id="interperId" name="interperId" type="hidden" value="${interperInfo.userId}"/>
  	<input id="lspId"  name="lspId" type="hidden" value="${interperInfo.lspId}"/>
  	<input id="lspRole"  name="lspRole" type="hidden" value="${interperInfo.lspRole}"/>
  	<input id="userId"  name="userId" type="hidden" value="${userId}"/>
	<!--右侧第一块-->
  		<div class="right-title">
  			<div class="right-title-left">
  				<div class="right-title-left-tu"><img src="${uedroot}/images/icon1.jpg"></div>
  				<div class="right-title-left-word">
	  				<ul>
	  					<li class="word-black">大脸盼爱大脸</li>
	  					<li class="c-red">存在风险</li>
	  				</ul>
	  				<ul>
	  					<li class="bule" id="lspName"></li>
	  				</ul>
	  				<ul class="word-li">
	  					<li>
	  						<p>余额:</p>
	  						<p class="red">
	  						<fmt:formatNumber
							value="${balance/1000}" pattern="#,##0.00#"/></p>
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
  					<a href="javascript:void(0);">
  					<span class="tp1"></span>
  					<span>已领取<b id="receiveCount">0</b></span>
  					</a>
  				</p>
  				<p>
  					<a href="javascript:void(0);">
  					<span class="tp2"></span>
  					<span>翻译中<b id="translateCount">0</b></span>
  					</a>
  				</p>
  			</div>
  		</div>	
  		
  			
  		<!--右侧第二块-->
  		<div id="have_order_container" class="right-list" style="display: none;">
  			<div class="right-list-title pb-10 pl-20">
  				<p>我的订单</p>
  				<p class="right"><input type="button" class="btn  btn-od-large btn-blue radius20" value="全部订单"></p>
  		</div>
  			<div class="right-list-table">
			 <table class="table table-bg  table-striped-even table-height50">
                    <thead>
                       <tr>
                            <th width="20%">订单主题</th>
                            <th>金额（元）</th>
                            <th>预计交稿时间</th>
                            <th>状态</th>
                            <th>操作</th>
                      </tr>
               		</thead>
                    <tbody id="order_list">
						
				    </tbody>
            </table>   		
		</div>
		<div class="renz-list">没有正在进行中的任务，可以去<a href="#">订单大厅</a>领取适合自己的任务</div>
  		</div>
    <div id="no_order_container" class="right-list" style="display: none;">
			<div class="no-order no-order-cl">
				<ul>
					<li><img src="${uedroot}/images/none-d1.jpg" /></li>
					<li class="mt-50">您好，您还没有通过认证<br>无法领取任务，请先认证</li>
					<li class="right mt-t500"><input type="button"  class="btn border-blue btn-large radius20 blue" value="认证议员"></li>
				</ul>
			</div>
			<div class="no-step"><img src="${uedroot}/images/step1.jpg" /></div>
  	</div>
  	
  	</div>
  	
  	
  </div>
  		
  </div>
<script id="orderTemple" type="text/template">
 <tr>
                            <td><div  class="fy-sm"> {{:translateName}}</div></td>
                            <td>
                           {{:~liToYuan(totalFee)}}
				             {{if  currencyUnit == '1'}}
					         <spring:message code="myOrder.rmb"/>
				              {{else }}
					          <spring:message code="myOrder.dollar"/>
				             {{/if}}</td>
                            <td>{{:endTime}}</td>
                            <td>翻译中</td>
                            <td><input type="button" class="btn biu-btn btn-auto-25 btn-green radius10" value="翻译"></td>
</tr>
</script>
<script type="text/javascript">
	var pager;
	(function() {
		seajs.use('app/jsp/user/interpreter/interpreterIndex', function(interpreterIndexPager) {
			pager = new interpreterIndexPager({
				element : document.body
			});
			pager.render();
		});
	})();
</script>
</body>
</html>
