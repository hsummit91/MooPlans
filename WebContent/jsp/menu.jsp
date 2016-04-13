<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Dishes"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Orders Menu</title>
<script src="./js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="./css/dataTables.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./css/menutable.css">
</head>
<body>
	<!-- <form name="formName" method=post action="./CartServlet"> -->
 	<table id="example" class="display dataTable" cellspacing="0">
		<thead>
			<tr>
				<th>Food Item</th>
				<th>Category</th>
				<th>Points</th>
				<th></th>
			</tr>
		</thead>
		<tbody>

			<%
				ArrayList<Dishes> rest = (ArrayList<Dishes>) request.getAttribute("menuList");
					for (Dishes dishes : rest) { 
			%>
			<tr>	
				<td>
					<%=dishes.getDishName()%>
				</td>
				<td>
					<%=dishes.getDishCategory()%>
				</td>
            	<td>
            		<%=dishes.getDishPrice()%>
            	</td>
            	<td>
            	<%-- 	<input type="hidden" name="dishId" value="<%=dishes.getDishId()%> "/>
            		<input type="hidden" name="dishName" value="<%=dishes.getDishName()%>" />
            		<input type="hidden" name="dishPoints" value="<%=dishes.getDishPrice()%>"/> --%>
            		<a class="btn btn-primary" href="<%=request.getContextPath()%>/CartServlet?button=add&dishId=<%=dishes.getDishId()%>&dishName=<%=dishes.getDishName()%>">Add to Cart</a>
            	</td>
			</tr>          	
			<%}%>
		</tbody>
	</table>
<!-- 	</form> -->
</body>
 <script src="./js/jquery.dataTables.min.js"></script>
 <script type="text/javascript">
 	$(document).ready(function() {
 	    var table = $('#example').DataTable();
 	});
</script>
</html>