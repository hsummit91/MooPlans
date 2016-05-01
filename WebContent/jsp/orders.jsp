<%@page import="com.mooplans.model.Restaurant"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script src="../js/socialSharing.js" type="text/javascript"></script>
<title>Restaurants</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<style type="text/css">
.restImages{
	height: 220px;
	width: 220px;
	margin: 0.5em;
}
.restButtons{
	margin-bottom: 1em; 
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
              <li class="active"><a href="#">Place Order</a></li>
              <li><a href="pastOrders.jsp">Past Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            <li><a href="cart.jsp?added=false"><i class="glyphicon glyphicon-shopping-cart"></i></a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Hi <%=user.getUser_firstname() %>! <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="mealPlans.jsp"><%=user.getUser_points()%> Points</a></li>
                  <li><a href="mealPlans.jsp">Purchase a Meal Plan</a></li>
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
	  <div id="restaurants"></div>
</div>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js" type="text/javascript"></script>
<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>
<script type="text/javascript">
$( "#logout" ).click(function() {
	  $( "#logoutForm" ).submit();
});

$( document ).ready(function() {			
    $.ajax({
		  	method: "POST",
		  	url: "../ActionServlet",
		  	data: { action: "restPage" }
		}).done(function( msg ) {
			//console.log(msg); 
			var text = "";
			text += '<form method="post" name="formName" action="../ActionServlet?action=menuPage">';
			for(i=0;i<msg.length;i++){
				
				text += '<div class="col-xs-12 col-sm-6 col-md-3">';
				text += '<button class="restButtons" name="restName" value="'+msg[i].restName+'">';
				text += '<input type="image" class="restImages" name="restName" alt="'+msg[i].restName+'" value="'+msg[i].restName+'" src="../images/restLogos/'+msg[i].restName+'.jpg" />';
				text += '</button>';
				text += '</div>';
				
				/* text += '<div class="col-xs-12 col-sm-6 col-md-3">';
				text += '<img class="restImages" src="../images/restLogos/'+msg[i].restName+'.jpg" id="'+msg[i].restId+'" style="height: 230px;width: 230px;" />';
				text += '</div>'; */
			}
			text += '</form>';
			$("#restaurants").html(text);
			
			 $(".restImages").click(function(){
					var rest = $(this).attr("id");
					console.log("-->ID-->"+rest)
					//window.location.href = "menu.jsp?cust="+cust;
			});
		});
       
});
</script>
</body>
</html>