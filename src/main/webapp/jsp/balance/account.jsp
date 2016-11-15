<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>我的账户</title>
    <%@ include file="/inc/inc.jsp" %>
</head>
<body>
<!--头部-->
<%@ include file="/inc/userTopMenu.jsp" %>
<!--二级主体-->
<!--外侧背景-->
<div class="cloud-container">
    <!--内侧内容区域-->
    <div class="cloud-wrapper">
        <!--左侧菜单-->
        <jsp:include page="/inc/leftmenu.jsp">
            <jsp:param name="current" value="myaccount" />
        </jsp:include>
        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <!--右侧第一块-->
            <div class="right-title">
                <div class="right-title-left user-account-title">
                    <div class="right-title-left-word user-account-title-word">
                        <ul>
                            <li class="user-word">账户余额</li>
                        </ul>
                        <ul>
                            <li class="word"><span>19835209.00</span>CNY</li>
                            <li class="c-bj-bule"><a href="#">充值余额</a></li>
                        </ul>
                        <ul class="word-li">
                            <li>为保证账户安全，如需提现，请致电译云客服进行申请和审核：400-119-8080</li>
                        </ul>
                    </div>
                </div>
                <div class="user-title-right"><img src="../images/user-bj.jpg" /></div>
            </div>
            <!--右侧第二块-->
            <div class="right-list">
                <div class="query-order">
                    <ul>
                        <li class="left">
                            <p><a href="#">今天</a></p>
                            <p class="current"><a href="#">近一个月</a></p>
                            <p><a href="#">近三个月</a></p>
                            <p><a href="#">近一年</a></p>
                        </li>
                        <li class="right">
                            <p>收入:1244.28CNY</p>
                            <p>支出:122.33USD</p>
                            <p><a href="#" class="is">收起筛选<i class="icon-angle-down"></i></a></p>
                        </li>
                    </ul>
                </div>
                <div class="query-order order-hiddn">
                    <ul>
                        <li class="left li-xlarge li-xlarge-ml">
                            <p><a href="#">订单时间</a></p>
                            <p><input type="text" class="int-text int-mini radius"></p>
                            <p>~</p>
                            <p><input type="text" class="int-text int-mini radius"></p>
                        </li>
                        <li class="left li-xlarge">
                            <p>收支:</p>
                            <p class="current"><a href="#">收入</a></p>
                            <p><a href="#">支出</a></p>
                            <p><a href="#">近一年</a></p>
                        </li>
                        <li class="left li-xlarge">
                            <p>类型:</p>
                            <p><a href="#">充值</a></p>
                            <p><a href="#">提现</a></p>
                            <p class="current"><a href="#">下单</a></p>
                            <p><a href="#">退款</a></p>
                        </li>

                    </ul>
                </div>

                <div class="right-list-table">
                    <table class="table table-bg  table-striped-even table-height50">
                        <thead>
                        <tr>
                            <th>时间</th>
                            <th>收入</th>
                            <th>支出</th>
                            <th>余额</th>
                            <th>类型</th>
                            <th>对方</th>
                            <th>详细说明</th>
                        </tr>
                        </thead>
                        <tbody>
                        <tr>
                            <td>1987-11-04 08:18:08</td>
                            <td class="red">+$23.00</td>
                            <td class="green">-$1000.00</td>
                            <td>$1000.00</td>
                            <td>充值</td>
                            <td>支付宝</td>
                            <td>成功充值</td>
                        </tr>
                        <tr>
                            <td>1987-11-04 08:18:08</td>
                            <td class="red">+$23.00</td>
                            <td class="green">-$1000.00</td>
                            <td>$1000.00</td>
                            <td>充值</td>
                            <td>支付宝</td>
                            <td>成功充值</td>
                        </tr>
                        <tr>
                            <td>1987-11-04 08:18:08</td>
                            <td class="red">+$23.00</td>
                            <td class="green">-$1000.00</td>
                            <td>$1000.00</td>
                            <td>充值</td>
                            <td>支付宝</td>
                            <td>成功充值</td>
                        </tr>
                        <tr>
                            <td>1987-11-04 08:18:08</td>
                            <td class="red">+$23.00</td>
                            <td class="green">-$1000.00</td>
                            <td>$1000.00</td>
                            <td>充值</td>
                            <td>支付宝</td>
                            <td>成功充值</td>
                        </tr>
                        <tr>
                            <td>1987-11-04 08:18:08</td>
                            <td class="red">+$23.00</td>
                            <td class="green">-$1000.00</td>
                            <td>$1000.00</td>
                            <td>充值</td>
                            <td>支付宝</td>
                            <td>成功充值</td>
                        </tr>


                        </tbody>
                    </table>

                </div>

            </div>
        </div>


    </div>

</div>
<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
</body>
</html>

