<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- 联系人 -->
<div class="placeorder-container" id="contactPage" style="display: none;">
<div class="placeorder-wrapper">
	<!--步骤-->
	<div class="place-bj">
		<div class="place-step">
			<!--进行的状态-->
	 		<div class="place-step-none adopt-wathet-bj">
	 			<ul>
	 				<li class="circle"><i class="icon iconfont">&#xe60f;</i></li>
	 				<li class="word">翻译内容</li>
	 			</ul>
	 			<p class="line"></p>
	 		</div>
	 		<!--未进行的状态-->
	 		<div class="place-step-none adopt-blue-bj">
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
					<p>联系方式（用于跟踪订单、获取译文）</p>
				</div>
				<div class="oral-form">
					<ul>
						<li>
							<p><input type="text" class="int-text int-in-bi radius" placeholder="请输入姓名"></p>
							<p><select class="select int-in radius"></select></p>
							<p><input type="text" class="int-text int-in-bi radius" placeholder="请输入手机号"></p>
							<p class="mr-0"><input type="text" class="int-text int-large-mail radius" placeholder="请输入接收译文的邮箱"></p>
						</li>
						<li class="right-btn"><input type="button" class="btn radius20 border-blue btn-80" value="保 存"></li>
						
					</ul>
				</div>
	</div>
	<!--白色背景-->
	<div class="white-bj">
	<div class="right-list-title pb-10 ">
				<p>确认订单信息</p>
			</div>
			<div class="right-list-table">
				<table class="table table-th-color">
                  <thead>
                     <tr>
                          <th>主题</th>
                          <th>翻译语言</th>
                          <th>领域</th>
                          <th>用途</th>
                          <th>级别</th>
                    </tr>
             		</thead>
             		<tbody>
				<tr>
                          <td>我要翻译一段话，不超过15……</td>
                          <td>中文→西班牙语</td>
                          <td>医药化工</td>
                          <td>合同文书</td>
                          <td>专业级</td>
				 </tr>
		    </tbody>
          	</table>
			</div>
			<div class="right-list-title pb-10 mt-20 none-border">
				<p>给译员留言</p>
			</div>
			<div class="lx-textarea">
					<p><textarea class="int-text textarea-xlarge-text radius"></textarea></p>	
			</div>	
	</div>
	<!--白色背景-->
	<div class="white-bj">
	<div class="right-list-title pb-10 none-border">
				<p>总价</p>
			</div>
			<div class="urgent">
					<ul>
						<li><span>1500</span>元</li>
						
					</ul>
			</div>
	</div>
	

	<div class="recharge-btn order-btn placeorder-btn">
			<input type="button" id="toCreateOrder" class="btn btn-yellow btn-xxxlarge radius10" value="上 一 步">
			<input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="提 交 订 单">
		</div>
	
</div>
</div>