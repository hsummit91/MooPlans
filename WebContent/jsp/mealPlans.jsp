<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<title>Select a Meal Plan</title>
  <link rel="stylesheet" type="text/css" href="../css/site_global.css?131700929"/>
  <link rel="stylesheet" type="text/css" href="../css/master_a-master.css?367422582"/>
  <link rel="stylesheet" type="text/css" href="../css/index.css?4060679516" id="pagesheet"/>
  <link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
  <style type="text/css">
  a:link {
    text-decoration: none !important;
  }
  #pu3284, #pu669-4, #u712_img, #u14056_img, #u14046_img, #u14028_img, #u14014_img, #u14021_img, #pu903, #u6640_img, #u6648_img, #u6655_img, #u6662_img, #u6669_img, #u6676_img, #pu3229, #pu3315, #u3284_img, #u3315_img {
    width: auto !important;
  }
  #u903{
	background-color: white !important;
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
              <li><a href="orders.jsp">Place Order</a></li>
              <li><a href="pastOrders.jsp">Past Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
             <li><a href="cart.jsp?added=false"><i class="glyphicon glyphicon-shopping-cart"></i></a></li>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Hi <%=user.getUser_firstname()%>! <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="#"><%=user.getUser_points()%> Points</a></li>
                  <li><a href="#">Purchase a Meal Plan</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Profile Settings</li>
                  <li><a href="#">View Profile</a></li>
                </ul>
              </li>
              <li><a href="#">Logout</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>

    <div class="clearfix colelem" id="pu903"><!-- group -->
     <div class="browser_width grpelem" id="u903-bw">
      <div id="u903"><!-- column -->
       <div class="clearfix" id="u903_align_to_page">
        <div class="clearfix colelem shared_content" id="u866-4" data-content-guid="u866-4_content"><!-- content -->
         <p>Available Meal Plans</p>
        </div>
        <div class="clearfix colelem" id="pu6640"><!-- group -->
         <a class="nonblock nontext shadow clip_frame grpelem" id="u6640" href="addPoints.jsp?pay=45"><!-- image --><img class="block temp_no_img_src" id="u6640_img" src="../images/banner%20sections%207.jpg" alt="" data-image-width="177" data-image-height="271" src="../images/blank.gif"/></a>
        </div>
        <div class="clearfix colelem" id="pu6640"><!-- group -->
         <a class="nonblock nontext shadow clip_frame grpelem" id="u6640" href="addPoints.jsp?pay=35"><!-- image --><img class="block temp_no_img_src" id="u6640_img" src="../images/banner%20sections%201.jpg" alt="" data-image-width="177" data-image-height="271" src="../images/blank.gif"/></a>
         <a class="nonblock nontext shadow clip_frame grpelem" id="u6648" href="addPoints.jsp?pay=55"><!-- image --><img class="block temp_no_img_src" id="u6648_img" src="../images/banner%20sections%202.jpg" alt="" data-image-width="177" data-image-height="272" src="../images/blank.gif"/></a>
         <a class="nonblock nontext shadow clip_frame grpelem" id="u6655" href="addPoints.jsp?pay=150"><!-- image --><img class="block temp_no_img_src" id="u6655_img" src="../images/banner%20sections%203.jpg" alt="" data-image-width="177" data-image-height="271" src="../images/blank.gif"/></a>
        </div>
        <div class="clearfix colelem" id="pu6662"><!-- group -->
         <a class="nonblock nontext shadow clip_frame grpelem" id="u6662" href="addPoints.jsp?pay=40"><!-- image --><img class="block temp_no_img_src" id="u6662_img" src="../images/banner%20sections%204.jpg" alt="" data-image-width="174" data-image-height="267" src="../images/blank.gif"/></a>
         <a class="nonblock nontext shadow clip_frame grpelem" id="u6669" href="addPoints.jsp?pay=1600"><!-- image --><img class="block temp_no_img_src" id="u6669_img" src="../images/banner%20sections%205.jpg" alt="" data-image-width="174" data-image-height="267" src="../images/blank.gif"/></a>
         <a class="nonblock nontext shadow clip_frame grpelem" id="u6676" href="addPoints.jsp?pay=1900"><!-- image --><img class="block temp_no_img_src" id="u6676_img" src="../images/banner%20sections%206.jpg" alt="" data-image-width="174" data-image-height="267" src="../images/blank.gif"/></a>
        </div>
        <div class="clearfix colelem shared_content" id="u882-4" data-content-guid="u882-4_content"><!-- content -->
        </div>
       </div>
      </div>
     </div>
    </div>
   </div>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
</body>
</html>