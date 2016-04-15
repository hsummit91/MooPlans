<%@page import="com.mooplans.model.Restaurant"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Restaurants</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
</head>
<body>
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
              <li class="active"><a href="#">Place Order</a></li>
              <li><a href="pastOrders.jsp">Past Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                            <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Hi Omkar <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="#">200 Points</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">profile Settings</li>
                  <li><a href="#">View Profile</a></li>
                </ul>
              </li>
              <li><a href="#">Logout</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
      
<%-- <form method="post" name="formName" action="./ActionServlet?action=menuPage">
	
			<%
				ArrayList<Restaurant> rest = (ArrayList<Restaurant>) request.getAttribute("restList");
					for (Restaurant rst : rest) {%>
				
				<div class="col-xs-6 col-md-3" style="height: 250px;width: 250px;margin: 0.5em">
					<button  name="restName" style="height: inherit;width: inherit;" value="<%=rst.getRestName()%>">
						<input type="image" name="restName" alt="<%=rst.getRestName()%>" value="<%=rst.getRestName()%>" style="height: 230px;width: 230px;" src='images/restLogos/<%=rst.getRestName()%>.jpg' />
					</button>
				</div>
		
			<%}%>
		
</form> --%>

</div>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js" type="text/javascript"></script>
</body>
</html>