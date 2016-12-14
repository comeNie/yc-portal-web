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
			<li class="pacbtn"><input id="join-btn" type="button" class="btn card-border-blue btn-168 radius20" value="加入译云"></li>
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
					<a href="javascript:">
						<p class="icon1" id="tab-icon1"></p>
					</a>
					<p class="word word-font">注册译云</p>
				</li>
				<div class="line"></div>
				<li id="st1-btn">
					<a href="javascript:">
						<p class="icon9" id="tab-icon9"></p>
					</a>
					<p class="word word-font">认证译员</p>
				</li>
				<div class="line1"></div>
				<li>
					<a href="javascript:">
						<p class="icon11" id="tab-icon11"></p>
					</a>
					<p class="word word-font">开始接单</p>
				</li>
			</ul>
		</div>
		<div id="renz-table1">
			<div class="static-list">
				<ul>
					<li class="word"><span>第一步</span> 注册译云</li>
					<li>您可以使用手机号或者邮箱进行注册。若使用手机号注册，须填入正确的短信验证码，并设置密码，点击“立即注册”即可；若使用邮箱进行注册，在填写完验证码并设置好密码后，还须进入邮箱进行邮件激活，方能完成注册。</li>
				</ul>
			</div>
		</div>
		<div id="renz-table2" style="display: none;">
			<div class="static-list">
				<ul>
					<li class="word"><span>第二步</span> 认证译员</li>
					<li>通过译员认证的译员方可领取任务。首先，在您添加完“可翻译语言”后，可以点击“去测试”参与该语种的译员认证测试；同时，请您认真填写和提交相关个人信息和认证资料，包括您的个人简介、工作经验、教育信息及资质证书，完成后，请点击“提交”，等待译员审核。</li>
				</ul>
			</div>
		</div>
		<div id="renz-table3"  style="display: none;">
			<div class="static-list">
				<ul>
					<li class="word"><span>第三步</span> 开始接单</li>
					<li>只有通过语种测试的译员才可以领取该语种的任务。通过“”译员“入口登陆后，点击”领取任务“进入任务大厅，您可以通过选择”任务类型“、”发布时间“等方式搜索感兴趣的翻译任务，未被领取的任务将显示在右侧列表中，点击“详细”可查看原文内容，点击”领取“即可轻松领取任务。</li>
				</ul>
			</div>
		</div>
	</div>

</div>
<!--底部-->
<%@include file="/inc/indexFoot.jsp" %>
			
<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/jqueryrotate.2.3.js"></script>

<script type="text/javascript">
	$("#join-btn").click(function () {
		window.location.href = "${_base}/p/security/interpreterIndex";
	});
</script>
</body>
</html>
