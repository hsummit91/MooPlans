<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Image"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<script src="../js/socialSharing.js" type="text/javascript"></script>
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" type="text/css" href="../css/default.css" />
	<link rel="stylesheet" type="text/css" href="../css/component.css" />
	<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="../css/profile.css" />
	<%
		//allow access only if session exists
	User user = null;
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("login.jsp");
	}else {
		user = (User) session.getAttribute("User");
	}%>
	</head>
	<body onload="getUserDetails()">
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

	<div class="row login_box">
	    <div class="col-md-12 col-xs-12" align="center">
            <div class="line"><h3>My Profile</h3></div>
            <!-- <div class="outter"></div> -->
            <div class="profile-header-container">   
    		<div class="profile-header-img">
                <img class="img-circle" id="profileImg" src="" />
                <!-- badge -->
                <div class="rank-label-container">
                    <a href="#" data-toggle="modal" data-target="#myModal" ><span class="label label-default rank-label">Change Image</span></a>
                </div>
            </div>
        	</div>   
            <h1><div id="name"></div></h1>
            <!-- <span><div id="points"></div></span> -->
	    </div>
        <div class="col-md-6 col-xs-6 follow line" align="center">
            <h3>
                 <span><span id="points"></span> Points</span>
            </h3>
        </div>
        <div class="col-md-6 col-xs-6 follow line"   align="center">
        <a href="mealPlans.jsp">
            <h3 class="points">
                 <span>Add Points</span>
            </h3>
        </a>
        </div>
        
        <div class="col-xs-6 login_control">
                
                <div class="control">
                    <div class="label" id="email"></div>
                </div>
                
        </div>
        <div class="col-xs-6 login_control">
                
                <div class="control">
                     <div class="label" id="phone"></div>
                </div>
        </div>
		<div class="col-xs-6 login_control">
                
                <div class="control">
                     <div class="label">Current Address:</div>
                </div>
        </div>        
		<div class="col-xs-6 login_control">
                
                <div class="control">
                     <div class="label" id="address"></div>
                </div>
        </div>
     </div>
  </div>
 
<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
       <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Select your Avatar</h4>
      </div>
      <p>
      <div class="modal-body">
  			<%
			ArrayList<Image> img = (ArrayList<Image>) session.getAttribute("images");
			for (Image imageCodes : img) {
  			%>
  			<p>
			<div class="col-xs-6 col-md-3 foo" style="height: 150px;width: 150px;margin: 0.5em">
			<img alt="Profile Image" data-dismiss="modal" onclick="getPath(this)" id="<%=imageCodes.getImageId()%>" style="height: inherit;width: inherit;cursor: pointer;" src="<%=imageCodes.getImagePath()%>" />
		    </div></p> 
  			<%}%>	  
      </div>
      
       <div class="modal-footer">
      </div>
    </div>

  </div>
</div>
  
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>
	<script type="text/javascript">
	$( "#logout" ).click(function() {
		  $( "#logoutForm" ).submit();
	});
	
	function getUserDetails(){				
	    $.ajax({
			  method: "POST",
			  url: "../FetchData",
			  data: { action: "getUserDetails", userId: "<%=user.getUser_id()%>"  }
			}).done(function( msg ) {
				  sessionStorage.setItem("myProfilPoints", msg.points);
				  console.log(msg.firstName);
				  var lastName = "";
				  if(msg.lastName != undefined){
					  lastName = msg.lastName;
				  }
				  $("#name").html(msg.firstName + " " + lastName);
				  $("#points").html(msg.points);
				  $("#email").html(msg.email);
				  $("#phone").html(msg.phone);
				  $("#address").html(msg.address);
				  $("#university").html(msg.university);
				  $("#profileImg").attr("src",msg.image);
				  
				  window.parent.updatePoints();
			});    
	}
	
	function getPath(ele){
		var path = $(ele).attr("src");
		var imgId = $(ele).attr("id");
		$("#profileImg").attr("src",path);
		$("#imageSelector").hide();
		$(".container").show("slow");
		//console.log(imgId)
 	    $.ajax({
			  method: "POST",
			  url: "../ImageUpload",
			  data: { imageId : imgId }
			}).done(function( msg ) {
				  console.log(msg);
			});  
	}
	</script>
</body>
</html>