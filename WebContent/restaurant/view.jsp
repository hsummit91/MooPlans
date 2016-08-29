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
<link rel="stylesheet" type="text/css" href="../css/restaurant.css">
<title>Home Page</title>
</head>
<body>

	<ul class="nav navbar-nav navbar-right">
		<li><a href="#" id="logout">Logout</a></li>
	</ul>
	<ul class="nav navbar-nav navbar-right">
		<li><a href="index.jsp" id="idx">Add Dishes</a></li>
	</ul>
	<%
		//allow access only if session exists
	User user = null;
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("redirect.jsp");
	}else {
		user = (User) session.getAttribute("User");
	}
%>
	<sql:setDataSource var="dbSource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443"
		user="moop2823825443" password="mooplans2016" />
	<sql:query dataSource="${dbSource}" var="dbResult">
         SELECT * FROM dishes where dish_rest_id=<%=user.getUser_id()%>;
      </sql:query>
	<div align="center" class="bootstrap">
		<h3>Welcome Restaurant User</h3>
		<p class="mystyle">View all dishes</p>

	</div>
	<font color="blue"> <c:if test="${not empty param.msg}">
			<c:out value="${param.msg}" />
		</c:if>
	</font>
	<br />
	<form>
		<table id="example" class="table table-striped table-bordered nowrap">
			<tr>
				<td>Name</td>
				<td>Description</td>
				<td>Cuisine</td>
				<td>Allergens</td>
				<td>Health</td>
				<td>Full Price</td>
				<td>Command</td>
				<td>Choice</td>
				<td colspan="2"></td>
			</tr>
			<c:forEach var="row" items="${dbResult.rows}">
				<tr>
					<td><c:out value="${row.dish_name}" /></td>
					<td><c:out value="${row.dish_description}" /></td>
					<td><c:out value="${row.dish_category}" /></td>
					<td><c:out value="${row.dish_allergen}" /></td>
					<td><c:out value="${row.dish_health}" /></td>
					<td><c:out value="${row.dish_full_price}" /></td>
					<td><c:out value="${row.dish_command}" /></td>
					<td><c:out value="${row.dish_choice}" /></td>
					<td><a
						href="updateForm.jsp?id=<c:out
                           value="${row.dish_id}"/>">Update</a>
					</td>
					<td><a
						href="delete.jsp?id=<c:out
                        value="${row.dish_id}"/>">Delete</a></td>
				</tr>
			</c:forEach>
		</table>
	</form>
	<br />
	<script src="../js/jquery.min.js" type="text/javascript"></script>
	<script src="../js/bootstrap.min.js" type="text/javascript"></script>
	<script src="../js/restaurant.js" type="text/javascript"></script>
	<form action="${pageContext.request.contextPath}/Logout"
		id="logoutForm" method="post"></form>
	<script type="text/javascript">
	$(document).ready(function() {
	    $('#example').DataTable();
	} );
$( "#logout" ).click(function() {
	  $( "#logoutForm" ).submit();
});
</script>
</body>
</html>