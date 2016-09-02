<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Cart"%>
<%@ page import="com.mooplans.model.Order"%>
<%@ page import="com.mooplans.model.StartupData"%>
<%@ page import="com.mooplans.model.Dishes"%>
<!DOCTYPE html>
<!--[if IE 9]><html class="ie ie9"> <![endif]-->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="pizza, delivery food, fast food, sushi, take away, chinese, italian food">
    <meta name="description" content="">
    
    <title>Moo Plans - Cart Summary</title>
    <!-- Favicons-->
    <link rel="icon" type="image/png" sizes="16x16" href="img/favicon-16x16.png">
    <link rel="apple-touch-icon" sizes="57x57" href="img/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="72x72" href="img/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="114x114" href="img/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="144x144" href="img/apple-icon-144x144.png">
    
    <!-- GOOGLE WEB FONT -->
    <link href='https://fonts.googleapis.com/css?family=Lato:400,700,900,400italic,700italic,300,300italic' rel='stylesheet' type='text/css'>

    <!-- BASE CSS -->
    <link href="../css/base.css" rel="stylesheet">
    
     <!-- Radio and check inputs -->
    <link href="../css/skins/square/grey.css" rel="stylesheet">
    <link href="../css/ion.rangeSlider.css" rel="stylesheet">
    <link href="../css/ion.rangeSlider.skinFlat.css" rel="stylesheet" >
    <link rel="stylesheet" type="text/css" href="../css/jquery.timepicker.css">

    <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<%
	//allow access only if session exists
		
	StartupData sd = StartupData.getInstance();		
	
	User user = null;
	Cart shoppingCart = null; 
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("login.jsp");
	}else{
		user = (User) session.getAttribute("User");
		shoppingCart = (Cart) session.getAttribute("cart");
		
		if(shoppingCart == null){
			System.out.println("Cart servlet where cart is empty");
			shoppingCart = new Cart();
			session.setAttribute("cart", shoppingCart);
		}
	}
	
	float bill = 0;
	float priceBill = 0;
	try{
		bill = shoppingCart.getTotalBill();
		priceBill = shoppingCart.getTotalPriceBill();
	}catch(Exception e){
		
	}
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
                <a href="home.jsp" id="logo">
                <img src="../img/logo.png" width="234" height="49" style="margin-top:1px;" alt="" data-retina="true" class="hidden-xs">
                <img src="../img/logo_mobile.png" width="44" height="35" alt="" data-retina="true" class="hidden-lg hidden-md hidden-sm">
                </a>
            </div>
            <nav class="col--md-8 col-sm-8 col-xs-8">
            <a class="cmn-toggle-switch cmn-toggle-switch__htx open_close" href="javascript:void(0);"><span>Menu mobile</span></a>
            <div class="main-menu">
                <div id="header_menu">
                    <img src="../img/logo.png" width="234" height="49" alt="" data-retina="true">
                </div>
                <a href="#" class="open_close" id="close_in"><i class="icon_close"></i></a>
                <ul>
                    <li class="submenu">
                    <a href="javascript:void(0);" class="show-submenu">Hi <%=user.getUser_firstname() %>! <i class="icon-down-open-mini"></i></a>
                    <ul>
                        <li><a href="mealPlans.jsp"><%=user.getUser_points()%> points</a></li>
                      </ul>
                    </li>
                    <li><a href="home.jsp">Home</a></li>
                    <!-- <li><a href="#">Calender</a></li> -->
                    <li><a href="myProfile.jsp">Account</a></li>
                    <li><a href="mealPlans.jsp">Meal Plans</a></li>
                    <li><a href="#"  id="logout">Logout</a></li>
                </ul>
            </div><!-- End main-menu -->
            </nav>
        </div><!-- End row -->
        
    </div><!-- End container -->
    </header>
    <!-- End Header =============================================== -->





<!-- Content ================================================== -->
<div class="container margin_120">
  <form class="form-horizontal" action="../AddressServlet?action=newAddress" method="post">
    
	<div class="row">
			
        
		<div class="col-md-9">
				<div class="box_style_2" id="order_process">
					<h2 class="inner">Your order details</h2>
					<div class="form-group">
						<label>Full name</label>
						<input type="text" class="form-control" id="fullname" readonly name="fullname" value="<%=user.getUser_firstname()%> <%=user.getUser_lastname()%>" placeholder="Full name">
					</div>
					<div class="form-group">
						<label>Phone</label>
						<input type="text" id="phone" readonly name="phone" placeholder="Phone Number" value="<%=user.getUser_phone()%>" class="form-control">
					</div>
					<div class="form-group">
						<label>Address</label>
						<textarea class="form-control" id="address" name="address" rows="4" cols="50" ></textarea>
<!-- 						<select  class="form-control" id="address" name="address" >
								<option selected="selected" value="Campus Center">University at Albany: Campus Center</option>
								<option value="Dutch Quad">Dutch Quad</option>
								<option value="Colonial Quad">Colonial Quad</option>
								<option value="State Quad">State Quad</option>
								<option value="Indian Quad">Indian Quad</option>
								<option value="Freedom Apartments">Freedom Apartments</option>
								<option value="Liberty Terrace Apartments">Liberty Terrace Apartments</option>
								<option value="Empire Commons">Empire Commons</option>
								<option value="Alumni (Bus Stop)">Alumni (Bus Stop)</option>
						</select> -->
					</div>
					<hr>
					<div class="row">
						<div class="col-md-6 col-sm-6">
							<div class="form-group">
								<label>Delivery Day</label>
								<select class="form-control" name="delivery_schedule_day" id="delivery_schedule_day">
									<option value="" selected>Select day</option>
									<option value="Today">Today</option>
								</select>
							</div>
						</div>
						<div class="col-md-6 col-sm-6">
							<div class="form-group">
								<label>Delivery time</label>
									<input id="basicExample" required name="time" class="time ui-timepicker-input form-control" type="text" autocomplete="off">
							</div>
						</div>
					</div>
				</div><!-- End box_style_1 -->
			</div><!-- End col-md-9 -->
        
        
        <div class="col-md-3" id="sidebar">
            <div class="theiaStickySidebar">
				<div id="cart_box" >
					<h3>Your order <i class="icon_cart_alt pull-right"></i></h3>
					<table class="table table_summary">
					<tbody id="shoppingCart">
					<%  HashMap<Integer, String> items = shoppingCart.getCartItems();
					HashMap<Integer, Float> cPrice = shoppingCart.getCartPrice();
					 int count = 0;
					 int deliveryFee = 0;
					 double finalBill = 0;
					 double finalBillTax = 0;
					 double finalPoints = 0;
					 double totalBill = 0;
					 HashMap<Integer,Integer> delivery = new HashMap();
						for(Integer key: items.keySet()){
							//out.println(key);
							Dishes dish = sd.getDishDataById(key);
							if(!delivery.containsKey(dish.getRestId())){
								delivery.put(dish.getRestId(), dish.getDeliveryFee());
								deliveryFee += dish.getDeliveryFee();
							}
							//dish.getRestId();
							
							//deliveryFee += dish.getDeliveryFee();
							finalBill = priceBill + deliveryFee;
							
							finalBillTax = finalBill * (0.08);
							
							totalBill = finalBill + finalBillTax;
							
							finalPoints = totalBill/10;
							
							count++;%>
					<tr>
						<td>
							<a href="#0" class="remove_item deleteItem" dishId="<%=key %>"></a> <%= items.get(key)%>
						</td>
						<td>
							<strong class="pull-right"><%=cPrice.get(key) %>P</strong>
						</td>
					</tr>
					<% 	} 
						if(items.size() == 0){ %>
							<tr><td>No items in cart</td></tr>
						<% } %>				
					</tbody>
					</table>
					<hr>
					<div class="row" id="options_2">
						<div class="col-lg-6 col-md-12 col-sm-12 col-xs-6">
							<label class="rdio"><input type="radio" value="points" checked name="checkoutType" class="icheck">Points</label>
						</div>
						<div class="col-lg-6 col-md-12 col-sm-12 col-xs-6">
							<label class="rdio"><input type="radio" value="cash" name="checkoutType" class="icheck">Cash</label>
						</div>
					</div><!-- Edn options 2 -->
                    
					<hr>
                    <table class="table table_summary">
					<tbody>
					<tr>
						<td>
							 Total Points <span class="pull-right" id="pointsBill"><%=bill %></span>
						</td>
					</tr>
					<tr>
						<td>
							 Cash Price <span class="pull-right" id="priceBill"><%=priceBill %></span>
						</td>
					</tr>
					</tbody>
					</table>
					<hr>
					<table class="table table_summary">
					<tbody>
 					<tr>
						<td>
							 Delivery fee 
						</td>
                        <td>
							 <span class="pull-right">$<%=deliveryFee %></span>
						</td>
					</tr> 
 					<tr>
						<td class="total">
							 TOTAL <span class="pull-right" id="finalBill">$<%=Float.parseFloat(String.format( "%.2f",totalBill)) %></span>
							 <input type="hidden" name="finalBill" value="<%=Float.parseFloat(String.format( "%.2f",totalBill))%>" />
							 <input type="hidden" name="finalPoints" value="<%=Float.parseFloat(String.format( "%.2f",finalPoints))%>" />
						</td>
					</tr> 
					 <tr>
						<td class="total">
							 TOTAL POINTS <span class="pull-right" id="finalPts"><%=Float.parseFloat(String.format( "%.2f",finalPoints)) %>P</span>
						</td>
					</tr>
					</tbody>
					</table>
					<hr>
					<button onclick="checkTime();" type="submit" id="submit" name="submit"
									class="btn_full">Deliver to this address</button>
					<!-- <a class="btn_full" href="cart_step2.html">Go to Checkout</a> -->
                    <a class="btn_full_outline" href="../jsp/orders.jsp"><i class="icon-right"></i> Add other items</a>
				</div><!-- End cart_box -->
                </div><!-- End theiaStickySidebar -->
			</div><!-- End col-md-3 -->
	</div><!-- End row -->
	</form>
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
                	<div><img src="../img/logo_m.png" /></div>
                    
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
    

<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>    
<!-- COMMON SCRIPTS -->
<script src="../js/jquery-1.11.2.min.js"></script>
<script src="../js/common_scripts_min.js"></script>
<script src="../js/functions.js"></script>
<script src="../assets/validate.js"></script>
<script src="../js/jquery.timepicker.min.js"></script>

<!-- SPECIFIC SCRIPTS -->
<script src="../js/theia-sticky-sidebar.js"></script>
<script>
    jQuery('#sidebar').theiaStickySidebar({
      additionalMarginTop: 80
    });
    
    $( "#logout" ).click(function() {
    	  $( "#logoutForm" ).submit();
    });
</script>
<script src="../js/ion.rangeSlider.js"></script>
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
    


    
    
/*     $('input:radio').click(function() {
    	paymentMode = this.value;
        if(paymentMode == "points"){
        	$("#finalBill").html($("#pointsBill"));
        }else if(paymentMode == "cash"){
        	$("#finalBill").html($("#priceBill"));
        }
    }); */
    
    function checkTime(){
    	var time = $("#basicExample").val();
    	console.log(time)
    	if(time == ""){
    		return false;
    	}else{
    		waitingDialog.show('Brace yourself.. Placing Order');
    	}
    }

    $( "#logout" ).click(function() {
    	  $( "#logoutForm" ).submit();
    });

       /* $('#timepicker1').timepicker('minuteStep','30'); */
       
       function getTime(){
    	   var date = new Date();
    	   var hours = date.getHours();
    	   var mins = date.getMinutes();
    	   
    	   //console.log(parseInt(hours + 1) + ":30")
    	   
    	   if(mins>15){
    		   return parseInt(hours + 2) + ":00";
    	   }else{
    		   return parseInt(hours + 1) + ":30";
    	   }
       }
       
       
       $('#basicExample').timepicker({
    	    'disableTimeRanges': [
    	                          ['9:01am', '9:59am'],
    	                          ['10:01am', '10:59am'],
    	                          ['2:01pm', '2:59pm'],
    	                          ['3:01pm', '3:59pm'],
    	                          ['4:01pm', '4:59pm'],
    	                          ['9:01pm', '9:59pm'],
    	                          ['10:01pm', '10:59pm']
    	                         ],
    	                 	    'minTime': getTime(),
    	                	    'maxTime': '11:00pm'
    	});
</script>
</body>
</html>