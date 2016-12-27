<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>500</title>
	<%@ include file="/inc/inc.jsp" %>
</head>
<body class="four-bj">	
	<!--面包屑导航-->
	<%@ include file="/inc/topHead.jsp" %>
	<%--主导航--%>
	<%@ include file="/inc/topMenu.jsp" %>
		<!--主体-->
		<div class="placeorder-container">
		<div class="placeorder-wrapper">
			<div class="fourhundred">
				<div class="four-img"><img src="${uedroot}/images/500_01.png"></div>
				<div class="four-word"><spring:message code="sys.error.http.error"/></div>
				<div class="four-btn-img">
					<input type="button" class="btn border-blue btn-404 radius10"
						   value="<spring:message code="sys.error.goto.index"/>"  onclick="location.href='${_base}/'">
				</div>
					
				
		 	</div>
		</div>
		</div>
<script type="text/javascript" src="${uedroot}/scripts/modular/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="${uedroot}/scripts/modular/frame.js"></script>
</body>
</html>
