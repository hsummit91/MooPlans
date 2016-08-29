<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html;
         charset=UTF-8">
<title>Add new restaurant</title>
</head>
<body>
	<%
		//allow access only if session exists
	User user = null;
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("redirect.jsp");
	}else {
		user = (User) session.getAttribute("User");
	}
	
	String dish_category = (String) request.getAttribute("dish_category");
	String dish_allergen = (String) request.getAttribute("dish_allergen");
	String dish_health = (String) request.getAttribute("dish_health");
	String dish_choice = (String) request.getAttribute("dish_choice");
	String dish_points = (String) request.getAttribute("dish_points");
%>
	<sql:setDataSource var="dbSource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443"
		user="moop2823825443" password="mooplans2016" />


	<sql:update dataSource="${dbSource}" var="dbResult">
         INSERT INTO dishes(dish_name, dish_description, dish_category, dish_allergen, dish_health, dish_full_price, dish_command,
         dish_choice ,dish_rest_id, dish_price) VALUES (?,?,?,?,?,?,?,?,?,?);
         <sql:param value="${param.dish_name}" />
		<sql:param value="${param.dish_description}" />
		<sql:param value="<%=dish_category%>" />
		<sql:param value="<%=dish_allergen%>" />
		<sql:param value="<%=dish_health%>" />
		<sql:param value="${param.dish_full_price}" />
		<sql:param value="${param.dish_command}" />
		<sql:param value="<%=dish_choice%>" />
		<sql:param value="<%=user.getUser_id()%>" />
		<sql:param value="<%=dish_points%>" />
	</sql:update>
	<c:if test="${dbResult>=1}">
		<c:redirect url="restaurant/view.jsp">
			<c:param name="msg" value="1 record inserted" />
		</c:redirect>
	</c:if>
	<script src="../js/restaurant.js" type="text/javascript"></script>
</body>
</html>