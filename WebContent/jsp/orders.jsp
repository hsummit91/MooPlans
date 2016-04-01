<%@page import="com.mooplans.model.Restaurant"%>
<%@ page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Restaurants</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
</head>
<body>
<form method="post" name="formName" action="./ActionServlet?action=menuPage">
	
			<%
				ArrayList<Restaurant> rest = (ArrayList<Restaurant>) request.getAttribute("restList");
					for (Restaurant rst : rest) {%>
		
			
				<%-- <input type="submit" class="btn btn-primary btn-lg col-xs-6 col-md-3" name="restName" value="<%=rst.getRestName()%>" /> --%>
				
<%-- 				<div class="col-xs-6 col-md-3 foo" style="height: 250px;width: 250px;margin: 0.5em">
					<input type="image" alt="test" style="height: inherit;width: inherit;" name="restName" value="<%=rst.getRestName()%>" src="images/restLogos/DCs.jpg" />
				</div> --%>
				
				<div class="col-xs-6 col-md-3 foo" style="height: 250px;width: 250px;margin: 0.5em">
					<button  name="restName" style="height: inherit;width: inherit;" value="<%=rst.getRestName()%>">
						<input type="image" alt="<%=rst.getRestName()%>" style="height: 230px;width: 230px;" src='images/restLogos/<%=rst.getRestName()%>.jpg' />
					</button>
				</div>
				
				
<!-- 				<div class="col-xs-6 col-md-3 foo" style="height: 250px;width: 250px;margin: 0.5em">
					<img alt="test" style="height: inherit;width: inherit;" src="images/restLogos/DCs.jpg" />
				</div> -->
		
			<%}%>
		
</form>
</body>
</html>