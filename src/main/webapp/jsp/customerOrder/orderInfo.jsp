<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>订单详细</title>
    <%@ include file="/inc/inc.jsp" %>
</head>
<body>
<!--头部-->
<%@include file="/inc/userTopMenu.jsp"%>
<!--二级主体-->
<!--外侧背景-->
<div class="cloud-container">
    <!--内侧内容区域-->
    <div class="cloud-wrapper">
        <!--左侧菜单-->
        <%@include file="/inc/leftmenu.jsp"%>
        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <div class="breadcrumb">
                <p>我的订单></p>
                <p>订单：5000345</p>
            </div>
            <!--订单详细待确认-->
            <div class="step-big">
                <!--步骤-->
                <div class="step">
                    <!--通过的状态-->
                    <div class="step-none adopt-green-bj">
                        <ul>
                            <li class="circle"><i class="icon iconfont">&#xe610;</i></li>
                            <li class="word">提交订单</li>
                        </ul>
                        <p class="green-line"></p>
                    </div>
                    <!--正进行的状态-->
                    <div class="step-none adopt-ash-border">
                        <ul>
                            <li class="circle"><i class="icon iconfont">&#xe608;</i></li>
                            <li class="word">支付订单</li>
                        </ul>
                        <p class="green-line"></p>
                    </div>
                    <!--没通过的状态-->
                    <div class="step-none adopt-ash-border">
                        <ul>
                            <li class="circle"><i class="icon iconfont">&#xe60f;</i></li>
                            <li class="word">翻译中</li>
                        </ul>
                        <p class="green-line"></p>
                    </div>
                    <!--没通过的状态-->
                    <div class="step-none  step-small adopt-ash-border ">
                        <ul>
                            <li class="circle"><i class="icon iconfont">&#xe60e;</i></li>
                            <li class="word">确认完成</li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--订单table-->
            <div class="confirmation-table mt-20">
                <div class="oder-table">
                    <ul>
                        <li><a href="#" class="current">翻译内容</a></li>
                        <li><a href="#">订单跟踪</a></li>
                    </ul>
                </div>
                <div id="translate1">
                    <div class="confirmation-list">
                        <ul>
                            <li class="title">原文:</li>
                            <li class="word">翻译是在准确、通顺的基础上，把一种语言信息转变成另一种语言信息的行为。翻译是将一种相对陌生的表达方式，转换成相对熟悉的表达方式的过程。其内容有语言、文字、图形、符号的翻译。其中，“翻”是指对交谈的语言转换，“译”是指对单向陈述的语言转换。“翻”是指对交谈中的两种语言进行即时的、一句对一句的转换，即先把一句甲语转<A href="#">[更多]</A></li>
                        </ul>
                        <ul class="mt-30">
                            <li class="title">译文:</li>
                            <li class="word">The translation is accurate and fluent on the basis of one language into another language behavior. Translation is a relatively unfamiliar way of expression, into a relatively familiar with the way of expression of the process. Its contents are language, text, graphics, symbols, translation. Among them, "turning" refers to <A href="#">[更多]</A></li>
                        </ul>
                    </div>
                </div>
                <div id="translate2" style="display: none;">
                    <div class="tracking-list">
                        <ul>
                            <li class="conduct">
                                <p>2015-04-07 11:04:04</p>
                                <p class="right">订单已被译员领取，正在翻译中，请耐心等待</p>
                            </li>
                            <li>
                                <p>2015-04-07 11:04:04</p>
                                <p class="right">订单已被译员领取，正在翻译中，请耐心等待</p>
                            </li>
                            <li>
                                <p>2015-04-07 11:04:04</p>
                                <p class="right">订单已被译员领取，正在翻译中，请耐心等待</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
            <!--订单内容-->
            <div class="oder-detailed">
                <div class="right-list-title pb-10 pl-20">
                    <p>订单详细</p>
                </div>
                <div class="oder-information">
                    <div class="info-list">
                        <span>订单信息</span>
                        <ul>
                            <li>
                                <p class="word">订单号:</p>
                                <p>1658735989</p>
                            </li>
                            <li>
                                <p class="word">翻译主题:</p>
                                <p>1658735989</p>
                            </li>
                            <li>
                                <p class="word">翻译语言:</p>
                                <p>英文→中文</p>
                            </li>
                            <li>
                                <p class="word">翻译级别:</p>
                                <p>英文→中文</p>
                            </li>
                            <li>
                                <p class="word">用途:</p>
                                <p>通用</p>
                            </li>
                            <li>
                                <p class="word">领域:</p>
                                <p>通用</p>
                            </li>
                            <li>
                                <p class="word">创建时间:</p>
                                <p>2015-04-07 09:53:51</p>
                            </li>
                            <li>
                                <p class="word">预计翻译耗时:</p>
                                <p>3天15小时8分</p>
                            </li>
                            <li>
                                <p class="word">其他:</p>
                                <p>加急;需要排版</p>
                            </li>
                            <li class="width-large">
                                <p class="word">需求备注:</p>
                                <p class="p-large">翻译需求是什么翻译翻译需求是什么翻译需求是什么,翻译需求是什么翻译需求是什么翻译需求是什么需求是什么翻译需求是什么翻译需求是什么翻译需求是什么翻译需求是什么</p>
                            </li>
                        </ul>
                    </div>
                    <div class="info-list">
                        <span>订单金额</span>
                        <ul>
                            <li class="width-large">
                                <p class="word">订单金额:</p>
                                <p>130.00元</p>
                            </li>
                            <li class="width-large">
                                <p class="word">折扣:</p>
                                <p>9.0折</p>
                            </li>
                            <li class="width-large">
                                <p class="word">优惠券:</p>
                                <p>-</p>
                            </li>
                            <li class="width-large">
                                <p class="word">优惠码:</p>
                                <p>5.00元</p>
                            </li>
                            <li class="width-large red">
                                <p class="word">实付金额:</p>
                                <p><b>100.00</b>元</p>
                            </li>
                        </ul>
                    </div>
                    <div class="info-list">
                        <span>联系人信息</span>
                        <ul>
                            <li class="width-large">
                                <p>张三，13800000000，zhangsan@ZS.com</p>
                            </li>
                        </ul>
                    </div>
                    <div class="info-list">
                        <span>发票</span>
                        <ul>
                            <li class="width-large">
                                <p class="word">发票类型:</p>
                                <p>不开发票</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <!--按钮-->
                <div class="recharge-btn order-btn">
                    <input type="button" id="recharge-popo" class="btn btn-green btn-xxxlarge radius10" value="支付订单">
                </div>

            </div>


        </div>


    </div>

</div>
<script type="text/javascript" src="../scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="../scripts/modular/frame.js"></script>
</body>
</html>
