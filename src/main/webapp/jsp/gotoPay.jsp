<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
    <title>GoToPay</title>
</head>
<body onload="sub();">
	<form id="pay_form" name="pay_form" action="${actionUrl}" METHOD="post">
		<c:forEach var="par" items="${paramsMap}">
			<input type="hidden" name="${par.key}" value="${par.value}">
		</c:forEach>
		<%--<input type="submit" value="submit">--%>
	</form>
</body>
<script language="javascript">
	function sub(){document.pay_form.submit();}
</script>
</html>
