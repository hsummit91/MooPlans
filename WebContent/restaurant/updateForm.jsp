<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html;
         charset=UTF-8">
<link href="style.css" rel="stylesheet" type="text/css" />
<title>Update Dishes</title>
</head>
<body>
	<sql:setDataSource var="dbSource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443"
		user="moop2823825443" password="mooplans2016" />

	<sql:query dataSource="${dbSource}" var="dbResult">
         SELECT * from dishes where dish_id=?;
         <sql:param value="${param.id}" />
	</sql:query>


	<div align="center">
		<form action="update.jsp" method="post">
			<h1>Update Dish Details</h1>
			<%--  <p class="mystyle">
               Update Address ID <c:out value="${param.id}"/>
            </p> --%>
			<c:forEach var="row" items="${dbResult.rows}">
				<input type="hidden" value="${row.dish_id}" name="id" />
				<label>Enter the name of the dish</label>
				<input type="text" value="${row.dish_name}" name="dish_name" />
				<br>
				<label>Enter Price</label>
				<input type="text" value="${row.dish_price}" name="dish_price" />
				<br>
				<label>Enter Category</label>
				<input type="text" value="${row.dish_category}" name="dish_category" />
				<br>
				<label>Enter Description</label>
				<input type="text" value="${row.dish_description}" name="dish_description" />
				<br>
				<label>Enter Choice</label>
				<input type="text" value="${row.dish_choice}" name="dish_choice" />
				<br>
				<label>Enter Sides</label>
				<input type="text" value="${row.dish_sides}" name="dish_sides" />
				<br>
				<label>Enter Health</label>
				<input type="text" value="${row.dish_health}" name="dish_health" />
				<br>
				<label>Full Price</label>
				<input type="text" value="${row.dish_full_price}" name="dish_full_price" />
				<br><br>
				<input type="submit" value="Update" />
			</c:forEach>
		</form>
	</div>
</body>
</html>