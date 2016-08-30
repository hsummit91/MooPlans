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
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
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
	%>


	<ul class="nav navbar-nav navbar-right">
		<li><a href="#" id="logout">Logout</a></li>
	</ul>


	<sql:setDataSource var="dbSource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443"
		user="moop2823825443" password="mooplans2016" />
	<sql:query dataSource="${dbSource}" var="dbResult">
         SELECT * FROM restaurant;
      </sql:query>

	<div align="center" class="bootstrap" style="margin-bottom: 20px;">
		<form action="insert.jsp" method="post">
			<h1>Welcome Admin</h1>
			<p class="mystyle">Add new Restaurant details</p>
			<input type="hidden" name="rest_id" /> 
			
			<div class="col-md-12"><label class="col-md-3">Name</label> <input type="text" name="rest_name" class="col-md-6" /></div> 
			<div class="col-md-12"><label class="col-md-3">10 digit Phone#</label> <input type="text" name="rest_phone" class="col-md-6" /></div>
			<div class="col-md-12"><label class="col-md-3">Status ON/OFF</label> <input type="text" name="rest_status" class="col-md-6" /></div> 
			<div class="col-md-12"><label class="col-md-3">Enter email address</label> <input type="text" name="rest_email" class="col-md-6" /></div> 
			<div class="col-md-12"><label class="col-md-3">Enter health</label> <input type="text" name="rest_health" class="col-md-6" /></div> 
			<div class="col-md-12"><label class="col-md-3">Meal type</label> <input type="text" name="rest_meal_type" class="col-md-6" /></div> 
			<div class="col-md-12"><label class="col-md-3">Delivery Fee (optional)</label> <input type="text" name="rest_meal_type" class="col-md-6" /></div> 

			<div class="col-md-12" style="margin-top: 10px;margin-bottom: 10px;"><input type="submit" value="Add New Restaurant"
				class="btn btn-primary btn-lg" /></div>
		</form>
	</div>

	<br />
	<font color="blue"> <c:if test="${not empty param.msg}">
			<c:out value="${param.msg}" />
		</c:if>
	</font>
	<br />
	<form>
		<table id="example" class="table table-striped table-bordered nowrap">
			<tr>
				<td>Name</td>
				<td>Phone #</td>
				<td>Status</td>
				<td>Email</td>
				<td>Health</td>
				<td>Meal Type</td>
				<td>Delivery Fee</td>
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
					<td><c:out value="${row.rest_delivery_fee}" /></td>
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
	</form>
	<br />
	<script src="../js/jquery.min.js" type="text/javascript"></script>
	<script src="../js/bootstrap.min.js" type="text/javascript"></script>
	<form action="${pageContext.request.contextPath}/Logout"
		id="logoutForm" method="post"></form>
	<script type="text/javascript">
		$("#logout").click(function() {
			$("#logoutForm").submit();
		});
	</script>
</body>
</html>