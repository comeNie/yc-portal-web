<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="uedroot" value="${pageContext.request.contextPath}/resources/template"/>
<jsp:include page="/inc/inc.jsp"/>
   <!--二级主体-->
  <!--外侧背景-->
  	<!--左侧菜单-->
  	<div class="left-subnav">
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
  				<li class="current">
  					<a href="我的订单-下过订单.html">
  					<span><i class="icon iconfont">&#xe600;</i></span>
  					<span>我的首页</span>
  					</a>
  				</li>
  				<li>
  					<a href="我的订单.html">
  					<span><i class="icon iconfont">&#xe601;</i></span>
  					<span>我的订单</span>
  					</a>
  				</li>
  				<li>
  					<a href="我的账户.html">
  					<span><i class="icon iconfont">&#xe602;</i></span>
  					<span>我的账户</span>
  					</a>
  				</li>
  				<li>
  					<a href="优惠卷.html">
  					<span><i class="icon iconfont">&#xe603;</i></span>
  					<span>优惠券</span>
  					</a>
  				</li>
  				<li>
  					<a href="我的级别.html">
  					<span><i class="icon iconfont">&#xe604;</i></span>
  					<span>我的级别</span>
  					</a>
  				</li>
  				<li>
  					<a href="我的积分.html">
  					<span><i class="icon iconfont">&#xe605;</i></span>
  					<span>我的积分</span>
  					</a>
  				</li>
  				<li>
  					<a href="发票管理.html">
  					<span><i class="icon iconfont">&#xe606;</i></span>
  					<span>发票管理</span>
  					</a>
  				</li>
  				<li>
  					<a href="企业中心.html">
  					<span><i class="icon iconfont">&#xe607;</i></span>
  					<span>企业中心</span>
  					</a>
  				</li>
  				<li>
  					<a href="个人信息.html">
  					<span><i class="icon iconfont">&#xe60c;</i></span>
  					<span>个人信息</span>
  					</a>
  				</li>
  				<li>
  					<a href="安全设置.html">
  					<span><i class="icon iconfont">&#xe609;</i></span>
  					<span>安全设置</span>
  					</a>
  				</li>
  			</ul>
  		</div>
  		<div class="left-phone">
  			<p><i class="icon iconfont">&#xe60d;</i></p>
  			<p class="phone-word">
  				<span>早9:00-晚7:00</span>
  				<span class="red">400-119-8080</span>
  			</p>
  		</div>
  		<div class="left-tplist"><a href="#"><img src="${uedroot}/images/to.jpg" /></a><i class="icon-remove-circle"></i></div>
  	</div>
