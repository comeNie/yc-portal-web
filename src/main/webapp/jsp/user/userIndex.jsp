<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>首页</title>
<%@ include file="/inc/inc.jsp"%>
<%@ include file="/inc/incJs.jsp"%>
</head>
<body>
	<!--头部-->
	<jsp:include page="/inc/userTopMenu.jsp"/>
	<!--二级主体-->
	<!--外侧背景-->
	<div class="cloud-container">
		<!--内侧内容区域-->
		<div class="cloud-wrapper">
			<!--左侧菜单-->
			<div class="left-subnav">
				<jsp:include page="/inc/leftmenu.jsp">
  	              <jsp:param name="current" value="index" />
  	           </jsp:include>
			</div>
			<!--右侧内容-->
			<!--右侧大块-->
			<div class="right-wrapper">
				<!--右侧第一块-->
				<div class="right-title">
					<div class="right-title-left">
						<div class="right-title-left-tu">
							<img src="${uedroot}/images/icon1.jpg">
						</div>
						<div class="right-title-left-word">
							<ul>
								<li class="word-red">大脸盼爱大脸</li>
								<li class="c-red">存在风险</li>
							</ul>
							<ul>
								<li class="bule">中译语通科技有限公司</li>
							</ul>
							<ul class="word-li">
								<li>
									<p>余额:</p>
									<p class="red">351,575</p>
								</li>
								<li>
									<p>积分:</p>
									<p class="red">8,782</p>
								</li>
							</ul>
						</div>
					</div>
					<div class="right-title-right">
						<p>
							<a href="javascript:void(0);"> <span class="tp1"></span> <span>待支付<b id="unPaidCount">0</b></span>
							</a>
						</p>
						<p>
							<a href="javascript:void(0);"> <span class="tp2"></span> <span>翻译中<b id="translateCount">0</b></span>
							</a>
						</p>
						<p>
							<a href="javascript:void(0);"> <span class="tp3"></span> <span>待确认<b id="unConfirmCount">0</b></span>
							</a>
						</p>
						<p>
							<a href="javascript:void(0);"> <span class="tp4"></span> <span>待评价<b id="unEvaluateCount">0</b></span>
							</a>
						</p>
					</div>
				</div>
				<!--右侧第二块-->
				<div class="right-list">
					<div class="right-list-title pb-10 pl-20">
						<p>我的订单</p>
						<p class="right">
							<input type="button" class="btn  btn-od-large btn-blue radius20"
								value="全部订单">
						</p>
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
					<div class="right-list-table">
						<table class="table  table-bg tb-border mb-20">
							<thead>
								<tr>
									<th colspan="6" class="text-l">
										<div class="table-thdiv">
											<p>2015-04-07 09:53:51</p>
											<p>
												订单号：<span>198409857093246</span>
											</p>
											<p class="right">剩余2天23小时59分钟</p>
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr class="width-16">
									<td class="text-l pl-20">我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td class="text-r"><input type="button"
										class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
										<input type="button"
										class="btn biu-btn btn-auto-25 btn-red radius10" value="取 消">
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
											<p>
												订单号：<span>198409857093246</span>
											</p>
											<p class="right">剩余2天23小时59分钟</p>
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr class="width-16">
									<td class="text-l pl-20">我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td class="text-r"><input type="button"
										class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
										<input type="button"
										class="btn biu-btn btn-auto-25 btn-red radius10" value="取 消">
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
											<p>
												订单号：<span>198409857093246</span>
											</p>
											<p class="right">剩余2天23小时59分钟</p>
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr class="width-16">
									<td class="text-l pl-20">我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td class="text-r"><input type="button"
										class="btn biu-btn btn-auto-25 btn-green radius10" value="支 付">
										<input type="button"
										class="btn biu-btn btn-auto-25 btn-red radius10" value="取 消">
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
											<p>
												订单号：<span>198409857093246</span>
											</p>
											<p class="right">剩余2天23小时59分钟</p>
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr class="width-16">
									<td class="text-l pl-20">我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td class="text-r"><input type="button"
										class="btn biu-btn btn-auto-25 btn-green radius10" value="确 认">
										<input type="button"
										class="btn biu-btn btn-auto-25 btn-red radius10" value="延时确认">
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
											<p>
												订单号：<span>198409857093246</span>
											</p>
											<p class="right">剩余2天23小时59分钟</p>
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr class="width-16">
									<td class="text-l pl-20">我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td class="text-r"><input type="button"
										class="btn biu-btn btn-auto-25 btn-red radius10" value="取 消">
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
											<p>
												订单号：<span>198409857093246</span>
											</p>
											<p class="right">剩余2天23小时59分钟</p>
										</div>
									</th>
								</tr>
							</thead>
							<tbody>
								<tr class="width-16">
									<td>我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td class="text-r"><input type="button"
										class="btn biu-btn btn-auto-25 btn-green radius10" value="评 价">
									</td>
								</tr>
							</tbody>
						</table>
					</div>

				</div>
			</div>


		</div>

	</div>
	<script type="text/javascript">
	var pager;
	(function() {
		seajs.use('app/jsp/user/userIndex', function(userIndexPager) {
			pager = new userIndexPager({
				element : document.body
			});
			pager.render();
		});
	})();
	</script>
</body>
</html>
