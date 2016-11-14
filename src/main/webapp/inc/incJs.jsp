<%--
  Created by IntelliJ IDEA.
  User: jackieliu
  Date: 16/11/4
  Time: ä¸å9:17
  éç¨jså¼å¥.
--%>
<%@page import="com.ai.opt.sso.client.filter.SSOClientUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="_base" value="${pageContext.request.contextPath}"/>
<c:set var="_slpres" value="${_base}/resources/local"/>
<c:set var="spmRes" value="${_base}/resources/spm_modules"/>
<c:set var="accountBalanceLink" value="${_base}/account/balance/index"/>
<c:set var="accountRechargeOneLink" value="${_base}/account/recharge/one"/>
<%
    String slp_uac_host=SSOClientUtil.getCasServerUrlPrefixRuntime(request);
    request.setAttribute("slp_uac_host", slp_uac_host);
    String ssoLoginUrl=SSOClientUtil.getCasServerLoginUrlRuntime(request);
    request.setAttribute("ssoLoginUrl", ssoLoginUrl);
%>
<script>
    var _base = "${_base}";
    var _spm_res = "${spmRes}";
    var slp_uac_host="${slp_uac_host}";
    var ssoLoginUrl="${ssoLoginUrl}";
    var uedroot="${uedroot}";
    var currentLan = "<%=response.getLocale()%>";
    
    Date.prototype.stdTimezoneOffset = function() {
        var jan = new Date(this.getFullYear(), 0, 1);
        var jul = new Date(this.getFullYear(), 6, 1);
        return Math.max(jan.getTimezoneOffset(), jul.getTimezoneOffset());
        }

    //获取时区
    Date.prototype.dst = function() {
        return this.getTimezoneOffset() < this.stdTimezoneOffset();
    }
    
    //日期格式化
    Date.prototype.format = function(format) {
        var date = {
               "M+": this.getMonth() + 1,
               "d+": this.getDate(),
               "h+": this.getHours(),
               "m+": this.getMinutes(),
               "s+": this.getSeconds(),
               "q+": Math.floor((this.getMonth() + 3) / 3),
               "S+": this.getMilliseconds()
        };
        if (/(y+)/i.test(format)) {
               format = format.replace(RegExp.$1, (this.getFullYear() + '').substr(4 - RegExp.$1.length));
        }
        for (var k in date) {
               if (new RegExp("(" + k + ")").test(format)) {
                      format = format.replace(RegExp.$1, RegExp.$1.length == 1
                             ? date[k] : ("00" + date[k]).substr(("" + date[k]).length));
               }
        }
        return format;
  }
</script>
<script src="${_base}/resources/spm_modules/jquery/1.9.1/jquery.min.js"></script>
<script src="${_base}/resources/spm_modules/seajs/2.3.0/dist/sea.js"></script>
<script src="${_base}/resources/spm_modules/seajs/seajs-css.js"></script>
<script src="${_base}/resources/spm_modules/app/core/config.js"></script>
