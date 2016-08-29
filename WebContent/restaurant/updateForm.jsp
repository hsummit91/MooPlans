<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html;
         charset=UTF-8">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<title>Update Dishes</title>
</head>
<body>

<ul class="nav navbar-nav navbar-right">
		<li><a href="#" id="logout">Logout</a></li>
	</ul>
	
	<sql:setDataSource var="dbSource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443"
		user="moop2823825443" password="mooplans2016" />

	<sql:query dataSource="${dbSource}" var="dbResult">
         SELECT * from dishes where dish_id=?;
         <sql:param value="${param.id}" />
	</sql:query>


	<div align="center" class="bootstrap">
		<form action="update.jsp" method="post">
			<h1>Update Dish Details</h1>
			<c:forEach var="row" items="${dbResult.rows}">
				<input type="hidden" value="${row.dish_id}" name="id" />
				<label>Enter dish name</label>
				<input type="text" value="${row.dish_name}" name="dish_name" style="width:50%"/>
				<br>
				<label>Enter Description</label>
				<input type="text" value="${row.dish_description}" name="dish_description" style="width:50%"/>
				<br>
				<label>Enter Cuisine</label>
				<input type="text" value="${row.dish_category}" name="dish_category" style="width:50%"/>
				<br>
				<label>Enter Allergen</label>
				<input type="text" value="${row.dish_health}" name="dish_allergen" style="width:50%"/>
				<br>
				<label>Enter Health</label>
				<input type="text" value="${row.dish_health}" name="dish_health" style="width:50%"/>
				<br>
				<label>Full Price</label>
				<input type="text" value="${row.dish_full_price}"name="dish_full_price" style="width:50%" />
				<br>
				<label>Enter Choice</label>
				<input type="text" value="${row.dish_choice}" name="dish_choice" style="width:50%"/>
				<br>
				<br>
				<input type="submit" value="Update" class="btn btn-primary btn-lg"/>
			</c:forEach>
		</form>
	</div>
			<script src="../js/jquery.min.js" type="text/javascript"></script>
	<script src="../js/bootstrap.min.js" type="text/javascript"></script>
	<form action="${pageContext.request.contextPath}/Logout"
		id="logoutForm" method="post"></form>
	<script type="text/javascript">
$( "#logout" ).click(function() {
	  $( "#logoutForm" ).submit();
});
</script>
</body>
</html>