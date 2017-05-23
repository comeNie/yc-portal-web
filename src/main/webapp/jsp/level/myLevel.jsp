<%@page import="com.ai.yc.protal.web.constants.Constants"%>
<%@page import="com.ai.opt.sdk.components.ccs.CCSClientFactory"%>
<%@ page import="com.ai.paas.ipaas.i18n.ZoneContextHolder" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <%--我的级别--%>
    <%@ include file="/inc/inc.jsp" %>
    <title>我的级别</title>
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
        <%@ include file="/inc/leftmenu.jsp"%>
        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <!--右侧第一块-->
            <div class="level-bj mt-0 h230">
                <div class="levelstep-title">
                    <p>我的级别：</p>
                    <p id="levelClass" <c:choose>
                        <c:when test="${level=='1'}">
                            class="v-2"
                        </c:when>
                        <c:when test="${level=='2'}">
                            class="v-2"
                        </c:when>
                        <c:when test="${level=='3'}">
                            class="v-3"
                        </c:when>
                        <c:when test="${level=='4'}">
                            class="v-4"
                        </c:when>
                    </c:choose>><!--按照vip等级改class v-1 v-2 v-3 v-4 -->
                        <span class="bj">
                            <i id="level">
                            <c:choose>
                                <c:when test="${level=='1'}">
                                    v1
                                </c:when>
                                <c:when test="${level=='2'}">
                                    v2
                                </c:when>
                                <c:when test="${level=='3'}">
                                    v3
                                </c:when>
                                <c:when test="${level=='4'}">
                                    v4
                                </c:when>
                            </c:choose>
                            </i>
                        </span>
                        <span class="word">
                            <c:choose>
                                <c:when test="${level=='1'}">
                                    普通会员
                                </c:when>
                                <c:when test="${level=='2'}">
                                    VIP会员
                                </c:when>
                                <c:when test="${level=='3'}">
                                    SVIP会员
                                </c:when>
                                <c:when test="${level=='4'}">
                                    SVIP白金会员
                                </c:when>
                            </c:choose>
                        </span>
                    </p>
                </div>
                <div class="levelstep-step">
                    <ul>
                        <li>
                            <p class="v1-wordcolor">
                                <span>${levelGriwth.ordinaryMember}</span>
                                <span class="v1-radius"></span>
                                <span>普通会员</span>
                            </p>
                            <div class="ash-border"><!--vip1 边框颜色--><p class="v1-border"
                                                                       <c:choose>
                                                                           <c:when test="${griwth<=levelGriwth.goldMember}">
                                                                               style="width:${(griwth/levelGriwth.goldMember)*100}%;"
                                                                           </c:when>
                                                                           <c:otherwise>
                                                                               style="width:100%;"
                                                                           </c:otherwise>
                                                                       </c:choose>
                                                                        ></p></div>
                        </li>
                        <li>
                            <p class="v2-wordcolor">
                                <span>${levelGriwth.goldMember}</span>
                                <span class="v2-radius"></span>
                                <span>VIP会员</span>
                            </p>
                            <div class="ash-border"><!--vip2 边框颜色--><p class="v2-border"
                                                                    <c:choose>
                                                                        <c:when test="${griwth<=levelGriwth.platinumMember&&griwth>levelGriwth.goldMember}">
                                                                            style="width:${((griwth-levelGriwth.goldMember)/(levelGriwth.platinumMember-levelGriwth.goldMember))*100}%;"
                                                                        </c:when>
                                                                        <c:when test="${griwth<=levelGriwth.goldMember}">
                                                                            style="width:0%;"
                                                                        </c:when>
                                                                        <c:otherwise>
                                                                            style="width:100%;"
                                                                        </c:otherwise>
                                                                    </c:choose>"></p>
                            </div>
                        </li>
                        <li>
                            <p class="v3-wordcolor">
                                <span>${levelGriwth.platinumMember}</span>
                                <span class="v3-radius"></span>
                                <span>SVIP会员</span>
                            </p>
                            <div class="ash-border"><!--vip3 边框颜色--><p class="v3-border"
                                                                    <c:choose>
                                                                            <c:when test="${griwth<=levelGriwth.masonryMember&&griwth>levelGriwth.platinumMember}">
                                                                                style="width:${((griwth-levelGriwth.platinumMember)/(levelGriwth.masonryMember-levelGriwth.platinumMember))*100}%;"
                                                                            </c:when>
                                                                            <c:when test="${griwth<=levelGriwth.platinumMember}">
                                                                                style="width:0%;"
                                                                            </c:when>
                                                                            <c:otherwise>
                                                                                style="width:100%;"
                                                                            </c:otherwise>
                                                                     </c:choose>"></p>

                            </div>
                        </li>
                        <li class="v4-width">
                            <p class="v4-wordcolor">
                                <span>${levelGriwth.masonryMember}</span>
                                <span class="v4-radius"></span>
                                <span>SVIP白金会员</span>
                            </p>
                        </li>
                    </ul>
                </div>
                <c:choose>
                    <c:when test="${level!='4'}">
                        <div class="levelstep-step-infor">您目前的成长值为${griwth} ，再获得${nextGriwth-griwth}成长值即可升级到
                        <c:choose>
                            <c:when test="${nextLevel=='2'}">
                                VIP会员
                            </c:when>
                            <c:when test="${nextLevel=='3'}">
                                SVIP会员
                            </c:when>
                            <c:when test="${nextLevel=='4'}">
                                SVIP白金会员
                            </c:when>
                        </c:choose>。<a href="${_base}/p/level/myLevel#griwth">成长值记录</a></div>
                    </c:when>
                    <c:otherwise>
                        <div class="levelstep-step-infor">您目前的成长值为${griwth} 。<a href="${_base}/p/level/myLevel#griwth">成长值记录</a></div>
                    </c:otherwise>
                </c:choose>
            </div>
            <!--右侧第二块-->
            <div class="level-bj mt-20">
                <div class="level-title">
                    <p>普通会员权利及优惠</p>
                </div>
                <div class="level-list">
                    <ul>
                        <li>
                            <p class="img1"></p>
                            <p>升级礼包</p>
                        </li>
                        <li>
                            <p class="img2"></p>
                            <p>生日礼包</p>
                        </li>
                        <li>
                            <p class="img3"></p>
                            <p>免费修改</p>
                        </li>
                        <li>
                            <p class="img4"></p>
                            <p>邮寄优惠</p>
                        </li>
                        <li>
                            <p class="img5"></p>
                            <p>会员优惠</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="level-bj mt-20">
                <div class="change-list">
                    <ul>
                        <li class="title">会员级别变动记录：</li>
                        <c:forEach items="${levelChanges}" var="levelchange">
                            <li>
                                <p><fmt:formatDate value="${levelchange.updateTime}" pattern="yyyy-MM-dd"/></p>
                                <p>升级为
                                    <c:choose>
                                        <c:when test="${levelchange.level=='1'}">
                                            普通会员
                                        </c:when>
                                        <c:when test="${levelchange.level=='2'}">
                                            VIP会员
                                        </c:when>
                                        <c:when test="${levelchange.level=='3'}">
                                            SVIP会员
                                        </c:when>
                                        <c:when test="${levelchange.level=='4'}">
                                            SVIP白金会员
                                        </c:when>
                                    </c:choose>
                                </p>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
            <div class="level-bj mt-20">
                <div class="change-list">
                    <ul>
                        <li class="title">会员级别图示：</li>
                    </ul>
                </div>
                <div class="vip-level">
                    <ul>
                        <li>
                            <p class="img1"></p>
                            <p class="v-1">普通会员</p>
                            <p>注册即成为注册会员</p>
                        </li>
                        <li>
                            <p class="img2"></p>
                            <p class="v-2">VIP会员</p>
                            <p>成长值大于${levelGriwth.goldMember}</p>
                        </li>
                        <li>
                            <p class="img3"></p>
                            <p class="v-3">SVIP会员</p>
                            <p>成长值大于${levelGriwth.platinumMember}</p>
                        </li>
                        <li>
                            <p class="img4"></p>
                            <p class="v-4">SVIP白金会员</p>
                            <p>成长值大于${levelGriwth.masonryMember}</p>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="level-bj mt-20">
                <div class="change-list" id="griwth">
                    <ul>
                        <li class="title">成长值记录<a href="${_base}/faq">什么是成长值</a></li>
                        <li></li>
                    </ul>
                </div>
                <div class="right-list-table pl-20 pr-20 mb-40">
                    <table class="table table-bg  table-striped-even table-height50">
                        <thead>
                        <tr>
                            <th width="20%">时间</th>
                            <th width="20%">成长值</th>
                            <th width="20%">成长值来源</th>
                            <th width="40%">详细说明</th>
                        </tr>
                        </thead>
                        <tbody id="searchLevelData"></tbody>
                    </table>
                </div>
                <%--成长值列表结束--%>
                <div id="showGriwthDiv"></div>
                <%--分页--%>
                <div class="biu-paging paging-large">
                    <ul id="pagination-ul">
                    </ul>
                </div>
            </div>

        </div>
    </div>
</div>
<%@include file="/inc/userFoot.jsp"%>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script id="searchGriwthTemple" type="text/template">
    <tr>
        <td >{{:~timestampToDate('yyyy-MM-dd hh:mm:ss',resourceTime,'<%=ZoneContextHolder.getZone()%>')}}</td>
        <td>
            {{:griwthValue}}
        </td>
        <td>
            {{:griwthResource}}
        </td>
        <td >
            {{:resourceDetail}}
        </td>
    </tr>
    <%--</tbody>--%>
</script>

<script type="text/javascript">
    var pager;
    var current = "mylevel";
    (function () {
        seajs.use('app/jsp/mylevel/level', function(griwthListPage) {
            pager = new griwthListPage({element : document.body});
            pager.render();
        });
    })();
</script>
</html>
