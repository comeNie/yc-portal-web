<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>口译下单页</title>
	<%@ include file="/inc/inc.jsp" %>
</head>
<body>	
	<!--面包屑导航-->
	<jsp:include page="../../inc/topMenu.jsp"/>
		<!--主体-->
		<div class="placeorder-container">
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
				<div class="right-list-title pl-20 none-border">
  					<p>翻译主题</p>
  				</div>
  				<div class="oral-form">
  					<ul>
  						<li>
  							<p><input type="text" class="int-text int-100 radius" placeholder="请用一句话描述您的翻译需求"></p>
  						</li>
  					
  					</ul>
  				</div>
			</div>
			<!--白色背景-->
			<div class="white-bj pb-0" >
				<div class="right-list-title pl-20 none-border">
  					<p>翻译主题</p>
  				</div>
  				<div class="form-lable form-pt-0">
  				<ul>
  					<li>
  						<p>
  							<span><input type="checkbox" class="radio" checked=""></span>
  							<span>中英</span>
  						</p>
  						<p>
  							<span><input type="checkbox" class="radio"></span>
  							<span>中日</span>
  						</p>
  						<p>
  							<span><input type="checkbox" class="radio" checked=""></span>
  							<span>中俄</span>
  						</p>
  						<p>
  							<span><input type="checkbox" class="radio"></span>
  							<span>中法</span>
  						</p>
  						<p>
  							<span><input type="checkbox" class="radio"></span>
  							<span>中西</span>
  						</p>
  						<p>
  							<span><input type="checkbox" class="radio"></span>
  							<span>中韩</span>
  						</p>
  					</li>
  				</ul>
  			</div>
  			<div class="right-list-title pl-20 none-border">
  					<p>口译类型</p>
  				</div>
  				<div class="form-lable form-pt-0">
  				<ul>
  					<li>
  						<p>
  							<span><input type="checkbox" class="radio" checked=""></span>
  							<span>陪同翻译</span>
  						</p>
  						<p>
  							<span><input type="checkbox" class="radio"></span>
  							<span>交替传译</span>
  						</p>
  						<p>
  							<span><input type="checkbox" class="radio" checked=""></span>
  							<span>同声传译</span>
  						</p>
  					</li>
  				</ul>
  			</div>
			</div>
			<div class="white-bj">
				<div class="selection-select single-select">
					<ul class="mb-40">
						<li class="none-ml">
							<p class="word">开始时间</p>
							<p><select class="select select-250 radius"></select></p>
						</li>
						<li>
							<p class="word">结束时间</p>
							<p><select class="select select-250 radius"></select></p>
						</li>
						<li>
							<p class="word">会议地点</p>
							<p><input type="text" class="int-text int-in-250 radius" placeholder="北京"></p>
						</li>
						<li>
							<p class="word">会场数量</p>
							<p><input type="text" class="int-text int-in-250 radius" placeholder="请输入会场数量"></p>
						</li>
					</ul>
					<ul>
						<li class="none-ml">
							<p class="word">译员数量</p>
							<p><input type="text" class="int-text int-in-250 radius" placeholder="请输入译员数量"></p>
						</li>
						<li>
							<p class="word">译员性别</p>
							<p><select class="select select-250 radius"></select></p>
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
</body>
</html>
