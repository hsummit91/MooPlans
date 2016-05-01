<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="com.mooplans.model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script src="../js/socialSharing.js" type="text/javascript"></script>
<title>Past Orders</title>
<link rel="stylesheet" type="text/css" href="../css/dataTables.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/menutable.css">
</head>
<body onload="getPastOrders()">
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
              <li><a href="orders.jsp">Place Order</a></li>
              <li class="active"><a href="#">Past Orders</a></li>
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
                  <li><a href="../jsp/myProfile.jsp">View Profile</a></li>
                </ul>
              </li>
              <li><a href="#" id="logout">Logout</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
      
<div id="history"></div>
</div>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js" type="text/javascript"></script>
 <script src="../js/jquery.dataTables.min.js"></script>
 <form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>
 <script type="text/javascript">
 $( "#logout" ).click(function() {
	  $( "#logoutForm" ).submit();
});
 
function getPastOrders(){				
    $.ajax({
		  method: "POST",
		  url: "../FetchData",
		  data: { action: "getPastOrders", userId: <%=user.getUser_id()%>  }
		}).done(function( msg ) {
			  console.log(msg.length);
			  
			    var text = "";
			    
		    	text += '<table id="example" class="display dataTable" width="100%" cellspacing="0">';
		    	text += '<thead><tr>';
		    	text += '<th>Order ID</th>';
		    	text += '<th>Date</th>';
		    	text += '<th>Delivered at</th>';
		    	text += '<th>Dishes</th>';
		    	text += '<th>Total</th>';
		    	text += '</tr></thead><tbody>';
		    	
			    if(msg == "" || msg == null || msg.length == 0){
			    	
			    }else{
			    	
			    	for(i=0;i<msg.length;i++){
			    		
			    		var orders = "";
			    		
			    		for(j=0;j<msg[i].orderItems.length;j++){
			    			orders += "<li>" + msg[i].orderItems[j] + "</li>";
			    		}
			    		
			    		text += '<tr  id="'+msg[i].orderId+'" >';
			    		text += '<td>'+msg[i].orderId+'</td>';
			    		text += '<td>'+msg[i].orderDate+'</td>';
			    		text += '<td>'+msg[i].deliver+'</td>';
			    		text += '<td>'+orders+'</td>';
			    		text += '<td>'+msg[i].orderTotal+'</td>';
			    		text += '</tr>';
			    	}
			    		    	
			    }
			    text += '</tbody></table>';
			     
			     $("#history").html(text);
			     $('#example').DataTable();
		});    
}
</script>
</body>
</html>