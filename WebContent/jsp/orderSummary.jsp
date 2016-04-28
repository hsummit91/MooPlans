<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Cart"%>
<%@ page import="com.mooplans.model.Order"%>
<%@ page import="com.mooplans.model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script src="../js/socialSharing.js" type="text/javascript"></script>
<title>Order's Summary</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">

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
	//allow access only if session exists		
	User user = null;
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("login.jsp");
	}else user = (User) session.getAttribute("User");
%>
<div class="container">
	<!-- Static navbar -->
      <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            	<img class="block" id="u3284_img" src="images/logo%20high%20quality.jpg" alt="Moo Plans" style="margin-right: 1em;"/>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="jsp/home.jsp">Home</a></li>
              <li class="active"><a href="jsp/orders.jsp">Place Order</a></li>
              <li><a href="jsp/pastOrders.jsp">Past Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
             <li><a href="#"><i class="glyphicon glyphicon-shopping-cart"></i></a></li>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Hi <%=user.getUser_firstname()%>! <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="#"><%=user.getUser_points() %> Points</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Profile Settings</li>
                  <li><a href="#">View Profile</a></li>
                </ul>
              </li>
              <li><a href="#">Logout</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

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
		<a class="btn btn-primary" href="./jsp/home.jsp" style="margin-left: 16px;">Home</a>
	</div>
	<div class="col-sm-1">
		<a class="btn btn-primary" href="./jsp/orders.jsp" style="margin-left: 16px;">Order Again?</a>
	</div>
</div>
<% items.clear();
	session.setAttribute("message", "");
%>
</div>
<script src="./js/jquery.min.js"></script>
<script src="./js/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>
