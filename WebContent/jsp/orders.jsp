<%@page import="com.mooplans.model.Restaurant"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Restaurants</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<script type="text/javascript">
<script type="text/javascript">
function getTaskId(){
    var id = document.getElementById('getTaskId').value;
    alert(id);
}
</script>
</head>
<body onload="load()">
<form method="post" name="restName" action="./MenuServlet">
	<table>
		<tbody>
			<%
				ArrayList<Restaurant> rest = (ArrayList<Restaurant>) request.getAttribute("restList");
					for (Restaurant rst : rest) {%>
			<tr>
			<td><input type="submit" class="btn btn-primary btn-lg" name="restName" value="<%=rst.getRestName()%>" /></td>
			<tr>
			<%}%>
		</tbody>
	</table>
</form>
</body>
</html>