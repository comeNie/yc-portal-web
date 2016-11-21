<%--
  Created by IntelliJ IDEA.
  User: liquid
  Date: 16/11/18
  Time: 下午5:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>充值</title>
    <%@ include file="/inc/inc.jsp" %>
</head>
<body>
<!--弹出-->
<!--提示弹出框 操作-->
<div class="eject-big">
    <div class="prompt-samll" id="rechargepop">
        <div class="prompt-samll-title">请选择</div>
        <!--确认删除-->
        <div class="prompt-samll-confirm">
            <ul>
                <li>支付完成前请不要关闭此窗口。</li>
                <li>完成后请根据您的情况点击下面的按钮</li>
                <li class="eject-btn">
                    <input type="button" id="completed" class="btn btn-green btn-120 radius20" value="已完成支付">
                    <input type="button"  class="btn border-green btn-120 radius20" value="支付遇到困难">
                </li>
            </ul>
        </div>
    </div>
    <div class="mask" id="eject-mask"></div>
</div>
<!--/提示弹出框操作结束-->
<!--弹出结束-->

<!--头部-->
<div class="header-big">
    <div class="cloud-header">
        <div class="logo"><a href="#"><img src="../images/logo.png" /></a></div>
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
                <li>
                    <select class="select select-topmini none-select">
                        <option>简体中文</option>
                        <option>ENGLISH</option>
                    </select>
                    <i class="icon-caret-down"></i>
                </li>
                <li class="nav-icon"><a href="#"><i class="icon iconfont">&#xe60b;</i></a></li>
                <li class="nav-icon mt-2"><a href="#"><i class="icon iconfont">&#xe60a;</i><span class="message">3</span></a></li>
                <li class="user"><a href="#" class="yonh">爱大脸大脸<i class="icon-caret-down"></i></a>
                    <div class="show">
                        <ul>
                            <li><i class="icon-user"></i><a href="#">个人信息</a></li>
                            <li><i class="icon-lock"></i><a href="#">安全设置</a></li>
                            <li><i class="icon-off"></i><a href="#">退出</a></li>
                        </ul>
                    </div>
                </li>
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
            <div class="left-title">
                <ul>
                    <li class="user"><img src="../images/icon.jpg" /></li>
                    <li class="word">
                        <p>大脸盼爱大脸</p>
                        <p class="vip1"></p>
                    </li>
                </ul>
            </div>
            <div class="left-list">
                <ul>
                    <li>
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
                    <li class="current">
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
            <div class="left-tplist"><a hrel="#"><img src="../images/to.jpg" /></a><i class="icon-remove-circle"></i></div>
        </div>
        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <!--右侧第一块-->

            <!--右侧第二块-->
            <div class="right-list mt-0">
                <div class="right-list-title pb-10 pl-20">
                    <p>账户充值</p>
                </div>
                <!--充值-->
                <div class="recharge mt-30">
                    <div class="recharge-content">
                        <div class="recharge-unionPay">
                            <ul>
                                <a href="#" class="current"><li class="unicon"></li></a>
                                <a href="#" class="ml-50"><li  class="zhifb"></li></a>
                            </ul>
                        </div>
                        <div class="recharge-form-label mt-50">
                            <ul>
                                <li>
                                    <p class="word">充值账号:</p>
                                    <p>admin</p>
                                </li>
                                <li>
                                    <p class="word">充值账号:</p>
                                    <p><input type="text" class="int-text int-rech-medium radius"></p>
                                    <p>元</p>
                                </li>
                                <li class="tishi">
                                    <p>提示</p>
                                    <p>1.充值金额用于平台翻译下单的支付</p>
                                    <p>2.若需要提现账户余额,请致电客服400-119-8080</p>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <!--按钮-->
                    <div class="recharge-btn">
                        <input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="充 值">
                    </div>
                </div>

            </div>
        </div>


    </div>

</div>
<script type="text/javascript" src="../scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../scripts/modular/frame.js"></script>
<script type="text/javascript" src="../scripts/modular/eject.js"></script>
</body>
</html>

