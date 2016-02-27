<!DOCTYPE html>
<html lang="en" class="no-js">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
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
</head>
<body class="cbp-spmenu-push">
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
	<h3>Hi<%=userName%>, Login successful. Your Session ID=<%=sessionID%></h3>
	<nav class="cbp-spmenu cbp-spmenu-vertical cbp-spmenu-left"
		id="cbp-spmenu-s1">
		<div id="sideProfile" align="center"></div>
		<h3>Omkar Kulkarni</h3>
		<h4>Moo Points: 175</h4>
		<a href="#" id="myProfile" onclick="displayPages(this)">My Profile</a>
		<a href="#" id="addPoints" onclick="displayPages(this)">Add Moo
			Points</a> <a href="#" id="orderRedirect" onclick="displayPages(this)">Place
			an Order</a> <a href="#" id="pastOrders" onclick="displayPages(this)">My
			Past Orders</a> <a href="#" id="contactUs" onclick="displayPages(this)">Contact
			Us</a>
	</nav>
	<div class="container">
		<div
			style="cursor: pointer; font-size: 50px; z-index: 1010; margin: 5px;"
			id="showLeftPush">
			<div class="zooming" id="expandMenu" onclick="toggleArrows()"
				style="width: 50px; height: 50px;">
				<i class="fa fa-angle-right"></i>
			</div>
		</div>
		<div style="text-align: center;">Welcome to Moo Plans!</div>

		<div id="other" style="width: auto; height: 1000px;">
			<iframe width="100%" height="100%" frameborder="0"></iframe>
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

		function toggleArrows() {
			if ($("#expandMenu").hasClass("expanded")) {
				$("#expandMenu").removeClass("expanded");
				$("#expandMenu").html('<i class="fa fa-angle-right"></i>');
			} else {
				$("#expandMenu").addClass("expanded");
				$("#expandMenu").html('<i class="fa fa-angle-left"></i>');
			}
		}

		function displayPages(ele) {
			var id = ele.id;
			console.log("================>" + id)
			$("#other").find("iframe").empty();
			$("#other").find("iframe").attr("src", id + ".jsp");
		}
	</script>
</body>
</html>
