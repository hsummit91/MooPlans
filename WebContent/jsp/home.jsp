<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="com.mooplans.model.User" %>
<%@ page import="com.mooplans.model.Cart" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
<script src="../js/socialSharing.js" type="text/javascript"></script>
<title>Home</title>
<style type="text/css">
.btn-primary{
	background-color: #FF847C !important;
	border-color: #FF847C !important;
}
</style>
</head>
<body>
<%
		//allow access only if session exists
	User user = null;
	Cart shoppingCart = null;
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("login.jsp");
	}else {
		user = (User) session.getAttribute("User");
		shoppingCart = (Cart) session.getAttribute("cart");
		
		if(shoppingCart == null){
			System.out.println("Cart servlet where cart is empty");
			shoppingCart = new Cart();
			session.setAttribute("cart", shoppingCart);
		}
	}
	String userName = null;
	String sessionID = null;
	Cookie[] cookies = request.getCookies();
	if(cookies !=null){
	for(Cookie cookie : cookies){
	    if(cookie.getName().equals("user")) userName = cookie.getValue();
	    if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
		}
	}
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
            	<img class="block" id="u3284_img" src="../images/logo%20high%20quality.jpg" alt="Moo Plans" style="margin-right: 1em;"/>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li class="active"><a href="#">Home</a></li>
              <li><a href="orders.jsp">Place Order</a></li>
              <li><a href="pastOrders.jsp">Past Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
             <li><a href="cart.jsp?added=false"><i class="glyphicon glyphicon-shopping-cart"></i><span class="badge"><%=shoppingCart.numberOfItems() %></span></a></li>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Hi <%=user.getUser_firstname() %>! <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="mealPlans.jsp"><%=user.getUser_points()%> Points</a></li>
                  <li><a href="mealPlans.jsp">Purchase a Meal Plan</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Profile Settings</li>
                  <li><a href="myProfile.jsp">View Profile</a></li>
                </ul>
              </li>
              <li><a href="#" id="logout">Logout</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

      <!-- Main component for a primary marketing message or call to action -->
      <div class="jumbotron">
        <h1>Welcome Back! <%=user.getUser_firstname()%></h1>
        <p>You have <strong><%=user.getUser_points()%></strong> MooPoints. What would you like to order today?</p>
      </div>
      
<!-- <div class="row">
  <div class="col-xs-6 col-md-3">
    <a href="#" class="thumbnail">
      <img src="../images/banner%20sections%201.jpg" alt="Add Points">
    </a>
  </div>
  <div class="col-xs-6 col-md-3">
    <a href="#" class="thumbnail">
      <img src="../images/banner%20sections%201.jpg" alt="Add Points">
    </a>
  </div>
</div> -->

<div class="row">
  <div class="col-sm-6 col-md-4">
    <div class="thumbnail">
      <img id="mealPlan" src="../images/banner%20sections%201.jpg" alt="Purchase a Meal Plan">
      <div class="caption">
        <h3>Purchase a Meal Plan</h3>
        <p>We have Meal Plans starting from just $35</p>
        <p><a href="mealPlans.jsp" class="btn btn-primary" role="button">See All Plans</a></p>
      </div>
    </div>
  </div>
    <div class="col-sm-6 col-md-4">
    <div class="thumbnail">
      <img id="restaurants" style="height: 250px;width: 250px;" src="../images/restLogos/DCs PIZZA.jpg" alt="Featured Restaurants">
      <div class="caption">
        <h3>Featured Restaurants</h3>
        <p>We have some great local restaurants to order from!</p>
        <p><a href="orders.jsp" class="btn btn-primary" role="button">See All Restaurants</a></p>
      </div>
    </div>
  </div>  <div class="col-sm-6 col-md-4">
    <div class="thumbnail">
      <img id="dishes" src="../images/o-crop-u4520.jpg" alt="Featured Dishes">
      <div class="caption">
        <h3>Featured Dishes</h3>
        <p>Some awesome dishes you can't resist!</p>
        <p><a href="orders.jsp" class="btn btn-primary" role="button">Place an order</a></p>
      </div>
    </div>
  </div>
</div>

    </div>
<script src="../js/jquery.min.js" type="text/javascript"></script>
<script src="../js/bootstrap.min.js" type="text/javascript"></script>
<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>
<script type="text/javascript">
$( "#logout" ).click(function() {
	  $( "#logoutForm" ).submit();
});
</script>
</body>
</html>