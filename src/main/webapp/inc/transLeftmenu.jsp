<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="uedroot" value="${pageContext.request.contextPath}/resources/template"/>
<c:set var="_base" value="${pageContext.request.contextPath}"/>
<script src="${_base}/resources/spm_modules/jquery/1.9.1/jquery.min.js"></script>
<div class="left-subnav interpreter-subanav">
	<div class="left-title">
		<ul>
			<li class="user"><img src="${uedroot}/images/icon.jpg" /></li>
			<li class="word">
				<p>大脸盼爱大脸</p>
				<p class="vip1"></p>
			</li>
		</ul>
	</div>
	<div class="left-list">
		<ul>
			<li id="index" class="current">
				<a href="${_base}/p/security/interpreterIndex">
					<span><i class="icon iconfont">&#xe600;</i></span>
					<span>我的首页</span>
				</a>
			</li>
			<li >
				<a href="#">
					<span><i class="icon iconfont">&#xe68e;</i></span>
					<span>发现订单</span>
				</a>
			</li>
			<div class="list-p current"><a href="#" class="">订单大厅<span> (99+)</span></a></div>
			<div class="list-p"><a href="#">分配订单 <span> (7)</span></a></div>
			<li>
				<a href="#">
					<span><i class="icon iconfont">&#xe602;</i></span>
					<span>我的订单</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span><i class="icon iconfont">&#xe603;</i></span>
					<span>优惠券</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span><i class="icon iconfont">&#xe604;</i></span>
					<span>译员级别</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span><i class="icon iconfont">&#xe65f;</i></span>
					<span>工作记录</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span><i class="icon iconfont">&#xe606;</i></span>
					<span>LSP管理</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span><i class="icon iconfont">&#xe60c;</i></span>
					<span>个人信息</span>
				</a>
			</li>
			<li>
				<a href="#">
					<span><i class="icon iconfont">&#xe609;</i></span>
					<span>安全设置</span>
				</a>
			</li>
		</ul>
	</div>
	<!--定位-->
	<div class="locationaaa">
		<div class="left-phone">
			<p><i class="icon iconfont">&#xe60d;</i></p>
			<p class="phone-word">
				<span>早9:00-晚7:00</span>
				<span class="red">400-119-8080</span>
			</p>
		</div>
		<div class="left-tplist"><a hrel="#"><img src="${uedroot}/images/to.jpg" /></a><i class="icon-remove-circle"></i></div>
	</div>
</div>
  	<script type="text/javascript">
  	  var current ="${param.current}";
  	  $(function(){
  		var currentEle = $("#"+current);
    	  if(current!=""&&currentEle){
    		$("#left_menu_list ul li").removeClass("current");
    		currentEle.addClass("current");
    	  } 
  	  });
  	</script>