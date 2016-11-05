<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<title>订单</title>
<%@ include file="/inc/inc.jsp"%>
</head>
<body>
	<!--头部-->
	<div class="header-big">
		<div class="cloud-header">
			<div class="logo">
				<a href="#"><img src="${uedroot}/images/logo.png" /></a>
			</div>
			<!--导航-->
			<div class="cloud-nav">
				<ul>
					<li class="current"><a href="#">我是客户</a></li>
					<li><a href="#">我是服务方</a></li>
				</ul>
			</div>
			<!--导航-->
			<div class="cloud-breadcrumb">
				<ul>
					<li><select class="select select-topmini none-select">
							<option>简体中文</option>
							<option>ENGLISH</option>
					</select> <i class="icon-caret-down"></i></li>
					<li class="nav-icon"><a href="#"><i class="icon iconfont">&#xe60b;</i></a></li>
					<li class="nav-icon mt-2"><a href="#"><i
							class="icon iconfont">&#xe60a;</i><span class="message">3</span></a></li>
					<li class="user"><a href="#" class="yonh">爱大脸大脸<i
							class="icon-caret-down"></i></a>
						<div class="show">
							<ul>
								<li><i class="icon-user"></i><a href="#">个人信息</a></li>
								<li><i class="icon-lock"></i><a href="#">安全设置</a></li>
								<li><i class="icon-off"></i><a href="#">退出</a></li>
							</ul>
						</div></li>
				</ul>
			</div>
		</div>
	</div>
	<!--二级主体-->
	<!--外侧背景-->
	<div class="cloud-container">
		<!--内侧内容区域-->
		<div class="cloud-wrapper">
			<!--左侧菜单-->
			<div class="left-subnav">
				<jsp:include page="/inc/leftmenu.jsp" />
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
							<span class="tp1"></span> <span><a href="#">待支付<b>1</b></a></span>
						</p>
						<p>
							<span class="tp2"></span> <span><a href="#">翻译中<b>9</b></a></span>
						</p>
						<p>
							<span class="tp3"></span> <span><a href="#">待确认<b>12</b></a></span>
						</p>
						<p>
							<span class="tp4"></span> <span><a href="#">待评价<b>2</b></a></span>
						</p>
					</div>
				</div>
				<!--右侧第二块-->
				<div class="right-list" id="order_list_container">
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
									<td>我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td><input type="button"
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
									<td>我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td><input type="button"
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
									<td>我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td><input type="button"
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
									<td>我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td><input type="button"
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
									<td>我要翻译一段话，不超过15……</td>
									<td>admin</td>
									<td>中文→西班牙语</td>
									<td>1000.00</td>
									<td>待支付</td>
									<td><input type="button"
										class="btn biu-btn btn-auto-25 btn-red radius10" value="取 消">
									</td>
								</tr>
							</tbody>
						</table>

					</div>

				</div>
				<!--没下过订单-->
				<div class="right-list" id="no_order_container"
					style="display: none;">
					<div class="no-order">
						<ul>
							<li><img src="${uedroot}/images/none-d.jpg" /></li>
							<li class="mt-t50">您还没有任何订单交易</li>
							<li class="right mt-t50"><input type="button"
								class="btn border-blue btn-large radius20 blue" value="立即下单"></li>
						</ul>
					</div>
					<div class="no-step">
						<img src="${uedroot}/images/step.jpg" />
					</div>
				</div>
			</div>

		</div>
	</div>
</body>
<%@ include file="/inc/incJs.jsp" %>
</html>
