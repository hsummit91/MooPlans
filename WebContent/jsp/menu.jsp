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
</head>
<body onload="load()">
<form method="post" name="formName" action="./ActionServlet?action=menuPage">
	
			<%
				ArrayList<Restaurant> rest = (ArrayList<Restaurant>) request.getAttribute("restList");
					for (Restaurant rst : rest) {%>
		
			<div><input type="submit" class="btn btn-primary btn-lg col-xs-6 col-md-3" name="restName" value="<%=rst.getRestName()%>" /></div>
		
			<%}%>
		
</form>
</body>
</html>