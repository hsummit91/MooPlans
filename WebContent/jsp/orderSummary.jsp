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
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
<style type="text/css">
.panel-default > .panel-heading {
    background-color: #2a363b;
    border-color: #e84a5f;
    color: #ff847c;
}
h3 small {
    color: #ff847c;
}
.panel-body {
    background-color: #fecea8;
}
h3{
	font-weight: bolder;
}
.panel-title {
    font-size: 18px;
    padding: 4px;
}
.btn-primary {
    background-color: #ff847c;
    border-color: #e84a5f;
    color: #fff;
}
.btn-primary:hover {
   	background-color: #e84a5f;
   	border-color: #e84a5f;
}
</style>
</head>
<body>
	<%
		String msg = (String) session.getAttribute("message");
		String total = (String) session.getAttribute("totalBill");
		Cart shoppingCart = (Cart) session.getAttribute("cart");
		HashMap<Integer, String> items = shoppingCart.getCartItems();
	%>
<div class="col-sm-11" style="margin-left: 5%">
	
	<div class="alert alert-success"><%=msg%> Your Order is on it's way!</div>
		
	<div class="col-sm-6">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">Your Order Summary</h3>
		</div>
		<div class="panel-body">		
			<%for (Integer key : items.keySet()) {%>
					<div><%=items.get(key)%></div>
			<%}%>
		</div>
	</div>
	</div>
	
	<div class="col-sm-6">
	<div class="panel panel-default">
		<div class="panel-heading">
			<h3 class="panel-title">Total Points</h3>
		</div>
		<div class="panel-body"><%=total%></div>
	</div>
	</div>
	<div class="col-sm-1">
		<a class="btn btn-primary" href="./jsp/myProfile.jsp" style="margin-left: 16px;">Home</a>
	</div>
	<div class="col-sm-1">
		<a class="btn btn-primary" href="./jsp/orderRedirect.jsp" style="margin-left: 16px;">Order Again?</a>
	</div>
</div>
<% items.clear();
	session.setAttribute("message", "");
%>
</body>
</html>
