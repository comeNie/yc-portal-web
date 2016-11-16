<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>译员-我的订单</title>
    <%@ include file="/inc/inc.jsp" %>
</head>
<body>
<!--头部-->
<%@include file="/inc/transTopMenu.jsp" %>
<!--二级主体-->
<!--外侧背景-->
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
	 			<div class="oder-table">
	 				<ul>
	 					<li><a href="javaScript:void(0);"  class="current">全部订单</a></li>
	 					<li><a href="javaScript:void(0);">已领取(8)</a></li>
	 					<li><a href="javaScript:void(0);">翻译中(4)</a></li>
	 				</ul>
	 			</div>
	 			<div id="table-da1">
		 			<div class="oder-form-lable mt-20">
		 				<ul>
		 					<li class="mb-20">
		 						<p>订单状态</p>
		 						<p><select class="select select-small radius"></select></p>
		 						<p>订单阶段</p>
		 						<p><select class="select select-small radius"></select></p>
		 						<p>翻译领域</p>
		 						<p><select class="select select-small radius"></select></p>
		 						<p>订单时间</p>
		 						<p><input type="text" class="int-text int-small radius"></p>
		 						<p>－</p>
		 						<p><input type="text" class="int-text int-small radius"></p>
		 					</li>
		 					<li class="mb-20">
		 						<p>翻译用途</p>
		 						<p><select class="select select-small radius"></select></p>
		 						<p class="iocn-oder right"><input type="text" class="int-text int-medium radius pr-30"><i class=" icon-search"></i></p>
		 					</li>
		 					
		 				</ul>
		 			</div>
		 			
		 			<div class="right-list-table">
		 				<table class="table table-hover table-bg">
		                   <thead>
		                      <tr>
		                           <th width="16.666%">任务名称</th>
		                           <th width="16.666%">翻译语言</th>
		                           <th width="16.666%">金额(元)</th>
		                           <th width="16.666%">阶段</th>
		                           <th width="16.666%">状态</th>
		                           <th width="16.666%">操作</th>
		                     </tr>
		              		</thead>
		          		 </table>
		 			</div>
		 			<div class="right-list-table">
		 				<table class="table  table-bg tb-border mb-20">
		                   <thead>
		                      <tr>
		                           <th colspan="6" class="text-l">
		                           		<div class="table-thdiv">
		                           			<p>2015-04-07 09:53:51</p>
		                           			<p>订单号：<span>198409857093246</span></p>
		                           			<p class="right">剩余2天23小时59分钟</p>
		                           		</div>
		                           </th>
		                     </tr>
		              		</thead>
		                   <tbody>
							<tr class="width-16">
		                           <td>我要翻译一段话，不超过15……</td>
		                           <td>中文→西班牙语</td>
		                           <td>1000.00</td>
		                           <td>翻译</td>
		                           <td>已领取</td>
		                           <td>
		                           	<input type="button"  class="btn biu-btn btn-auto-25 btn-yellow radius10" value="分 配">
		                           	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10"  value="翻 译">
		                           </td>
							 </tr>
					    </tbody>
		           		</table>
		           		<table class="table  table-bg tb-border mb-20">
		                   <thead>
		                      <tr>
		                           <th colspan="6" class="text-l">
		                           		<div class="table-thdiv">
		                           			<p>2015-04-07 09:53:51</p>
		                           			<p>订单号：<span>198409857093246</span></p>
		                           			<p class="right">剩余2天23小时59分钟</p>
		                           		</div>
		                           </th>
		                     </tr>
		              		</thead>
					    <tbody>
							<tr class="width-16">
		                           <td>我要翻译一段话，不超过15……</td>
		                           <td>中文→西班牙语</td>
		                           <td>1000.00</td>
		                           <td>翻译</td>
		                           <td>已领取</td>
		                           <td>
		                           	<input type="button"  class="btn biu-btn btn-auto-25 btn-yellow radius10"  value="提 交">
		                           </td>
							 </tr>
					    </tbody>
		           		</table>
		           		<table class="table  table-bg tb-border mb-20">
		                   <thead>
		                      <tr>
		                           <th colspan="6" class="text-l">
		                           		<div class="table-thdiv">
		                           			<p>2015-04-07 09:53:51</p>
		                           			<p>订单号：<span>198409857093246</span></p>
		                           			<p class="right">剩余2天23小时59分钟</p>
		                           		</div>
		                           </th>
		                     </tr>
		              		</thead>
					    <tbody>
							<tr class="width-16">
		                           <td>我要翻译一段话，不超过15……</td>
		                           <td>中文→西班牙语</td>
		                           <td>1000.00</td>
		                           <td>翻译</td>
		                           <td>已领取</td>
		                           <td>
		                           	<input type="button"  class="btn biu-btn btn-auto-25 btn-green radius10"  value="翻 译">
		                           </td>
							 </tr>
					    </tbody>
		           		</table>
		           		<table class="table  table-bg tb-border mb-20">
		                   <thead>
		                      <tr>
		                           <th colspan="6" class="text-l">
		                           		<div class="table-thdiv">
		                           			<p>2015-04-07 09:53:51</p>
		                           			<p>订单号：<span>198409857093246</span></p>
		                           			<p class="right">剩余2天23小时59分钟</p>
		                           		</div>
		                           </th>
		                     </tr>
		              		</thead>
					    <tbody>
							<tr class="width-16">
		                           <td>我要翻译一段话，不超过15……</td>
		                           <td>中文→西班牙语</td>
		                           <td>1000.00</td>
		                           <td>翻译</td>
		                           <td>已领取</td>
		                           <td class="yellow-td-icon">
		                            <a href="javaScript:void(0);">
			                            	<i class="icon iconfont">&javaScript:void(0);xe6bc;</i>
			                            	<i class="icon iconfont">&javaScript:void(0);xe6bc;</i>
			                            	<i class="icon iconfont">&javaScript:void(0);xe6bc;</i>
			                            	<i class="icon iconfont">&javaScript:void(0);xe6bc;</i>
			                            	<i class="icon iconfont">&javaScript:void(0);xe754;</i>
		                            </a>
		                           </td>
							 </tr>
					    </tbody>
		           		</table>
		 			</div>
				  	<div class="biu-paging paging-large">
					 	<ul>
						     <li class="prev-up"><a href="javaScript:void(0);"><</a></li>
						     <li class="active"><a href="javaScript:void(0);">1</a></li>
						     <li><a href="javaScript:void(0);">2</a></li>
						     <li><a href="javaScript:void(0);">3</a></li>
						     <li><a href="javaScript:void(0);">4</a></li>
						     <li><a href="javaScript:void(0);">5</a></li>
						     <li><a href="javaScript:void(0);">6</a></li>
						     <li><a href="javaScript:void(0);">……</a></li>
						     <li><a href="javaScript:void(0);">100</a></li>
						     <li class="next-down"><a href="javaScript:void(0);">></a></li>
						     <li>
								<span>到</span>
								<span><input type="text" class="int-verysmall radius"></span>
								<span>页</span>
							</li>
							<li class="taiz"><a href="javaScript:void(0);">跳转</a></li>
					  	 </ul>
					</div>
	 			</div>
			</div>	
		</div>
 	</div>
</div>
</body>
<%@ include file="/inc/incJs.jsp" %>

<script type="text/javascript">
(function () {
	
  
})

//最上面 订单类型切换
$(".oder-table ul li a").click(function () {
	$(".oder-table ul li a").each(function () {
	    $(this).removeClass("current");
	});
	$(this).addClass("current");
});
  
</script>
</html>
