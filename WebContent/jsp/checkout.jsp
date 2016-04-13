<%@ page language="java" import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Cart"%>
<%@ page import="com.mooplans.model.Order"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Check out</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/loading.js"></script>

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
<div class="container">
	<div>
		<a class="btn btn-primary" href="orderRedirect.jsp" style="margin-left: 16px;">Add more items</a>
	</div>
	<br/>
	<%
		//allow access only if session exists
		
	User user = null;
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("login.jsp");
	}else user = (User) session.getAttribute("User");
%>
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
								<button onclick="waitingDialog.show('Brace Yourself.. Placing Order');" type="submit" id="submit" name="submit" class="btn btn-primary">Deliver to this address</button>
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
								<textarea class="form-control" id="address" name="address"></textarea>
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
</body>
