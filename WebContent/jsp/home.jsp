<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
</head>
<body class="cbp-spmenu-push" onload="getUserDetails()">
<%
		//allow access only if session exists
	String user = null;
	if(session.getAttribute("user") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("login.jsp");
	}else user = (String) session.getAttribute("user");
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
		<div id="sideProfile" align="center"></div>
		<h3><span id="firstName">Omkar Kulkarni</span></h3>
		<h4>Moo Points: <span id="mooPoints"> 175 </span></h4>
		<a href="#" id="myProfile" onclick="displayPages(this)">My Profile</a>
		<a href="#" id="addPoints" onclick="displayPages(this)">Add Moo Points</a> 
		<a href="#" id="orderRedirect" onclick="displayPages(this)">Place an Order</a> 
		<a href="#" id="imageUpload" onclick="displayPages(this)">My Past Orders</a> 
		<a href="#" id="logout">Logout</a>
	</nav>
	<div class="container">
		<div style="cursor:pointer;font-size: 50px;z-index: 1010; margin: 5px;width: 30px;height: 30px;" id="showLeftPush">
			<div class="zooming" id="expandMenu" onclick="toggleArrows()" style="width: 30px;height: 30px;">
				<i class="fa fa-angle-right"></i>
			</div>
		</div>
		 <div style="text-align: center;">Welcome to Moo Plans!</div>

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
		}
		
		function getUserDetails(){				
			    $.ajax({
					  method: "POST",
					  url: "../FetchData",
					  data: { action: "getUserDetails", userId: "1"  }
					}).done(function( msg ) {
						  console.log(msg.firstName);
						  var lastName = "";
						  if(msg.lastName != undefined){
							  lastName = msg.lastName;
						  }
						  $("#firstName").html(msg.firstName + " " + lastName);
						  $("#mooPoints").html(msg.points);
					});
			    
				$("#other").find("iframe").attr("src", "myProfile.jsp");
		}
		
		$( "#logout" ).click(function() {
			  $( "#logoutForm" ).submit();
		});
		
	</script>
</body>
</html>
