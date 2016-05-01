<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Cart"%>
<%@ page import="com.mooplans.model.Order"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script src="../js/socialSharing.js" type="text/javascript"></script>
<title>Check out</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap-timepicker.min.css">
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

	@media screen and (max-width: 640px){
    	.btn{
    		padding: 5px 10px !important;
    	}
	}
	
	@media screen and (max-width: 480px){
    	.btn{
    		padding: 4px 8px !important;
    		font-size: 12px !important;
    	}
	}
	    
    @media screen and (max-width: 390px){
    	.btn{
    		padding: 3px 6px !important;
    		font-size: 11px !important;
    	}
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
            	<img class="block" id="u3284_img" src="../images/logo%20high%20quality.jpg" alt="Moo Plans" style="margin-right: 1em;"/>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="home.jsp">Home</a></li>
              <li class="active"><a href="orders.jsp">Place Order</a></li>
              <li><a href="pastOrders.jsp">Past Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
             <li><a href="cart.jsp?added=false"><i class="glyphicon glyphicon-shopping-cart"></i></a></li>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Hi <%=user.getUser_firstname()%>! <span class="caret"></span></a>
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

	<div>
		<a class="btn btn-primary" href="orders.jsp" style="margin-left: 16px;">Add more items</a>
	</div>
	<br/>
	
	<div>
		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Current Address</h3>
				</div>
				<div class="panel-body">
					<form class="form-horizontal" action="../AddressServlet?action=currentAddress" method="post">
						<!-- Buyer address same as shipping address-->
						<div class="form-group">
							<label class="col-md-4 control-label" for="fullname">Current Address</label>
							<div class="col-md-8">
								<p class="form-control-static">
 									<%=user.getUser_firstname()%><br/>
									<%=user.getUser_address()%><br/>
									Phone: <%=user.getUser_phone()%>
								</p>
							</div>
						</div>

						<!-- If new shipping address -->
						<div class="form-group">
							<label class="col-md-4 control-label" for="submit"></label>
							<div class="col-md-4">
								<!-- <button onclick="waitingDialog.show('Brace Yourself.. Placing Order');" type="submit" id="submit" name="submit" class="btn btn-primary">Deliver to this address</button> -->
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>


		<div class="col-md-6">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						Add a new address<br /> <small>Be sure to click "Deliver to
							this address" when done.</small>
					</h3>
				</div>
				<div class="panel-body">
					<form class="form-horizontal" action="../AddressServlet?action=newAddress" method="post">

						<!-- Text input -->
					<div class="form-group">
						<label class="col-md-4 control-label" for="fullname">Name</label>
						<div class="col-md-8">
							<input id="fullname" name="fullname" type="text"
								placeholder="Name" class="form-control input-md">
						</div>
					</div>
					
						<!-- Address area -->
						<div class="form-group">
						<label class="col-md-4 control-label" for="address">Address</label>
						<div class="col-md-8">
						<select  class="form-control" id="address" name="address" >
								<option selected="selected" value="Campus Center">University at Albany: Campus Center</option>
								<option value="Dutch Quad">Dutch Quad</option>
								<option value="Colonial Quad">Colonial Quad</option>
								<option value="State Quad">State Quad</option>
								<option value="Indian Quad">Indian Quad</option>
								<option value="Freedom Apartments">Freedom Apartments</option>
								<option value="Liberty Terrace Apartments">Liberty Terrace Apartments</option>
								<option value="Empire Commons">Empire Commons</option>
								<option value="Alumni (Bus Stop)">Alumni (Bus Stop)</option>
						</select>
						</div>	
						</div>
						
						<div class="form-group">
						<label class="col-md-4 control-label" for="time">Deliver By</label>						
						 	<div class="col-md-8">
								<div class="input-group bootstrap-timepicker timepicker">
            						<input id="timepicker1" name="time" type="text" class="form-control input-small">
            						<span class="input-group-addon"><i class="glyphicon glyphicon-time"></i></span>
        						</div>
							</div>
						</div>

						<!-- Phone input -->
					<div class="form-group">
						<label class="col-md-4 control-label" for="phone">Phone
							Number</label>
						<div class="col-md-8">
							<input id="phone" name="phone" type="text"
								placeholder="Phone Number" class="form-control input-md">
						</div>
					</div>
					
						<!-- Button -->
						<div class="form-group">
							<label class="col-md-4 control-label" for="submit"></label>
							<div class="col-md-4">
								<button onclick="waitingDialog.show('Brace Yourself.. Placing Order');" type="submit" id="submit" name="submit"
									class="btn btn-primary">Deliver to this address</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/bootstrap-timepicker.min.js"></script>
<script src="../js/loading.js"></script>
<script type="text/javascript">
$( "#logout" ).click(function() {
	  $( "#logoutForm" ).submit();
});

   $('#timepicker1').timepicker();
</script>
</body>
