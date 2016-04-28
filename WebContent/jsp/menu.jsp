<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Dishes"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script src="../js/socialSharing.js" type="text/javascript"></script>
<title>Orders Menu</title>
<link rel="stylesheet" type="text/css" href="./css/dataTables.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./css/menutable.css">
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
            		<a class="btn btn-primary" href="<%=request.getContextPath()%>/CartServlet?button=add&dishId=<%=dishes.getDishId()%>&dishName=<%=dishes.getDishName()%>">Add to Cart</a>
            	</td>
			</tr>          	
			<%}%>
		</tbody>
	</table>
</div>
<script src="./js/jquery.min.js"></script>
<script src="./js/bootstrap.min.js" type="text/javascript"></script>
<script src="./js/jquery.dataTables.min.js"></script>
<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>
<script type="text/javascript">
	$( "#logout" ).click(function() {
	  	$( "#logoutForm" ).submit();
	});
	
 	$(document).ready(function() {
 	    var table = $('#example').DataTable();
 	});
</script>
</body>
</html>