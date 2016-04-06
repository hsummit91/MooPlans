<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Cart"%>
<%@ page import="com.mooplans.model.Order"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Order's Summary</title>
</head>
<body>
	<%
		String msg = (String) session.getAttribute("message");
		String total = (String) session.getAttribute("totalBill");
		Cart shoppingCart = (Cart) session.getAttribute("cart");
		HashMap<Integer, String> items = shoppingCart.getCartItems();
	%>
	<h4><%=msg%></h4>
	<table border='2px'>
		<thead>Food Item</thead>
		<%for (Integer key : items.keySet()) {%>
		<tr><td><%=items.get(key)%></td>
		</tr><%}%>
	</table>
	<table border='2px'>
	<thead>Total Points</thead>
	<tr><td><%=total%></td></tr>
	</table><%items.clear();%>
</body>
</html>