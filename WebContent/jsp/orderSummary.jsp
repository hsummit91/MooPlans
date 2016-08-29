<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Cart"%>
<%@ page import="com.mooplans.model.Order"%>
<%@ page import="com.mooplans.model.User"%>
<!DOCTYPE html>
<!--[if IE 9]><html class="ie ie9"> <![endif]-->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="pizza, delivery food, fast food, sushi, take away, chinese, italian food">
    <meta name="description" content="">
    
    <title>Moo Plans - Order Summary</title>
    <!-- Favicons-->
    <link rel="icon" type="image/png" sizes="16x16" href="img/favicon-16x16.png">
    <link rel="apple-touch-icon" sizes="57x57" href="img/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="72x72" href="img/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="114x114" href="img/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="144x144" href="img/apple-icon-144x144.png">
    
    <!-- GOOGLE WEB FONT -->
    <link href='https://fonts.googleapis.com/css?family=Lato:400,700,900,400italic,700italic,300,300italic' rel='stylesheet' type='text/css'>

    <!-- BASE CSS -->
    <link href="css/base.css" rel="stylesheet">
    
     <!-- Radio and check inputs -->
    <link href="css/skins/square/grey.css" rel="stylesheet">
    <link href="css/ion.rangeSlider.css" rel="stylesheet">
    <link href="css/ion.rangeSlider.skinFlat.css" rel="stylesheet" >

    <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->

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
<!--[if lte IE 8]>
    <p class="chromeframe">You are using an <strong>outdated</strong> browser. Please <a href="http://browsehappy.com/">upgrade your browser</a>.</p>
<![endif]-->

	<div id="preloader">
        <div class="sk-spinner sk-spinner-wave" id="status">
            <div class="sk-rect1"></div>
            <div class="sk-rect2"></div>
            <div class="sk-rect3"></div>
            <div class="sk-rect4"></div>
            <div class="sk-rect5"></div>
        </div>
    </div><!-- End Preload -->

    <!-- Header ================================================== -->
       <header class="bar">
    <div class="container-fluid ">
        
        <div class="row">
            <div class="col--md-4 col-sm-4 col-xs-4">
                <a href="jsp/home.jsp" id="logo">
                <img src="img/logo.png" width="234" height="49" style="margin-top:1px;" alt="" data-retina="true" class="hidden-xs">
                <img src="img/logo_mobile.png" width="44" height="35" alt="" data-retina="true" class="hidden-lg hidden-md hidden-sm">
                </a>
            </div>
            <nav class="col--md-8 col-sm-8 col-xs-8">
            <a class="cmn-toggle-switch cmn-toggle-switch__htx open_close" href="javascript:void(0);"><span>Menu mobile</span></a>
            <div class="main-menu">
                <div id="header_menu">
                    <img src="img/logo.png" width="234" height="49" alt="" data-retina="true">
                </div>
                <a href="#" class="open_close" id="close_in"><i class="icon_close"></i></a>
                <ul>
                    <li class="submenu">
                    <a href="javascript:void(0);" class="show-submenu">Hi <%=user.getUser_firstname() %>! <i class="icon-down-open-mini"></i></a>
                    <ul>
                        <li><a href="mealPlans.jsp"><%=user.getUser_points()%> points</a></li>
                      </ul>
                    </li>
                    <li><a href="jsp/home.jsp">Home</a></li>
                    <!-- <li><a href="#">Calender</a></li> -->
                    <li><a href="jsp/myProfile.jsp">Account</a></li>
                    <li><a href="jsp/mealPlans.jsp">Meal Plans</a></li>
                    <li><a href="#"  id="logout">Logout</a></li>
                </ul>
            </div><!-- End main-menu -->
            </nav>
        </div><!-- End row -->
        
    </div><!-- End container -->
    </header>
    <!-- End Header =============================================== -->


	<%
		String msg = (String) session.getAttribute("message");
		String total = (String) session.getAttribute("totalBill");
		Cart shoppingCart = (Cart) session.getAttribute("cart");
		String deliveryTime = (String) session.getAttribute("deliveryTime");
		String deliveryAddress = (String) session.getAttribute("deliveryAddress");
		String paymentMode = (String) session.getAttribute("paymentMode");
		
		HashMap<Integer, String> items = shoppingCart.getCartItems();
		HashMap<Integer, Float> cartPrice = shoppingCart.getCartPrice();
		HashMap<Integer, Float> cartFullPrice = shoppingCart.getCartFullPrice();
	%>


<!-- Content ================================================== -->
<div class="container margin_120">
  
    
	<div class="row">
		<div class="col-md-offset-3 col-md-6">
			<div class="box_style_2">
				<h2 class="inner">Order confirmed!</h2>
				<div id="confirm">
					<i class="icon_check_alt2"></i>
					<h3>Thank you!</h3>
					
				</div>
				<h4>Summary</h4>
				<table class="table table-striped nomargin">
				<tbody>
				
				
				<tr>
					<td colspan=2>
						 <%=msg%> is on its way!
					</td>
				</tr>
				<tr>
					<td>
						 Delivery schedule <a href="#" class="tooltip-1" data-placement="top" title="" data-original-title="Please consider 30 minutes of margin for the delivery!"><i class="icon_question_alt"></i></a>
					</td>
					<td>
						<strong class="pull-right">Today <%=deliveryTime %></strong>
					</td>
				</tr>
				<tr>
					<td>
						 Deliver To:
					</td>
					<td>
						<strong class="pull-right"><%=deliveryAddress %></strong>
					</td>
				</tr>
				<tr>
					<td>
						 Payment Mode:
					</td>
					<td>
						<strong class="pull-right"><%=paymentMode %></strong>
					</td>
				</tr>
				<tr>
					<td colspan=2>
						 <strong>Order:</strong>
					</td>
				</tr>
			<%for (Integer key : items.keySet()) {
				
				float price = 0;
				if(paymentMode.equals("points")){
					price = cartPrice.get(key);
			 	}else{
			 		price = cartFullPrice.get(key);
			 	}
			 	
			%>
				<tr>
					<td>
						 <%=items.get(key)%>
					</td>
					<td>
						 <strong class="pull-right"><%=price%></strong>
					</td>
				</tr>
			<%}%>	
				<tr>
					<td class="total_confirm">
						 TOTAL
					</td>
					<td class="total_confirm">
						<span class="pull-right"><%=total%></span>
					</td>
				</tr>
				</tbody>
				</table>
			</div>
		</div>
	</div><!-- End row -->
</div><!-- End container -->
<!-- End Content =============================================== -->

 <!-- Footer ================================================== -->
    <footer>
    <div class="container">
        <div class="row">
           
            <div class="col-md-2 col-sm-2">
                <h3>Moo Plans</h3>
                <ul>
                    <li><a href="#">Catering</a></li>
                    <li><a href="#">Faq</a></li>
                    <li><a href="#">Office</a></li>
                    
                    <li><a href="#">Developers</a></li>
                    <li><a href="#">Contacts</a></li>
                    <li><a href="#">Become a Restaurant</a></li>
                    <li><a href="#">Business Info</a></li>
                    
                </ul>
            </div>
            <div class="col-md-5 col-sm-5" id="newsletter">
                <h3>Newsletter</h3>
                <p>
                    Join our newsletter to keep be informed about offers and news.
                </p>
                <div id="message-newsletter_2">
                </div>
                <form method="post" action="assets/newsletter.php" name="newsletter_2" id="newsletter_2">
                    <div class="form-group">
                        <input name="email_newsletter_2" id="email_newsletter_2" type="email" value="" placeholder="Your mail" class="form-control">
                    </div>
                    <input type="submit" value="Subscribe" class="btn_1" id="submit-newsletter_2">
                </form>
            </div>
            <div class="col-md-5 col-sm-5">
                <h3>Settings</h3>
                <div class="styled-select">
                    <select class="form-control" name="lang" id="lang">
                        <option value="English" selected>English</option>
                        <option value="French">French</option>
                        <option value="Spanish">Spanish</option>

                    </select>
                </div>
               
                
                <h3>Secure payments with</h3>
                <p>
                    <img src="img/cards.png" alt="" class="img-responsive">
                </p>
            </div>
            </div>
        </div><!-- End row -->
        <div class="row">
            <div class="col-md-12">
                <div id="social_footer">
                    <ul>
                        <li><a href="www.facebook.com/mooplans"><i class="icon-facebook"></i></a></li>
                        <li><a href="www.twitter.com/mooplans"><i class="icon-twitter"></i></a></li>
                      
                        <li><a href="www.instagram.com/mooplans"><i class="icon-instagram"></i></a></li>
                        
                    </ul>
                    <p>
                       2016 MOO PLANS LLC. ALL RIGHTS RESERVED.
                    </p>
                </div>
            </div>
        </div><!-- End row -->
    </div><!-- End container -->
    </footer>
    <!-- End Footer =============================================== -->

<div class="layer"></div><!-- Mobile menu overlay mask -->

<!-- Login modal -->   
<div class="modal fade" id="login_2" tabindex="-1" role="dialog" aria-labelledby="myLogin" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content modal-popup">
				<a href="#" class="close-link"><i class="icon_close_alt2"></i></a>
				<form action="#" class="popup-form" id="myLogin">
                	<div><img src="img/logo_m.png" /></div>
                    
					<input id="author" type="text" class="form-control form-white" placeholder="Username">
					<input id="lock" type="password" class="form-control form-white" placeholder="Password">
					<div class="text-left">
						<a href="#">Forgot Password?</a>
					</div>
					<button type="submit" class="btn btn-submit">Sign up</button>
				</form>
			</div>
		</div>
	</div><!-- End modal -->   
<% items.clear();
	session.setAttribute("message", "");
%>
<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>
    
<!-- COMMON SCRIPTS -->
<script src="js/jquery-1.11.2.min.js"></script>
<script src="js/common_scripts_min.js"></script>
<script src="js/functions.js"></script>
<script src="assets/validate.js"></script>

<!-- SPECIFIC SCRIPTS -->
<script src="js/theia-sticky-sidebar.js"></script>
<script>
    jQuery('#sidebar').theiaStickySidebar({
      additionalMarginTop: 80
    });
    
    $( "#logout" ).click(function() {
    	  $( "#logoutForm" ).submit();
    });
</script>
<script src="js/ion.rangeSlider.js"></script>
<script>
    $(function () {
		 'use strict';
        $("#range").ionRangeSlider({
            hide_min_max: true,
            keyboard: true,
            min: 0,
            max: 20,
            from: 0,
            to:5,
            type: 'double',
            step: 1,
            prefix: "$ ",
            grid: true
        });
    });
</script>
</body>
</html>