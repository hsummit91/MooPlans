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
<link href="style.css" rel="stylesheet" type="text/css" />
<title>Home Page</title>
</head>
<body>
	<%
		//allow access only if session exists
		User user = null;
		if (session.getAttribute("User") == null) {
			out.print("Session Invalidate");
			response.sendRedirect("redirect.jsp");
		} else {
			user = (User) session.getAttribute("User");
		}
		// Username Wesley is choosen for admin
		if (user.getUser_firstname() == "Wesley") {
	%>
	<sql:setDataSource var="dbSource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443"
		user="moop2823825443" password="mooplans2016" />
	<sql:query dataSource="${dbSource}" var="dbResult">
         SELECT * FROM restaurant;
      </sql:query>

	<div align="center">
		<form action="insert.jsp" method="post">
			<h1>New Restaurant</h1>
			<p class="mystyle">Add new Restaurant details</p>
			<input type="hidden" name="rest_id" /> <label>Name</label> <input
				type="text" name="rest_name" /> <br> <label>10 digit
				Phone#</label> <input type="text" name="rest_phone" /> <br> <label>Status
				ON/OFF</label> <input type="text" name="rest_status" /> <br> <label>Enter
				email address</label> <input type="text" name="rest_email" /> <br> <label>Enter
				health</label> <input type="text" name="rest_health" /> <br> <label>Meal
				type</label> <input type="text" name="rest_meal_type" /> <br> <br>
			<input type="submit" value="Add New" />
		</form>
	</div>

	<br />
	<font color="blue"> <c:if test="${not empty param.msg}">
			<c:out value="${param.msg}" />
		</c:if>
	</font>
	<br />
	<form>
		<div class="CSSTableGenerator">
			<table>
				<tr>
					<td>Name</td>
					<td>Phone #</td>
					<td>Status</td>
					<td>Email</td>
					<td>Health</td>
					<td>Meal Type</td>
					<td colspan="2"></td>
				</tr>
				<c:forEach var="row" items="${dbResult.rows}">
					<tr>
						<td><c:out value="${row.rest_name}" /></td>
						<td><c:out value="${row.rest_phone}" /></td>

						<c:if test="${row.rest_status eq true}">
							<td><c:out value="1" /></td>
						</c:if>
						<c:if test="${row.rest_status eq false}">
							<td><c:out value="0" /></td>
						</c:if>

						<td><c:out value="${row.rest_email}" /></td>
						<td><c:out value="${row.rest_health}" /></td>
						<td><c:out value="${row.rest_meal_type}" /></td>
						<td><a
							href="updateForm.jsp?id=<c:out
                           value="${row.rest_id}"/>">Update</a>
						</td>
						<td><a
							href="delete.jsp?id=<c:out
                        value="${row.rest_id}"/>">Delete</a></td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</form>
	<br />

	<%
		} else {
			response.sendRedirect("redirect.jsp");
		}
	%>

</body>
</html>