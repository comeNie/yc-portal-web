<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <%@ include file="/inc/inc.jsp" %>
    <title><spring:message code="myOrder.Orderdetails"/></title>
    <link rel="stylesheet" type="text/css" href="${_base}/resources/spm_modules/webuploader/webuploader.css">
    <style>
        .webuploader-pick {
            width: 80px;
            height: 25px;
            font-size: 12px;
            color: #2965e6;
            border: 1px solid #2361ea;
            background: #fff;
            color: #2361ea;
            font-weight: normal;
            line-height: 5px;
            left: 80px;
            cursor: pointer;
            text-align: center;
            outline: none;
            border-radius: 30px;
        }

        .webuploader-container {
            width: 80px;
            height: auto;
        }
    </style>
</head>
<body>
<c:choose>
    <c:when test="${orderDetails.translateType == '2'}">
        <script id="tranEdit" type="text/template">
                    <%--输入姓名--%>
                <td class="text-l"><input class="in-con" type="text" name="name" maxlength="50"
                                          oldVal="{{:name}}" value="{{:name}}"
                                          placeholder="<spring:message code="myOrder.enter.name"/>"/></td>
                    <%--输入联系方式--%>
                <td class="text-l"><input class="in-con" type="text" name="number" maxlength="11"
                                          oldVal="{{:number}}" value="{{:number}}"
                                          placeholder="<spring:message code="myOrder.enter.contact.info"/>"/></td>
                <td class="operate">
                        <%--保存--%>
                    <A href="javaScript:void(0);" class="blue-icon"><i class="finished-img"></i></A>
                        <%--取消--%>
                    <A href="javaScript:void(0);" class="red-icon"><i op="{{:opType}}" class="close-img"></i></A>
                </td>
        </script>
        <script id="tranView" type="text/template">
                <td class="text-l"><span class="name" name="name">{{:name}}</span></td>
                <td><span class="number" name="number">{{:number}}</span></td>
                <td class="operate">
                    <A href="javaScript:void(0);" class="blue-icon"><i class="edit-img"></i></A>
                    <A href="javaScript:void(0);" class="red-icon"><i class="delete-img"></i></A>
                </td>
        </script>
<!--口译分配弹出-->
<div class="eject-big undistribute-dlog" >
    <div class="prompt-big assign-tran-dialog" id="tran" assign-tran-dialog>
        <%--分配译员--%>
        <div class="prompt-big-title"><spring:message code="myOrder.assign.interpreter"/></div>
        <div class="prompt-center">
            <div id="tran-tab1" class="clearfix">
                <div class="prompt-center-table">
                    <table class="table table-bg  table-height60">
                        <tbody id="oralTrans">
                        </tbody>
                    </table>
                </div>
                <div class="add-toicon">
                        <%--添加译员--%>
                    <a href="javaScript:void(0);" id="addInterpreter"><i class="icon iconfont">&#xe633;</i><spring:message
                            code="myOrder.add.translator"/></a>
                </div>
            </div>
            <div class="prompt-samll-confirm prompt-mt">
                <ul>
                    <li class="eject-btn">
                        <input type="button" id="tran-determine" class="btn btn-green btn-100 radius20" value="确定">
                        <input type="button" id="tran-close" class="btn border-green btn-100 radius20 ml-50" value="取消">
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="mask" id="eject-mask"></div>
</div>
        <!--口译分配弹出结束-->
    </c:when>
    <c:otherwise>
<!--笔译分配弹出-->
<div class="eject-big undistribute-dlog">
    <div class="prompt-big" id="tran">
        <div class="prompt-big-title">分配任务</div>
        <div class="prompt-center">
            <div class="prompt-center-title">
                <ul>
                    <li><a href="javaScript:void(0);" class="current">翻译</a></li>
                    <li><a href="javaScript:void(0);">审校</a></li>
                    <li><a href="javaScript:void(0);">审校1</a></li>
                    <p><a href="javaScript:void(0);"><i class="icon iconfont">&#xe633;</i>添加步骤</a></p>
                </ul>
            </div>
            <div id="tran-tab1">
                <div class="prompt-center-table">
                    <table class="table table-bg  table-height60">
                        <tbody>
                        <tr>
                            <td class="text-l"><span class="name">李菁菁</span></td>
                            <td>500元/千字</td>
                            <td class="text-center">2300字</td>
                            <td class="text-center">共<span class="money">12487</span>元</td>
                            <td class="operate"><A href="#" class="blue-icon"><i  class="edit-img"></i></A><A href="#"  class="red-icon"><i  class="delete-img"></i></A></td>
                        </tr>
                        <tr>
                            <td class="text-l"><span class="name">李菁菁</span></td>
                            <td>500元/千字</td>
                            <td class="text-center">2300字</td>
                            <td class="text-center">共<span class="money">12487</span>元</td>
                            <td class="operate"><A href="#" class="blue-icon"><i  class="edit-img"></i></A><A href="#"  class="red-icon"><i  class="delete-img"></i></A></td>
                        </tr>
                        <tr>
                            <td class="text-l">
                                <div class="select-wrap">
                                    <div class="select radius drop-down" drop-down>咩咩咩</i></div>
                                    <div class="select-con undis">
                                        <ul>
                                            <li><a href="javascript:;">咩</a></li>
                                            <li><a href="javascript:;">咩咩</a></li>
                                            <li><a href="javascript:;">咩咩咩</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                            <td>500元/千字</td>
                            <td class="text-center">2300字</td>
                            <td class="text-center">共<input type="text" class="in-money" value="500" />元</td>
                            <td class="operate"><A href="#" class="blue-icon"><i  class="finished-img"></i></A><A href="#"  class="red-icon"><i  class="close-img"></i></A></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="add-toicon">
                    <%--添加译员--%>
                    <a href="#"><i class="icon iconfont">&#xe633;</i><spring:message code="myOrder.add.translator"/></a>
                </div>
            </div>
            <div id="tran-tab2" style="display:none;">
                <div class="prompt-center-table">
                    <table class="table table-bg  table-height60">
                        <tbody>
                        <tr>
                            <td class="text-l"><span class="name">李菁菁</span></td>
                            <td>500元/千字</td>
                            <td class="text-center">2300字</td>
                            <td class="text-center">共<span class="money">12487</span>元</td>
                            <td class="operate"><A href="#" class="blue-icon"><i  class="edit-img"></i></A><A href="#"  class="red-icon"><i  class="delete-img"></i></A></td>
                        </tr>
                        <tr>
                            <td class="text-l"><span class="name">李菁菁</span></td>
                            <td>500元/千字</td>
                            <td class="text-center">2300字</td>
                            <td class="text-center">共<span class="money">12487</span>元</td>
                            <td class="operate"><A href="#" class="blue-icon"><i  class="edit-img"></i></A><A href="#"  class="red-icon"><i  class="delete-img"></i></A></td>
                        </tr>
                        <tr>
                            <td class="text-l">
                                <div class="select-wrap">
                                    <div class="select radius drop-down" drop-down>咩咩咩</i></div>
                                    <div class="select-con undis">
                                        <ul>
                                            <li><a href="javascript:;">咩</a></li>
                                            <li><a href="javascript:;">咩咩</a></li>
                                            <li><a href="javascript:;">咩咩咩</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                            <td>500元/千字</td>
                            <td class="text-center">2300字</td>
                            <td class="text-center">共<input type="text" class="in-money" value="500" />元</td>
                            <td class="operate"><A href="#" class="blue-icon"><i  class="finished-img"></i></A><A href="#"  class="red-icon"><i  class="close-img"></i></A></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="add-toicon">
                    <a href="#"><i class="icon iconfont">&#xe633;</i>添加译员</a>
                </div>
            </div>
            <div id="tran-tab3" style="display:none;">
                <div class="prompt-center-table">
                    <table class="table table-bg  table-height60">
                        <tbody>
                        <tr>
                            <td class="text-l"><span class="name">李菁菁</span></td>
                            <td>500元/千字</td>
                            <td class="text-center">2300字</td>
                            <td class="text-center">共<span class="money">12487</span>元</td>
                            <td class="operate"><A href="#" class="blue-icon"><i  class="edit-img"></i></A><A href="#"  class="red-icon"><i  class="delete-img"></i></A></td>
                        </tr>
                        <tr>
                            <td class="text-l"><span class="name">李菁菁</span></td>
                            <td>500元/千字</td>
                            <td class="text-center">2300字</td>
                            <td class="text-center">共<span class="money">12487</span>元</td>
                            <td class="operate"><A href="#" class="blue-icon"><i  class="edit-img"></i></A><A href="#"  class="red-icon"><i  class="delete-img"></i></A></td>
                        </tr>
                        <tr>
                            <td class="text-l">
                                <div class="select-wrap">
                                    <div class="select radius drop-down" drop-down>咩咩咩</i></div>
                                    <div class="select-con undis">
                                        <ul>
                                            <li><a href="javascript:;">咩</a></li>
                                            <li><a href="javascript:;">咩咩</a></li>
                                            <li><a href="javascript:;">咩咩咩</a></li>
                                        </ul>
                                    </div>
                                </div>
                            </td>
                            <td>500元/千字</td>
                            <td class="text-center">2300字</td>
                            <td class="text-center">共<input type="text" class="in-money" value="500" />元</td>
                            <td class="operate"><A href="#" class="blue-icon"><i  class="finished-img"></i></A><A href="#"  class="red-icon"><i  class="close-img"></i></A></td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <div class="add-toicon">
                    <a href="#"><i class="icon iconfont">&#xe633;</i>添加译员</a>
                </div>
            </div>
            <div class="prompt-samll-confirm prompt-mt">
                <ul>
                    <li class="eject-btn">
                        <input type="button" id="tran-determine" class="btn btn-green btn-120 radius20" value="确定">
                        <input type="button" id="tran-close" class="btn border-green btn-120 radius20" value="取消">
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <div class="mask" id="eject-mask"></div>
</div>
    </c:otherwise>
</c:choose>
<!--/弹出结束-->
<!--头部-->
<%@include file="/inc/transTopMenu.jsp" %>
<!--二级主体-->
<!--外侧背景-->
<div class="cloud-container">
    <!--内侧内容区域-->
    <div class="translate-cloud-wrapper">
        <!--左侧菜单-->
        <%@include file="/inc/transLeftmenu.jsp" %>

        <!--右侧内容-->
        <!--右侧大块-->
        <div class="right-wrapper">
            <input id="orderId" type="hidden" value="${orderDetails.orderId}">
            <div class="breadcrumb">
                <!-- 我的订单 -->
                <p><spring:message code="myOrder.myorders"/>></p>
                <!-- 订单号 -->
                <p><spring:message code="myOrder.Ordernumber"/>：${orderDetails.orderId}</p>
            </div>
            <c:if test="${orderDetails.state =='92'}">
                <!-- myOrder.OrderHrefunded -->
                <div class="step-big small-hi"><spring:message code="myOrder.OrderHrefunded"/></div>
            </c:if>
            <!--订单table-->
            <div class="confirmation-table mt-20">
                <div class="oder-table">
                    <ul>
                        <!-- 翻译内容 -->
                        <li><a href="javaScript:void(0);" class="current"  <c:if
                                test="${orderDetails.translateType == '2'}"> style="display: none;" </c:if> ><spring:message
                                code="myOrder.translatingContent"/></a></li>
                        <!-- 订单跟踪 -->
                        <li><a href="javaScript:void(0);" <c:if
                                test="${orderDetails.translateType == '2'}"> class="current" </c:if>><spring:message
                                code="myOrder.Ordertracking"/></a></li>
                    </ul>
                </div>
                <%--翻译内容--%>
                <div id="translate1">
                     <%--文本类型--%>
                    <c:if test="${orderDetails.translateType == '0'}">
                        <div class="confirmation-list">
                            <ul>
                                <!-- 原文  -->
                                <li class="title"><spring:message code="myOrder.Originaltext"/>:</li>
                                <!-- 更多 -->
                                <c:choose>
                                    <c:when test="${fn:length(orderDetails.prod.needTranslateInfo) <= 150}">
                                        <li class="word">${orderDetails.prod.needTranslateInfo}</li>
                                    </c:when>
                                    <c:otherwise>
                                        <li class="word">${fn:substring(orderDetails.prod.needTranslateInfo, 0, 150)}
                                            <span style="display: none;">${fn:substring(orderDetails.prod.needTranslateInfo, 150, fn:length(orderDetails.prod.needTranslateInfo))}</span>
                                            <A name="more" href="javaScript:void(0);">[<spring:message
                                                    code="myOrder.more"/>]</A></li>
                                    </c:otherwise>
                                </c:choose>
                            </ul>

                            <c:choose>
                                <%--有译文的情况--%>
                                <c:when test="${not empty orderDetails.prod.translateInfo}">
                                    <ul>
                                        <%--译文--%>
                                        <li class="title"><spring:message code="myOrder.Translatedtext"/>:
                                             <%--修改 --%>
                                            <c:if test="${orderDetails.state =='23' || orderDetails.state =='25' }">
                                                <input id="editText" class="btn border-blue-small btn-auto radius20"
                                                       type="button" value="<spring:message code="myOrder.modify"/>">
                                            </c:if>
                                        </li>
                                         <%--更多--%>
                                        <c:choose>
                                            <c:when test="${fn:length(orderDetails.prod.translateInfo) <=150}">
                                                <li class="word">${orderDetails.prod.translateInfo}</li>
                                            </c:when>
                                            <c:otherwise>
                                                <li class="word">${fn:substring(orderDetails.prod.translateInfo, 0, 150)}
                                                    <span style="display: none;">${fn:substring(orderDetails.prod.translateInfo, 150, fn:length(orderDetails.prod.translateInfo))}</span>
                                                    <A name="more" href="javaScript:void(0);">[<spring:message
                                                            code="myOrder.more"/>]</A></li>
                                            </c:otherwise>
                                        </c:choose>

                                        <li class="word" style="display: none"><textarea id="transTextArea"
                                                                                         class="int-text radius text-150">${orderDetails.prod.translateInfo}</textarea>
                                        </li>
                                    </ul>
                                    <ul style="display: none">
                                        <li class="right mr-5">
                                            <!-- 保存 -->
                                            <input id="textSave" name="textSave"
                                                   class="btn border-blue-small btn-auto radius20" type="button"
                                                   value="<spring:message code="myOrder.sava"/>">
                                        </li>
                                    </ul>
                                </c:when>
                                 <%--无译文的情况 --%>
                                <c:otherwise>
                                    <!-- 翻译中 修改中 -->
                                    <c:if test="${orderDetails.state =='23' || orderDetails.state =='25' }">
                                        <ul>
                                            <!-- 译文  -->
                                            <li class="title"><spring:message code="myOrder.Translatedtext"/>:</li>
                                            <li class="word"><textarea id="transTextArea"
                                                                       class="int-text radius text-150"></textarea></li>
                                        </ul>
                                        <ul>
                                            <li class="right mr-5">
                                                    <%--保存--%>
                                                <input id="textSave" name="textSave"
                                                       class="btn border-blue-small btn-auto radius20" type="button"
                                                       value="<spring:message code="myOrder.sava"/>">
                                            </li>
                                        </ul>
                                    </c:if>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </c:if>
                    <%--附件/文档类型--%>
                    <c:if test="${orderDetails.translateType == '1'}">
                        <div class="confirmation-list">
                            <!-- 原文 -->
                            <c:forEach items="${orderDetails.prodFiles}" var="prodFile" varStatus="status">
                                <ul>
                                    <!-- 原文-->
                                    <li class="title"><spring:message code="myOrder.Originaltext"/>:</li>
                                    <!-- 附件/文档不为空 -->
                                    <c:if test="${not empty prodFile.fileName}">
                                        <%--文件名--%>
                                        <li>${prodFile.fileName}</li>
                                        <li class="right mr-5">
                                                <%--下载--%>
                                            <input name="download" fileId="${prodFile.fileSaveId}"
                                                   fileName="${prodFile.fileName}" type="button"
                                                   class="btn border-blue-small btn-auto radius20"
                                                   value="<spring:message code="myOrder.downLoad"/>">
                                        </li>
                                    </c:if>
                                </ul>
                            </c:forEach>

                            <%--译文--%>
                            <c:forEach items="${orderDetails.prodFiles}" var="prodFile" varStatus="status">
                                <c:if test="${not empty prodFile.fileTranslateId}">
                                    <ul <c:if test="${status.first}">class="mt-30"</c:if> >
                                        <!-- 译文 文档-->
                                        <li class="title"><spring:message code="myOrder.Translatedtext"/>:</li>
                                        <!-- 文档类型翻译 文档list -->
                                        <li fileSize="${fileSizeMap.get(prodFile.fileTranslateId)}">${prodFile.fileTranslateName}</li>
                                        <li class="right mr-5">
                                            <%--下载--%>
                                            <input name="download" fileId="${prodFile.fileTranslateId}"
                                                   fileName="${prodFile.fileTranslateName}" type="button"
                                                   class="btn border-blue-small btn-auto radius20"
                                                   value="<spring:message code="myOrder.downLoad"/>">

                                            <!-- 翻译中 修改中 -->
                                            <c:if test="${orderDetails.state =='23' || orderDetails.state =='25' }">
                                                <!-- 删除 -->
                                                <input name="delFile" class="btn border-blue-small btn-auto radius20"
                                                       type="button" value="<spring:message code="myOrder.delete"/>">
                                            </c:if>
                                        </li>
                                    </ul>
                                </c:if>
                            </c:forEach>

                            <!-- 翻译中 修改中 -->
                            <c:if test="${orderDetails.state =='23' || orderDetails.state =='25' }">
                                <%--若译文附件/文档数量小于原文附件/文档数量，则允许上传--%>
                                <c:if test="${UUploadCount > 0}">
                                    <!-- 可以上传 -->
                                    <!-- 上传译文 -->
                                    <p>
                                    <div id="selectFile"><spring:message code="myOrder.Upload"/></div>
                                    <input id="orderId" name="orderId" type="hidden" value="${orderDetails.orderId}">
                                    </p>
                                    <%--<form  id="uploadForm" method="POST" enctype="multipart/form-data" action="${_base}/p/trans/order/upload">--%>
                                    <%--<p>--%>
                                    <%--<input class="btn border-blue-small btn-80 radius20" type="button" value="<spring:message code="myOrder.Upload"/>">--%>
                                    <%--<input id="upload" name="file" class="fany-file" type="file">--%>

                                    <%--<input name="orderId" type="hidden" value="${orderDetails.orderId}">--%>
                                    <%--</p>  --%>
                                    <%--</form>　   --%>
                                </c:if>

                            </c:if>
                        </div>
                    </c:if>

                </div>
                <!-- 订单轨迹 -->
                <div id="translate2"  <c:if test="${orderDetails.translateType != '2'}"> style="display: none;"</c:if> >
                    <div class="tracking-list">
                        <ul>
                            <c:forEach items="${orderDetails.orderStateChgs}" var="stateChg" varStatus="status">
                                <li  <c:if test="${status.last}"> class="conduct" </c:if>>
                                    <p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                                       value="${stateChg.stateChgTime}"/></p>

                                    <c:choose>
                                        <c:when test="<%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>">
                                            <p class="right">${stateChg.chgDesc}</p>
                                        </c:when>
                                        <c:otherwise><p class="right">${stateChg.chgDescEn}</p></c:otherwise>
                                    </c:choose>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <!--订单内容-->
            <div class="oder-detailed">
                <div class="right-list-title pb-10 pl-20">
                    <!-- 订单详细 -->
                    <p><spring:message code="myOrder.Orderdetails"/></p>
                </div>
                <div class="oder-information">
                    <!--第一列信息-->
                    <div class="info-list info-title">
                        <!-- 订单金额  -->
                        <span><spring:message code="myOrder.OrderAmount"/>：</span>
                        <ul>
                            <li>
                                <p>
                                    <c:set var="totalFee"><fmt:formatNumber
                                            value="${orderDetails.orderFee.totalFee/1000}" pattern="#,##0.00#"/></c:set>
                                    <c:if test="${orderDetails.orderFee.currencyUnit =='1'}"><spring:message
                                            code="myOrder.rmb" argumentSeparator="@" arguments="${totalFee}"/></c:if>
                                    <c:if test="${orderDetails.orderFee.currencyUnit =='2'}"><spring:message
                                            code="myOrder.dollar" argumentSeparator="@"
                                            arguments="${totalFee}"/></c:if></p>
                            </li>
                        </ul>
                        <!-- 非口译显示 -->
                        <c:if test="${orderDetails.translateType != '2'}">
                            <span><spring:message code="myOrder.Words"/>：</span>
                            <ul>
                                <li>
                                    <p><spring:message
                                            code="myOrder.WordWord" arguments="${orderDetails.prod.translateSum}"/></p>
                                </li>
                            </ul>
                            <!-- 预计交稿 -->
                            <span><spring:message code="myOrder.ExpectedSubmTime"/>：</span>
                            <ul>
                                <li>
                                    <p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                                       value="${orderDetails.stateChgTime}"/></p>
                                </li>
                            </ul>
                        </c:if>
                    </div>
                    <!-- 订单信息 -->
                    <div class="info-list">
                        <span><spring:message code="myOrder.Orderinformation"/></span>
                        <ul>
                            <li>
                                <!-- 订单号 -->
                                <p class="word"><spring:message code="myOrder.Ordernumber"/>：</p>
                                <p>${orderDetails.orderId}</p>
                            </li>
                            <li>
                                <!-- 翻译主题 -->
                                <p class="word"><spring:message code="myOrder.SubjectTrante"/>：</p>
                                <p>${orderDetails.translateName}</p>
                            </li>
                            <li>
                                <!-- 翻译语言 -->
                                <p class="word"><spring:message code="myOrder.Language"/>：</p>
                                <p>
                                    <c:forEach items="${orderDetails.prodExtends}" var="prodExtends">
                                        <c:choose>
                                            <c:when test="<%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>">${prodExtends.langungePairName}</c:when>
                                            <c:otherwise>${prodExtends.langungeNameEn}</c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </p>
                            </li>
                            <li>
                                <!-- 翻译级别 -->
                                <p class="word"><spring:message code="myOrder.Trantegrade"/>：</p>
                                <p>
                                    <!-- 依次是 标准级  专业级  出版级-->
                                    <c:forEach items="${orderDetails.prodLevels}" var="prodLevels">
                                        <c:if test="${prodLevels.translateLevel == '100210'}"><spring:message
                                                code="order.Standard"/></c:if>
                                        <c:if test="${prodLevels.translateLevel == '100220'}"><spring:message
                                                code="order.Professional"/></c:if>
                                        <c:if test="${prodLevels.translateLevel == '100230'}"><spring:message
                                                code="order.Publishing"/></c:if>

                                        <c:if test="${prodLevels.translateLevel == '100110'}"><spring:message
                                                code="order.interpretationType1"/></c:if>
                                        <c:if test="${prodLevels.translateLevel == '100120'}"><spring:message
                                                code="order.interpretationType2"/></c:if>
                                        <c:if test="${prodLevels.translateLevel == '100130'}"><spring:message
                                                code="order.interpretationType3"/></c:if>
                                    </c:forEach>
                                </p>
                            </li>

                            <c:if test="${orderDetails.translateType != '2'}">
                                <!-- 文本、文档 类订单信息 -->
                                <li>
                                    <!-- 用途 -->
                                    <p class="word"><spring:message code="myOrder.Purpose"/>：</p>
                                    <p>
                                        <c:choose>
                                            <c:when test="<%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>">${orderDetails.prod.useCn}</c:when>
                                            <c:otherwise>${orderDetails.prod.useEn}</c:otherwise>
                                        </c:choose>
                                    </p>
                                </li>
                                <li>
                                    <!-- 领域-->
                                    <p class="word"><spring:message code="myOrder.Field"/>：</p>
                                    <p>
                                        <c:choose>
                                            <c:when test="<%=Locale.SIMPLIFIED_CHINESE.equals(response.getLocale())%>">${orderDetails.prod.fieldCn}</c:when>
                                            <c:otherwise>${orderDetails.prod.fieldEn}</c:otherwise>
                                        </c:choose>
                                    </p>
                                </li>

                                <li>
                                    <!-- 创建时间-->
                                    <p class="word"><spring:message code="myOrder.Creationtime"/>:</p>
                                    <p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                                       value="${orderDetails.orderTime}"/></p>
                                </li>

                                <li>
                                    <!-- 其他  -->
                                    <p class="word"><spring:message code="myOrder.Others"/>：</p>
                                    <!-- 加急;需要排版 -->
                                    <p class="p-large"><c:if test="${orderDetails.prod.isUrgent == 'Y'}">
                                        <spring:message code="myOrder.Urgent"/>;
                                    </c:if>
                                        <c:if test="${orderDetails.prod.isUrgent == 'N'}">
                                            <spring:message code="myOrder.noUrgent"/>;
                                        </c:if>
                                        <c:if test="${orderDetails.prod.isSetType == 'Y'}">
                                            <spring:message code="myOrder.Layout"/>;
                                        </c:if>
                                        <c:if test="${orderDetails.prod.isSetType == 'N'}">
                                            <spring:message code="myOrder.noLayout"/>;
                                        </c:if>
                                        <c:if test="${not empty orderDetails.prod.typeDesc}">
                                            <spring:message code="order.formatConv"/>:${orderDetails.prod.typeDesc}
                                        </c:if>
                                        <c:if test="${empty orderDetails.prod.typeDesc}">
                                            <spring:message code="myOrder.noFormat"/>
                                        </c:if>
                                    </p>
                                </li>
                            </c:if>

                            <c:if test="${orderDetails.translateType == '2'}">
                                <!-- 口译类信息 -->
                                <li>
                                    <!-- 会议开始时间 -->
                                    <p class="word"><spring:message code="myOrder.meetStartTime"/>：</p>
                                    <p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                                       value="${orderDetails.prod.stateTime}"/></p>
                                </li>
                                <li>
                                    <!-- 会议结束时间-->
                                    <p class="word"><spring:message code="myOrder.meetEndTime"/>：</p>
                                    <p><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss"
                                                       value="${orderDetails.prod.endTime}"/></p>
                                </li>
                                <%--<li>--%>
                                <%--<!-- 创建时间-->--%>
                                <%--<p class="word"><spring:message code="myOrder.Creationtime"/>：</p>--%>
                                <%--<p> <fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${orderDetails.orderTime}"/> </p>--%>
                                <%--</li>--%>
                                <li>
                                    <!-- 译员数量 -->
                                    <p class="word"><spring:message code="myOrder.interpreterNum"/>：</p>
                                    <p>${orderDetails.prod.interperSum}</p>
                                </li>
                                <li>
                                    <!-- 会议地点 -->
                                    <p class="word"><spring:message code="myOrder.place"/>：</p>
                                    <p>${orderDetails.prod.meetingAddress}</p>
                                </li>
                                <li>
                                    <!-- 会场数量 -->
                                    <p class="word"><spring:message code="myOrder.venueNum"/>：</p>
                                    <p>${orderDetails.prod.meetingSum}</p>
                                </li>
                                <li>
                                    <!-- 译员性别 -->
                                    <p class="word"><spring:message code="myOrder.Gender"/>：</p>
                                    <p>
                                        <c:choose>
                                            <c:when test="${orderDetails.prod.interperGen == '0'}">
                                                <spring:message code="order.sex2"/>
                                            </c:when>
                                            <c:when test="${orderDetails.prod.interperGen == '1'}">
                                                <spring:message code="order.sex3"/>
                                            </c:when>
                                            <c:otherwise>
                                                <spring:message code="order.sex1"/>
                                            </c:otherwise>
                                        </c:choose>
                                    </p>
                                </li>
                            </c:if>

                            <li class="width-large">
                                <!-- 需求备注 -->
                                <p class="word"><spring:message code="myOrder.Demandnotes"/>：</p>
                                <p class="p-large">${orderDetails.remark}</p>
                            </li>
                        </ul>
                    </div>
                </div>
                <!--按钮-->
                <div class="recharge-btn order-btn">
                    <c:choose>
                        <%--待领取--%>
                        <c:when test="${orderDetails.state =='20'}">
                            <!-- 领取-->
                            <input id="received" name="received" type="button"
                                   class="btn btn-green btn-xxxlarge radius10"
                                   value="<spring:message code="myOrder.Claim"/>">
                        </c:when>
                        <%--已领取--%>
                        <c:when test="${orderDetails.state =='21'}">
                            <%--若不是口译订单，则显示翻译--%>
                            <c:if test="${orderDetails.translateType!='2'}">
                                <!-- 翻译-->
                                <input id="trans" name="trans" class="btn btn-green btn-xxxlarge radius10" type="button"
                                       value="<spring:message code="myOrder.btn.Translate"/>">
                            </c:if>
                            <%--若是管理员，则显示分配按钮--%>
                            <c:if test="${isLspAdmin == true}">
                                <%--分配--%>
                                <input id="recharge-popo" class="btn btn-yellow btn-xxxlarge radius10 ml-20"
                                       type="button" value="<spring:message code="myOrder.Assign"/>">
                            </c:if>
                        </c:when>
                        <%--已分配--%>
                        <c:when test="${orderDetails.state =='211'}">
                            <c:choose>
                                <%--若是管理员，则显示分配按钮--%>
                                <c:when test="${isLspAdmin == true}">
                                    <%--分配--%>
                                    <input id="recharge-popo" class="btn btn-yellow btn-xxxlarge radius10"
                                           type="button" value="<spring:message code="myOrder.Assign"/>">
                                </c:when>
                                <%--若不是管理员，则显示领取--%>
                                <c:otherwise>
                                    <%--领取--%>
                                    <input id="claim" class="btn btn-yellow btn-xxxlarge radius10"
                                           type="button" value="<spring:message code="myOrder.Claim"/>">
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <%--翻译中--%>
                        <c:when test="${orderDetails.state =='23'}">
                            <c:choose>
                                <%--若是管理员，且分配步骤大于0，且允许重新分配，则显示分配--%>
                                <c:when test="${isLspAdmin == true && fn:length(orderDetails.followInfoes)>0 && allowAssign == true}">
                                    <%--分配--%>
                                    <input id="recharge-popo" class="btn btn-yellow btn-xxxlarge radius10"
                                           type="button" value="<spring:message code="myOrder.Assign"/>">
                                </c:when>
                                 <%--文本 有译文 --%>
                                <c:when test="${not empty orderDetails.prod.translateInfo}">
                                    <!-- 提交 -->
                                    <input id="submit" name="submit" class="btn btn-green btn-xxxlarge radius10" type="button"
                                           value="<spring:message code="myOrder.btn.Submit"/>">
                                    <!-- <input id="check" name="check" class="btn btn-yellow btn-xxxlarge radius10 ml-20" type="button" value="审校">-->
                                </c:when>
                                <c:when test="${orderDetails.translateType == '1' && UUploadCount < fn:length(orderDetails.prodFiles)}">
                                    <!-- 提交 -->
                                    <input id="submit" name="submit" class="btn btn-green btn-xxxlarge radius10"
                                           type="button" value="<spring:message code="myOrder.btn.Submit"/>">
                                    <!--<input id="tran-popo" class="btn btn-yellow btn-xxxlarge radius10 ml-20" type="button" value="CAT翻译">-->
                                </c:when>
                            </c:choose>
                        </c:when>
                         <%--修改中 --%>
                        <c:when test="${orderDetails.state =='25'}">
                            <!-- 提交 -->
                            <input name="submit" class="btn btn-green btn-xxxlarge radius10" type="button"
                                   value="<spring:message code="myOrder.btn.Submit"/>">
                        </c:when>
                        <%--lsp待审核 且当前用户为管理员--%>
                        <c:when test="${orderDetails.state =='43' && isLspAdmin == true}">
                            <%--若是管理员，则显示审核按钮--%>
                            <input id="approvalBtn" class="btn btn-yellow btn-xxxlarge radius10"
                                   type="button" value="<spring:message code="myOrder.approval"/>">
                        </c:when>
                        <c:otherwise>
                            <!-- 翻译中无译文 待确认 已完成 已退款 -->
                        </c:otherwise>
                    </c:choose>
                </div>

                <c:if test="${orderDetails.state =='20' && not empty orderDetails.lspId }">
                    <!-- 已领取状态，并且是lsp 展示此信息 -->
                    <!-- （选择自己翻译或分配给团队译员翻译，选择后不可修改） -->
                    <div class="info-center"><spring:message code="myOrder.lsoChooseInfo"/></div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<%--底部--%>
<%@include file="/inc/userFoot.jsp" %>
</body>
<%@ include file="/inc/incJs.jsp" %>
<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>

<script type="text/javascript">
    var pager, orderPager;
    //lspId
    var lspId = "${lspId}";
    //lsp角色
    var lspRole = "${lspRole}";
    var orderId = "${orderDetails.orderId}";
    //订单类型
    var translateType = "${orderDetails.translateType}";
    //订单状态
    var orderState= "${orderDetails.state}";
    //当前步骤
    var followId = "${orderDetails.currentReceiveFollowId}";
    (function () {
        seajs.use(['app/jsp/transOrder/orderInfo', 'app/jsp/customerOrder/order'], function (orderInfoPage, orderPage) {
            pager = new orderInfoPage({element: document.body});
            orderPager = new orderPage({element: document.body});
            pager.render();
            orderPager.render();
        });

        //更多 显示全文
        $("a[name='more']").click(function () {
            if ($(this).siblings("span").css('display') === 'none') {
                $(this).siblings("span").show();
                $(this).html("<spring:message code="myOrder.less"/>");
            } else {
                $(this).siblings("span").hide();
                $(this).html("<spring:message code="myOrder.more"/>");
            }

        });

        //下载文件
        $("input[name='download']").click(function () {
            orderPager._downLoad($(this).attr('fileId'), $(this).attr('fileName'));
        });

        //删除
        $("input[name='delFile']").click(function () {
            pager._delFile($(this).parent().find("input[name='download']").attr('fileid'));
        });

        //提交
        $("input[name='submit']").click(function () {
            orderPager._orderSubmit($("#orderId").val());
        });
        //口译分配，编辑按钮
        $('#oralTrans').delegate('tr td a i.edit-img','click',function(){
            var transInfo = {};
            //获取输入内容，
            var tdObj = $(this).parent().parent().parent().children("td:not(.operate)");
            tdObj.each(function () {
                var inObj = $(this).children("span").eq(0);
                var name = inObj.attr("name");
                transInfo[name] = inObj.text();
            });
            transInfo["opType"]="edit";
            $(this).parent().parent().parent().html(pager._editInter(transInfo));
        });
        //口译分配，删除按钮
        $('#oralTrans').delegate('tr td a i.delete-img','click',function(){
            $(this).parent().parent().parent().remove();
        });
        //口译分配，保存按钮
        $('#oralTrans').delegate('tr td a i.finished-img','click',function(){
            var transInfo = {};
            //获取输入内容，
            var tdObj = $(this).parent().parent().parent().children(".text-l");
            tdObj.each(function () {
                var inObj = $(this).children("input").eq(0);
                var name = inObj.attr("name");
                transInfo[name] = inObj.val();
            });
            //判断名称是否为空，手机号是否为11位
            if(transInfo.name == null || transInfo.name == ""
                || transInfo.number == null || transInfo.number == ""){
                alert();
                return;
            }
            $(this).parent().parent().parent().html(pager._saveInter(transInfo));
        });
        //口译分配，取消按钮
        $('#oralTrans').delegate('tr td a i.close-img','click',function(){
            var opType = $(this).attr("op");
            //若是编辑取消，则需要返回原来内容
            if("edit" == opType){
                var transInfo = {};
                //获取输入内容，
                var tdObj = $(this).parent().parent().parent().children(".text-l");
                tdObj.each(function () {
                    var inObj = $(this).children("input").eq(0);
                    var name = inObj.attr("name");
                    transInfo[name] = inObj.attr("oldVal");
                });
                $(this).parent().parent().parent().html(pager._saveInter(transInfo));
            }//若是添加取消，则直接删除
            else {
                $(this).parent().parent().parent().remove();
            }
        });
    })();

</script>
</html>