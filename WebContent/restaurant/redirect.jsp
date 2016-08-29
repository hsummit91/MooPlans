<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
function callMenu(){
	document.getElementById("redirectForm").submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Calling Admin</title>
</head>
<body onload="callMenu()">
	<form id="redirectForm" action="../index.jsp" name="adminName"></form>
</body>
</html>