<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <title>译员-订单详情</title>
    <%@ include file="/inc/inc.jsp" %>
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
	 		<div class="breadcrumb">
	 			<p>我的订单></p>
	 			<p>订单：5000345</p>
	 		</div>
			<!--订单table-->
			<div class="confirmation-table"> 
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
			 					<li class="word">翻译是在准确、通顺的基础上，把一种语言信息转变成另一种语言信息的行为。翻译是将一种相对陌生的表达方式，转换成相对熟悉的表达方式的过程。其内容有语言、文字、图形、符号的翻译。其中，“翻”是指对交谈的语言转换，“译”是指对单向陈述的语言转换。“翻”是指对交谈中的两种语言进行即时的、一句对一句的转换，即先把一句甲语转<A href="javaScript:void(0);">[更多]</A></li>
			 				</ul>
			 			</div>
			 		  </div>
			 		  <div id="translate2" style="display: none;">
			 		  	 <div class="tracking-list">
			 		  	 	<ul>
			 		  	 		<li class="conduct">
			 		  	 			<p>2015-04-07 11:04:04</p>
			 		  	 			<p class="right">订单已被译员领取，正在翻译中，请耐心等待</p>
			 		  	 		</li>
			 		  	 		<li>
			 		  	 			<p>2015-04-07 11:04:04</p>
			 		  	 			<p class="right">订单已被译员领取，正在翻译中，请耐心等待</p>
			 		  	 		</li>
			 		  	 		<li>
			 		  	 			<p>2015-04-07 11:04:04</p>
			 		  	 			<p class="right">订单已被译员领取，正在翻译中，请耐心等待</p>
			 		  	 		</li>
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
			 			<!--第一列信息-->
			 			<div class="info-list info-title">
			  			<ul>
			  				<li class="width-small">
			  					<p>
			  						<span  class="word">订单金额:</span>
			  						<span>100元</span>
			  					</p>
			  					<p>
			  						<span  class="word">字数:</span>
			  						<span>25871字/词</span>
			  					</p>
			  				</li>
			  				<li  class="width-mini">
			  					<p class="word">预计交稿时间:</p>
			  					<p>1658735989</p>
			  				</li>
			  			</ul>
			 			</div>
			 			<!--第一列信息结束-->
			 			<div class="info-list">
			  			<span>订单信息</span>
			  			<ul>
			  				<li>
			  					<p class="word">订单号:</p>
			  					<p>1658735989</p>
			  				</li>
			  				<li>
			  					<p class="word">翻译主题:</p>
			  					<p>1658735989</p>
			  				</li>
			  				<li>
			  					<p class="word">翻译语言:</p>
			  					<p>英文→中文</p>
			  				</li>
			  				<li>
			  					<p class="word">翻译级别:</p>
			  					<p>英文→中文</p>
			  				</li>
			  				<li>
			  					<p class="word">用途:</p>
			  					<p>通用</p>
			  				</li>
			  				<li>
			  					<p class="word">领域:</p>
			  					<p>通用</p>
			  				</li>
			  				<li>
			  					<p class="word">创建时间:</p>
			  					<p>2015-04-07 09:53:51</p>
			  				</li>
			  				<li>
			  					<p class="word">预计翻译耗时:</p>
			  					<p>3天15小时8分</p>
			  				</li>
			  				<li>
			  					<p class="word">其他:</p>
			  					<p>加急;需要排版</p>
			  				</li>
			  				<li class="width-large">
			  					<p class="word">需求备注:</p>
			  					<p class="p-large">翻译需求是什么翻译翻译需求是什么翻译需求是什么,翻译需求是什么翻译需求是什么翻译需求是什么需求是什么翻译需求是什么翻译需求是什么翻译需求是什么翻译需求是什么</p>
			  				</li>
			  			</ul>
			 			</div>
			
			 		</div>
			 		<!--按钮-->
			 		<div class="recharge-btn order-btn">
						<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="领取">
					</div>
				
			</div>
 		</div>
 	</div>
</div>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/jqueryrotate.2.3.js"></script>
</body>
</html>