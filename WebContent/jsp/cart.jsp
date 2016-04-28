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
<script src="../js/socialSharing.js" type="text/javascript"></script>
<title>Cart</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/menutable.css">
</head>
<body>
<%
	//allow access only if session exists		
	User user = null;
	Cart shoppingCart = null; 
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("login.jsp");
	}else{
		user = (User) session.getAttribute("User");
		shoppingCart = (Cart) session.getAttribute("cart");
		
		if(shoppingCart == null){
			System.out.println("Cart servlet where cart is empty");
			shoppingCart = new Cart();
			session.setAttribute("cart", shoppingCart);
		}
	}
	
	String added = "false";
	try{
		added = request.getParameter("added");	
	}catch(Exception e){
		added = "false";
	}
	//out.println("============"+added);
	
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
              <li><a href="home.jsp">Home</a></li>
              <li><a href="orders.jsp">Place Order</a></li>
              <li><a href="pastOrders.jsp">Past Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
             <li><a href="cart.jsp?added=false"><i class="glyphicon glyphicon-shopping-cart"></i></a></li>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Hi <%=user.getUser_firstname()%>! <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="#"><%=user.getUser_points()%> Points</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Profile Settings</li>
                  <li><a href="../jsp/myProfile.jsp">View Profile</a></li>
                </ul>
              </li>
              <li><a href="#" id="logout">Logout</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
      
<div class='col-sm-11' style='margin-left: 5%'>
<%if(added.equals("true")){ %>
	<div class='alert alert-success'>Meal successfully added to cart </div>
<%} %>
<a href="orders.jsp" class='btn btn-primary' style='margin-left: 16px;'>Add Items</a>
<hr>
<h3>Cart</h3>

<%  HashMap<Integer, String> items = shoppingCart.getCartItems(); %>
		
<table class='table cartTable'>
<th>Food Item</th>
<th></th>
			
<% int count = 0;
for(Integer key: items.keySet()){
	count++;%>

	<form action='../CartServlet?button=delete' method='doGet'><input type='hidden' name='dishId' value='<%=key %>'>

<% 	if(count % 2 == 0){ %>
		<tr class='even'><td><%= items.get(key)%></td><td align='center'><input type='submit' class='btn btn-primary' value='delete'></td></tr></form>
<% 	}else{ %>
		<tr class='odd'><td><%= items.get(key)%></td><td align='center'><input type='submit' class='btn btn-primary' value='delete'></td></tr></form>	
<% 	}
				
}
if(items.size() == 0){ %>
	<tr><td colspan=2>No items in cart</td></tr>
<% } %>
</table>
<% 	if(!items.isEmpty()){ %>
		<a href="../jsp/checkout.jsp"><input type='submit' style='margin-left: 16px;' class='btn btn-primary' value='Proceed Checkout'></a>
<%} %>
</div>      
      
</div>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js" type="text/javascript"></script>
<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>
<script type="text/javascript">
$( "#logout" ).click(function() {
	  $( "#logoutForm" ).submit();
});
</script>
</body>
</html>