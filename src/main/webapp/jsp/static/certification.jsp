<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>译者认证</title>
	<%@include file="/inc/inc.jsp" %>
</head>
<body class="static-body">
<!--面包屑导航-->
<%@include file="/inc/topHead.jsp" %>
<!--主导航-->
<%@include file="/inc/topMenu.jsp" %>
<!--主体-->
<div class="card-banner">
	<div class="card-list">
		<ul>
			<li><span> 赚钱、学习 、长经验，就选“译云”</span><br>
在线自由接单、交易全程担保、免费语料工具，随时随地 想翻就翻</li>
			<li class="pacbtn"><input type="button" class="btn card-border-blue btn-168 radius20" value="加入译云"></li>
		</ul>
	</div>
</div>
<div class="static-wrapper">
	<!--标题-->
	<div class="static-title">
		<p>译者认证</p>
		<p class="line1"></p>
	</div>

	<div id="st1">
		<div class="static-tab card-tab">
			<ul>
				<li class="current">
					<a href="javaScript:void(0);">
					<p class="icon2" id="tab-icon2"></p>
					</a>
					<p class="word word-font">注册译云</p>
				</li>
				<div class="line"></div>
				<li id="st1-btn">
					<a href="javaScript:void(0);">
					<p class="icon9" id="tab-icon9"></p>
					</a>
					<p class="word word-font">认证译员</p>
				</li>
				<div class="line1"></div>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon11" id="tab-icon11"></p>
					</a>
					<p class="word word-font">开始接单</p>
				</li>
			</ul>
		</div>

		<div class="static-list">
			<ul>
				<li class="word"><span>第一步</span> 注册译云</li>
				<li>注册/登录译云账户，点击”立即下单“，选择需要的业务类型，根据提示完成并提交您的翻译任务即可。目前，译云提供了快速翻译、文档翻译、简历翻译、创意翻译、证件翻译、口译翻译几大业务类型。</li>
			</ul>
		</div>
	</div>
	<div id="st2">
		<div class="static-tab card-tab">
			<ul>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon1" id="tab-icon1"></p>
					</a>
					<p class="word word-font">注册译云</p>
				</li>
				<div class="line"></div>
				<li class="current">
					<a href="javaScript:void(0);">
					<p class="icon10  ml-50" id="tab-icon10"></p>
					</a>
					<p class="word word-font">认证译员</p>
				</li>
				<div class="line1"></div>
				<li id="st1-btn1">
					<a href="javaScript:void(0);">
					<p class="icon11" id="tab-icon11"></p>
					</a>
					<p class="word word-font">开始接单</p>
				</li>
			</ul>
		</div>

		<div class="static-list">
			<ul>
				<li class="word"><span>第二步</span> 认证译员</li>
				<li>通过译员认证的译员方可领取任务。首先，在您添加完“可翻译语言”后，可以点击“去测试”参与该语种的译员认证测试；同时，请您认真填写和提交相关个人信息和认证资料，包括您的个人简介、工作经验、教育信息及资质证书，完成后，请点击“提交”，等待译员审核。</li>
			</ul>
		</div>
	</div>

		<div id="st3">
		<div class="static-tab card-tab">
			<ul>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon1" id="tab-icon1"></p>
					</a>
					<p class="word word-font">注册译云</p>
				</li>
				<div class="line"></div>
				<li>
					<a href="javaScript:void(0);">
					<p class="icon9" id="tab-icon9"></p>
					</a>
					<p class="word word-font">认证译员</p>
				</li>
				<div class="line1"></div>
				<li class="current">
					<a href="javaScript:void(0);">
					<p class="icon12" id="tab-icon12"></p>
					</a>
					<p class="word word-font">开始接单</p>
				</li>
			</ul>
		</div>

		<div class="static-list">
			<ul>
				<li class="word"><span>第三步</span> 开始接单</li>
				<li>注册/登录译云账户，点击”立即下单“，选择需要的业务类型，根据提示完成并提交您的翻译任务即可。目前，译云提供了快速翻译、文档翻译、简历翻译、创意翻译、证件翻译、口译翻译几大业务类型。</li>
			</ul>
		</div>
	</div>

</div>
<!--底部-->
<%@include file="/inc/indexFoot.jsp" %>
			
<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/jqueryrotate.2.3.js"></script>
</body>
</html>
