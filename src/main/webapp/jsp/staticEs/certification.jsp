<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<%--译者认证--%>
    <title>Translator certification</title>
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
			<%--要赚钱，学习，长时间的经验，选择“翻译云”--%>
			<li><span>Choose YeeCloud to earn money, study, and gain experience</span><br>
				<%--在线自由接单、交易全程担保、免费语料工具，随时随地 想翻就翻--%>
				Free order acceptance, guaranteed transaction, and free corpus and toolkits. Translating anytime, anywhere</li>
				<%--加入译云--%>
				<li class="pacbtn"><input id="join-btn" type="button" class="btn card-border-blue btn-168 radius20" value="Join Us"></li>
		</ul>
	</div>
</div>
<div class="static-wrapper">
	<!--标题-->
	<div class="static-title">
		<%--译者认证--%>
		<p>Certification</p>
		<p class="line1"></p>
	</div>


	<div id="st1">
		<div class="static-tab card-tab">
			<ul>
				<li class="current">
					<a href="javascript:">
						<p class="icon1" id="tab-icon13" style="display:none;"></p>
						<p class="icon2" id="tab-icon14"></p>
					</a>
					<p class="word word-font">Registration</p>
				</li>
				<div class="line"></div>
				<li id="st1-btn">
					<a href="javascript:">
						<p class="icon9" id="tab-icon9"></p>
						<p class="icon10" id="tab-icon10" style="display:none;"></p>
					</a>
					<p class="word word-font">Certification</p>
				</li>
				<div class="line1"></div>
				<li>
					<a href="javascript:">
						<p class="icon11" id="tab-icon11"></p>
						<p class="icon12" id="tab-icon12" style="display:none;"></p>
					</a>
					<p class="word word-font">Translation</p>
				</li>
			</ul>
		</div>
		<div id="renz-table1">
			<div class="static-list">
				<ul>
					<li class="word"><span>Step 1 </span>Register for YeeCloud</li>
					<%--您可以使用手机号或者邮箱进行注册。若使用手机号注册，须填入正确的短信验证码，并设置密码，点击“立即注册”即可；若使用邮箱进行注册，在填写完验证码并设置好密码后，还须进入邮箱进行邮件激活，方能完成注册。--%>
					<li>You can register with mobile phone number or email. If you use a mobile phone number, you must fill in the correct message verification code, set a password, and click "Register Now." If you use an email address, after filling in the verification code and setting your password, you must activate your account by checking your email to complete registration.</li>
				</ul>
			</div>
		</div>
		<div id="renz-table2" style="display: none;">
			<div class="static-list">
				<ul>
					<li class="word"><span>Step 2 </span>Pass the translator certification</li>
					<%--通过译员认证的译员方可领取任务。首先，在您添加完“可翻译语言”后，可以点击“去测试”参与该语种的译员认证测试；同时，请您认真填写和提交相关个人信息和认证资料，包括您的个人简介、工作经验、教育信息及资质证书，完成后，请点击“提交”，等待译员审核。--%>
					<li>Only certified translators are allowed to claim translation tasks. First, after you add "Translatable Languages," you can click "Go To Test" to participate in the translator certification test for that language. Meanwhile, please carefully fill in and submit your related personal information and certified information, including your resume, work experience, educational background, and qualification certificates. Then, click "Submit" to wait for your certification.</li>
				</ul>
			</div>
		</div>
		<div id="renz-table3"  style="display: none;">
			<div class="static-list">
				<ul>
					<li class="word"><span>Step 3 </span>Accept translation orders</li>
					<%--只有通过语种测试的译员才可以领取该语种的任务。通过“”译员“入口登陆后，点击”领取任务“进入任务大厅，您可以通过选择”任务类型“、”发布时间“等方式搜索感兴趣的翻译任务，未被领取的任务将显示在右侧列表中，点击“详细”可查看原文内容，点击”领取“即可轻松领取任务。--%>
					<li>Only certified translators are allowed to claim translation tasks for a certain language. First, you need to log in to your YeeCloud account from "Translators" entry. Then, click "Claim Task" to enter the task hall. You can search for translation tasks that you are interested in by selecting the "Type of Task" and "Time of Release." Unclaimed translation tasks will be shown in a list on the right side of your screen. You can click "Details" to view the original text; simply click "Claim" to claim the task.</li>
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
