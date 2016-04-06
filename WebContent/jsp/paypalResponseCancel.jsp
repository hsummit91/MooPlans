<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script src="../js/jquery.min.js"></script>
<script>
function callMenu(){
	var pts = localStorage.getItem("points");
	document.getElementById("result").innerHTML = pts;
	$("#redirectForm").attr("action",'../ActionServlet?action='+pts);
	document.getElementById("redirectForm").submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Cancelled Transaction</title>
</head>
<body onload="callMenu()">
<div id="result"></div>
	 <form id="redirectForm" action="" name="formName" method="post"></form>
</body>
</html>