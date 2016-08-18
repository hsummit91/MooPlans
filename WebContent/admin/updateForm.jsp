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
<title>Update restaurant</title>
</head>
<body>
	<sql:setDataSource var="dbSource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443"
		user="moop2823825443" password="mooplans2016" />

	<sql:query dataSource="${dbSource}" var="dbResult">
         SELECT * from restaurant where rest_id=?;
         <sql:param value="${param.id}" />
	</sql:query>


	<div align="center">
		<form action="update.jsp" method="post">
			<h1>Update Restaurant Details</h1>
			<%--  <p class="mystyle">
               Update Address ID <c:out value="${param.id}"/>
            </p> --%>
			<c:forEach var="row" items="${dbResult.rows}">
				<input type="hidden" value="${row.rest_id}" name="id" />
				<label>Enter the name of the restaurant</label>
				<input type="text" value="${row.rest_name}" name="rest_name" />
				<br>
				<label>Enter phone number</label>
				<input type="text" value="${row.rest_phone}" name="rest_phone" />
				<br>
				<label>1-Active or 0-Deactive</label>
				<c:if test="${row.rest_status eq true}">
					<input type="text" value="1" name="rest_status" />
				</c:if>
				<c:if test="${row.rest_status eq false}">
					<input type="text" value="0" name="rest_status" />
				</c:if>
				<br>
				<label>Enter email address</label>
				<input type="text" value="${row.rest_email}" name="rest_email" />
				<br>
				<label>Enter health type</label>
				<input type="text" value="${row.rest_health}" name="rest_health" />
				<br>
				<label>Enter meal type</label>
				<input type="text" value="${row.rest_meal_type}"
					name="rest_meal_type" />
				<br><br>
				<input type="submit" value="Update" />
			</c:forEach>
		</form>
	</div>
</body>
</html>