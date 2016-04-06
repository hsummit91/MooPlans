<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*" %>
<%@ page import="com.mooplans.model.User" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>Moo Home</title>
<meta name="description" content="Blueprint: Slide and Push Menus" />
<meta name="keywords" content="sliding menu, pushing menu, navigation, responsive, menu, css, jquery" />
<meta name="author" content="Codrops" />
<link rel="shortcut icon" href="../favicon.ico">
<link rel="stylesheet" type="text/css" href="../css/default.css" />
<link rel="stylesheet" type="text/css" href="../css/component.css" />
<link rel='stylesheet prefetch' href='../css/font-awesome.css'>
<script src="../js/modernizr.custom.js"></script>
<script src="../js/jquery.min.js"></script>
<script type="text/javaScript">
	function disableBackButton() {
		window.history.forward();
	}
	setTimeout("disableBackButton()", 0);
</script>
<style type="text/css">
sideProfile > img .img-circle {
    width: 100px;
    height: 100px;
    border: 1px solid #2A363B;
}
</style>
</head>
<body class="cbp-spmenu-push" onload="getUserDetails()">
<%
		//allow access only if session exists
	User user = null;
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("login.jsp");
	}else {
		user = (User) session.getAttribute("User");
	}
	String userName = null;
	String sessionID = null;
	Cookie[] cookies = request.getCookies();
	if(cookies !=null){
	for(Cookie cookie : cookies){
	    if(cookie.getName().equals("user")) userName = cookie.getValue();
	    if(cookie.getName().equals("JSESSIONID")) sessionID = cookie.getValue();
		}
	}
%>
	
		<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post">
	</form>
	<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left" id="cbp-spmenu-s1">
		<div id="sideProfile" align="center">
			<img class="img-circle" id="profileImg" height="100px" width="100px" style="margin-left: -14px;margin-top: -5px;" src="../images/Logo faded.png" />
		</div>
		<h3><span id="firstName"><%=user.getUser_firstname() %> <%=user.getUser_lastname() %></span></h3>
		<h4>Moo Points: <span id="mooPoints"> <%=user.getUser_points()%> </span></h4>
		<a href="#" id="myProfile" onclick="displayPages(this)">My Profile</a>
		<a href="#" id="addPoints" onclick="displayPages(this)">Add Moo Points</a> 
		<a href="#" id="orderRedirect" onclick="displayPages(this)">Place an Order</a> 
		<a href="#" id="imageUpload" onclick="displayPages(this)">My Past Orders</a> 
		<a href="#" id="logout">Logout</a>
	</nav>
	<input type="hidden" id="userId" value="<%=user.getUser_id() %>" />
	<div class="container">
		<div style="cursor:pointer;font-size: 50px;z-index: 1010; margin: 5px;width: 30px;height: 30px;" id="showLeftPush">
			<div class="zooming" id="expandMenu" onclick="toggleArrows()" style="width: 30px;height: 30px;position: fixed;">
				<i class="fa fa-angle-right"></i>
			</div>
		</div>
		 <!-- <div style="text-align: center;">Welcome to Moo Plans!</div> -->

		<div id="other" style="width: auto;height: 580px;">
			<iframe width="100%" height="100%" id="homeIframe" frameborder="0"></iframe>
		</div>
	</div>
	<script src="../js/classie.js"></script>
	<script>
		var menuLeft = document.getElementById('cbp-spmenu-s1'), showLeft = document
				.getElementById('showLeft'), showLeftPush = document
				.getElementById('showLeftPush'), body = document.body;

		showLeftPush.onclick = function() {
			classie.toggle(this, 'active');
			classie.toggle(body, 'cbp-spmenu-push-toright');
			classie.toggle(menuLeft, 'cbp-spmenu-open');
			disableOther('showLeftPush');
		};

		function disableOther(button) {
			if (button !== 'showLeftPush') {
				classie.toggle(showLeftPush, 'disabled');
			}
		}

		function toggleArrows(){
			if ($("#expandMenu").hasClass("expanded")){
				$("#expandMenu").removeClass("expanded");
				$("#expandMenu").html('<i class="fa fa-angle-right"></i>');
			} else {
				$("#expandMenu").addClass("expanded");
				$("#expandMenu").html('<i class="fa fa-angle-left"></i>');
			}
		}

		function displayPages(ele){
			var id = ele.id;
			$("#other").find("iframe").empty();
			$("#other").find("iframe").attr("src", id + ".jsp");
			
			var elem = document.getElementById("showLeftPush");
			if (typeof elem.onclick == "function") {
			    elem.onclick.apply(elem);
			}
			toggleArrows();
		}
		
		function getUserDetails(){			    
			$("#other").find("iframe").attr("src", "myProfile.jsp");
		}
		
		function updatePoints(){
			var points = sessionStorage.getItem("myProfilPoints");
			$("#mooPoints").html(points);
		}
		
		$( "#logout" ).click(function() {
			  $( "#logoutForm" ).submit();
		});
		
	</script>
</body>
</html>
