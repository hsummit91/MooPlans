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
		<thead><h4>Meals</h4>
			<tr>
				<th>Food Item</th>
				<th>Category</th>
				<th>Points</th>
			</tr>
		</thead>
		<tbody>

			<%
				ArrayList<Dishes> rest = (ArrayList<Dishes>) request.getAttribute("menuList");
				int index=0;
					for (Dishes dishes : rest) { 
			%>
			<tr>
			<form name="formName" method="post" action="./CartServlet">
				<% if(dishes.getDishCategory().equalsIgnoreCase("Appetizer")){ index++;%>
				<% if(index==1){%><table id="example" class="display" cellspacing="0" width="80%">
				<thead><h4><br>Appetizers</br></h4><%}%>		
				<td><input style="width: 200px;" type="text" readonly="readonly" name="dishName" value="<%=dishes.getDishName()%>" /></td>
				<td><input type="text" readonly="readonly"  name="dishCat" value="<%=dishes.getDishCategory()%>" /></td>
            	<td><input type="text" maxlength="5" readonly="readonly"  name="dishPoints" value="<%=dishes.getDishPrice()%>"/>
            	<input type="submit" value="Add to cart"></td>
            	<td><input type="hidden" name="dishId" value="<%=dishes.getDishId()%>"/></td>
            	<%}else{%>
            	
				<td><input style="width: 200px;" type="text" readonly="readonly" name="dishName" value="<%=dishes.getDishName()%>" /></td>
				<td><input type="text" readonly="readonly" name="dishCat" value="<%=dishes.getDishCategory()%>" /></td>
            	<td><input type="text" maxlength="5" readonly="readonly"  name="dishPoints" value="<%=dishes.getDishPrice()%>"/>
            	<input type="submit" value="Add to cart"></td>
            	<td><input type="hidden" name="dishId" value="<%=dishes.getDishId()%>"/></td>
            	</form>
			</tr>
<!--<td><input type="text" maxlength="2" style="width: 50px;" title="Enter 2 digit number" pattern="\d{1,2}" name="quantity" required/>-->            	
			<%}}%>
		</tbody>
	</table>

	<script src="./js/jquery.min.js"></script>
	<script src="./js/dataTables.js"></script>
	<script src="./js/app.js"></script>

</body>
</html>