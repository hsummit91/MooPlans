<%@ page language="java" import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<div class="container">
		<h5><a href="orderRedirect.jsp">Add more items</a></h5>
	<%
		//allow access only if session exists
	User user = null;
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("login.jsp");
	}else user = (User) session.getAttribute("User");
%>

	<div class="container">
		<div class="col-md-4" style="float: left; width: 40%;">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">Current Address</h3>
				</div>
				<div class="panel-body">

					<form class="form-horizontal" action="../AddressServlet?action=currentAddress" method="post">
						<!-- Buyer address same as shipping address-->
						<div class="form-group">
							<label class="col-md-4 control-label" for="fullname">Current Address</label>
							<div class="col-md-4">
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
								<button type="submit" id="submit" name="submit" class="btn btn-default">Ship to this address</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>


		<div class="col-md-4" style="float: right; width: 50%;">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">
						Add a new address<br /> <small>Be sure to click "Ship to
							this address" when done.</small>
					</h3>
				</div>
				<div class="panel-body">
					<form class="form-horizontal" action="../AddressServlet?action=newAddress" method="post">

						<!-- Text input -->
					<div class="form-group">
						<label class="col-md-4 control-label" for="fullname">Name</label>
						<div class="col-md-4">
							<input id="fullname" name="fullname" type="text"
								placeholder="Name" class="form-control input-md">
						</div>
					</div>
					
						<!-- Address area -->
						<div class="form-group">
							<label class="col-md-4 control-label" for="address">Address</label>
							<div class="col-md-4">
								<textarea class="form-control" id="address" name="address"></textarea>
							</div>
						</div>

						<!-- Phone input -->
					<div class="form-group">
						<label class="col-md-4 control-label" for="phone">Phone
							Number</label>
						<div class="col-md-4">
							<input id="phone" name="phone" type="text"
								placeholder="Phone Number" class="form-control input-md">
						</div>
					</div>
					
						<!-- Button -->
						<div class="form-group">
							<label class="col-md-4 control-label" for="submit"></label>
							<div class="col-md-4">
								<button type="submit" id="submit" name="submit"
									class="btn btn-default">Ship to this address</button>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
