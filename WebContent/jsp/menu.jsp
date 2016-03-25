<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Dishes"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Orders Menu</title>
<link rel="stylesheet" type="text/css" href="./css/dataTables.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
</head>
<body onload="load()">
	<table id="example" class="display" cellspacing="0" width="80%">
		<thead>
			<tr>
				<th>Food Item</th>
				<th>Category</th>
				<th>Price</th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<th>Food Item</th>
				<th>Category</th>
				<th>Price</th>
			</tr>
		</tfoot>
		<tbody>

			<%
				ArrayList<Dishes> rest = (ArrayList<Dishes>) request.getAttribute("menuList");
					for (Dishes dishes : rest) {
			%>
			<tr>
				<td><%out.println(dishes.getDishName());%>
				</td>
				<td>
					<%
						out.println(dishes.getDishCategory());
					%>
				</td>
				<td>
					<%
						out.println(dishes.getDishPrice());
					%>
				</td>
			</tr>
			<%}%>
		</tbody>
	</table>
	<script src="./js/jquery.min.js"></script>
	<script src="./js/dataTables.js"></script>
	<script src="./js/app.js"></script>

</body>
</html>