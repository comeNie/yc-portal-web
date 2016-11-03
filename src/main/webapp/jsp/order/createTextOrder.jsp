<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>翻译下单页</title>
	<%@ include file="/inc/inc.jsp" %>
</head>
<body>	
	<!--面包屑导航-->
	<%@ include file="/inc/topMenu.jsp" %>
		<!--主体-->
		<div class="placeorder-container" id="textOrderPage">
		<div class="placeorder-wrapper">
			<!--步骤-->
			<div class="place-bj">
				<div class="place-step">
					<!--进行的状态-->
			 		<div class="place-step-none adopt-blue-bj">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60f;</i></li>
			 				<li class="word">翻译内容</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-ash-bj">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe60d;</i></li>
			 				<li class="word">填写联系方式</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		<!--未进行的状态-->
			 		<div class="place-step-none adopt-ash-bj">
			 			<ul>
			 				<li class="circle"><i class="icon iconfont">&#xe608;</i></li>
			 				<li class="word">支付</li>
			 			</ul>
			 			<p class="line"></p>
			 		</div>
			 		
				</div>
			</div>
			<!--白色背景-->
			<div class="white-bj">
				<div class="right-list-title pb-20 pl-20 none-border">
  					<p>翻译语言</p>
  				</div>
  				<div class="placeorder-translate">
  					<select class="select select-large"><option>中文→英文</option><option>英文→中文</option></select>
  				</div>
			</div>
			<!--白色背景-->
			<div class="white-bj">
				<div class="right-list-title pb-20 pl-20 none-border">
  					<p>翻译内容</p>
  				</div>
  				<div class="translate-int radius">
  					<p><textarea class="int-text textarea-xlarge-100 radius"></textarea></p>
  					<p class="right"><input type="button" class="btn border-blue radius20 btn-80" value="上传文档"></p>
  				</div>	
			</div>
			<!--白色背景-->
			<div class="white-bj">
				<div class="selection-level mt-20">
					<ul class="none-ml current">
						<li class="blue">
							<p>普通级</p>
							<p><i class="icon-star-empty"></i></p>
						</li>
						<li>
							<p>适用于个人阅读、理解</p>
						</li>
						<li>
							<p><span>150</span>元/千字</p>
							<p class="ml-30"><span>1</span>次免费修改</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p>专业译员翻译</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p>专业译员翻译</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p>专业译员翻译</p>
						</li>
						<label><i class="icon iconfont">&#xe617;</i></label>
					</ul>
					<ul>
						<li class="blue">
							<p>普通级</p>
							<p><i class="icon-star-empty"></i></p>
						</li>
						<li>
							<p>适用于个人阅读、理解</p>
						</li>
						<li>
							<p><span>150</span>元/千字</p>
							<p class="ml-30"><span>1</span>次免费修改</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p>专业译员翻译</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p>专业译员翻译</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p>专业译员翻译</p>
						</li>
					</ul>
					<ul>
						<li class="blue">
							<p>普通级</p>
							<p><i class="icon-star-empty"></i></p>
						</li>
						<li>
							<p>适用于个人阅读、理解</p>
						</li>
						<li>
							<p><span>150</span>元/千字</p>
							<p class="ml-30"><span>1</span>次免费修改</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p>专业译员翻译</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p>专业译员翻译</p>
						</li>
						<li class="green-li">
							<p class="icon"><i class="icon iconfont">&#xe616;</i></p>
							<p>专业译员翻译</p>
						</li>
					</ul>
				</div>
				<!--select-->
				<div class="selection-select mt-50">
					<ul>
						<li class="none-ml">
							<p class="word">用途</p>
							<p><select class="select select-medium radius"><option>合同标书</option></select></p>
						</li>
						<li>
							<p class="word">领域</p>
							<p><select class="select select-medium radius"><option>医药化工</option></select></p>
						</li>
						<li>
							<p class="word">增值服务</p>
							<p><select class="select select-medium radius"><option>排版</option></select></p>
						</li>
						<li class="width-large">
							<p class="word">格式转换</p>
							<p><select class="select select-medium radius"><option>无格式转换</option></select></p>
							<p class="ml-20"><input type="text" class="int-text int-in-bi radius"></p>
						</li>
					</ul>
				</div>
				<div class="right-list-title pb-20 pl-20 mt-40 none-border">
  					<p>预计翻译速度</p>
  				</div>
  				<div class="urgent">
  					<ul>
  						<li><span>1500</span>字/小时</li>
  						<li class="mt-10">
  							<p><input type="checkbox" checked=""  class="radio">加急</p>
  							<p class="word ml-20">加急订单，更快获得译文</p>
  						</li>
  					</ul>
  				</div>
			</div>	
			<div class="recharge-btn order-btn placeorder-btn ml-0">
 				<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="提 交 翻 译">
 				<p><input type="checkbox" class="radio" checked="">阅读并同意<a href="#">《译云翻译协议》</a></p>
 			</div>
		</div>
		</div>
		
		<!-- 联系人 -->
		<%@ include file="/jsp/order/orderContact.jsp" %>
		
</body>
<script type="text/javascript">
	(function () {
		var pager;
		seajs.use(['app/order/createTextOrder','app/util/center-hind'], function(createTextOrderPage,centerHind) {
			pager = new createTextOrderPage({element : document.body});
			pager.render();
			new centerHind({element : document.body}).render();
		});
	})();
</script>
</html>
