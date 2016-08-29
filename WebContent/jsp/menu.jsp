<%@page import="com.sun.xml.internal.txw2.Document"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="org.json.JSONArray"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Dishes"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Cart" %>
<!DOCTYPE html>
<!--[if IE 9]><html class="ie ie9"> <![endif]-->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="pizza, delivery food, fast food, sushi, take away, chinese, italian food">
    <meta name="description" content="">
    
    <title>Moo Plans - Order Menu</title>
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
    <link href="css/skins/square/green.css" rel="stylesheet">
    <link href="css/ion.rangeSlider.css" rel="stylesheet">
    <link href="css/ion.rangeSlider.skinFlat.css" rel="stylesheet" >
    <link rel="stylesheet" type="text/css" href="css/jquery-ui.css">

    <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<%
	//allow access only if session exists		
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





<!-- Content ================================================== -->
<div class="container margin_120">
    <div class="main_title">
           <h2 class="nomargin_top">Place Order</h2>
            
        </div>
    
	<div class="row">
    
		<div class="col-md-3">
			
			<div id="filters_col">
				<a data-toggle="collapse" href="#collapseFilters" aria-expanded="false" aria-controls="collapseFilters" id="filters_col_bt" class="collapsed">Filters <i class="icon-plus-1 pull-right"></i></a>
				<div class="collapse" id="collapseFilters">
                <div class="filter_type">
                    <h6></h6>
                    	<h5>Meal Preference</h5>
                        <div class="form-group">
						  <div class="form-control" id="mealPreference">
						  	<div class="ui-widget">
					  			<input id="tags" size="24">
							</div>
						  </div>
					   </div>
                    </div>
                     <div class="filter_type">
                         <h5>Categories</h5>
                        <div class="form-group">
						  <div class="form-control" id="category">
						  	<div class="ui-widget">
					  			<input id="cTags" size="24">
							</div>
						  </div>
					   </div>
                    </div>
<!--                     <div class="filter_type">
                         <h5>Price Range</h5>
                        <input type="text" id="range" value="" name="range">
                	</div> -->
<!--                     <div class="filter_type">
						<h5>Options</h5>
						<ul class="nomargin">
							<li><label><input type="checkbox" class="icheck">Delivery</label></li>
							<li><label><input type="checkbox" class="icheck">Take Away</label></li>
							<li><label><input type="checkbox" class="icheck">Dine In</label></li>
						</ul>
					</div> -->
                    
						<!--<div class="checkbox-holder1 text-left">
						<div class="checkbox1">
							<input type="checkbox" value="accept_2" id="check_2" name="check_2" />
                            <label for="check_2"><span>Dine In</span></label>
						</div>
					</div>-->
					<h6></h6>
				<a class="btn_full" style="margin-bottom:10px;" onclick="getFilters()">Add Filter </a>
                 <a class="btn_full" href="jsp/orders.jsp">Search Restaurant? </a>   

				</div><!--End collapse -->
			</div><!--End filters col-->
		</div><!--End col-md 3-->
        
		<div class="col-md-6" id="dishes">

			<%
			JSONArray rest = (JSONArray) request.getAttribute("menuList");
			//out.println(rest.length());
			for (int i = 0; i < rest.length(); i++) { 
				String command = null;
				String options = null;
				try{
					command = (String) rest.getJSONObject(i).get("dishCommand");				
					options = (String) rest.getJSONObject(i).get("dishChoice");
				}catch(Exception e){
					
				}
				if(command == null){
					command = "";
				}
				if(options == null){
					options = "";
				}
				String opt = "";
				
				//out.println(options);
				//out.println(options.length());
				
				if(options.length() > 0){
					opt += "<div><strong>Item | Type | Price</strong></div>";
					String[] splitOp = options.split("#");
					for(int j=0;j<splitOp.length;j++){
						opt += "<div>"+splitOp[j]+"</div>";
					}
				}
				
			%>
            <div class="strip_list_menu" >
				
				<div class="row">
					<div class="col-md-12 col-sm-12">
						<div class="desc">
							<div class="thumb_strip">
								<img src="img/apple-icon-114x114.png" alt="<%=rest.getJSONObject(i).get("dishName")%>">
							</div>
							
							<h3><%=rest.getJSONObject(i).get("dishName")%></h3>
							<div class="type">
								<%=rest.getJSONObject(i).get("dishDesc") %>                              
							</div>
							<div class="type">
								<%=rest.getJSONObject(i).get("dishCat")%>                             
							</div>
							<div class="type">
								<%=rest.getJSONObject(i).get("dishHealth")%>                           
							</div>
							
                            <h5 style="color:#67c03a;">$<%=rest.getJSONObject(i).get("dishFullPrice")%> <span style="color:#3d4144;">or</span> <%=rest.getJSONObject(i).get("dishPrice")%> Points</h5>
                             <div class="line"><h6></h6></div>
						</div>
                       
					</div>
				
                    	
                    <div id="filtersMenu_col">
				<a data-toggle="collapse" href="#collapseFiltersMenu<%=rest.getJSONObject(i).get("dishId") %>" aria-expanded="true" aria-controls="collapseFiltersMenu" id="filtersMenu_col_bt" class="collapsed">More details <i class="icon-plus-1 pull-right"></i></a>
				<div class="collapse" id="collapseFiltersMenu<%=rest.getJSONObject(i).get("dishId") %>">
                
                 <div class="filterMenu_type">
                    <h6></h6>
                            <h5>You can add <%=command %> to this order.</h5>
						<div>
							<strong>Please choose from : </strong> <%=opt %>
						</div>
						<h6></h6>
						<div>Please write your choices in the box below</div>
                  </div>
                
                <div class="filterMenu_type">
                    <h6></h6>
                            <h5>Notes:</h5>
						<div >
							<textarea style="margin-left: 22px;" rows="4" cols="50" id="<%=rest.getJSONObject(i).get("dishId") %>_notes"></textarea>
						</div>
					<h6></h6>
                    </div><!--End filterMenu_type -->

                    <a href="#" dishId="<%=rest.getJSONObject(i).get("dishId") %>" dishName="<%=rest.getJSONObject(i).get("dishName") %>" dishP="<%=rest.getJSONObject(i).get("dishPrice") %>" dishFP="<%=rest.getJSONObject(i).get("dishFullPrice") %>" class="btn_full addToCart">Add</a>
                    </div><!--End collapse -->
			</div><!--End filtersMenu col-->
                    
                    
				</div><!-- End row-->
                
			</div><!-- End strip_list_menu-->
<%}%>
		</div><!-- End col-md-6-->
        
        
        <div class="col-md-3" id="sidebar">
            <div class="theiaStickySidebar">
				<div id="cart_box" >
					<h3>Your order <i class="icon_cart_alt pull-right"></i></h3>
					<table class="table table_summary">
					<tbody id="shoppingCart">
					<%  HashMap<Integer, String> items = shoppingCart.getCartItems();
                		HashMap<Integer, Float> cPrice = shoppingCart.getCartPrice();
                		   HashMap<Integer, Float> cFPrice = shoppingCart.getCartFullPrice();
					 int count = 0;
						for(Integer key: items.keySet()){
							count++;%>
					<tr>
						<td>
							<a href="#0" class="remove_item deleteItem" dishId="<%=key %>"><i class="icon_minus_alt"></i></a> <%= items.get(key)%>
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
<!--					<hr>
					<div class="row" id="options_2">
						<div class="col-lg-6 col-md-12 col-sm-12 col-xs-6">
							<label><input type="radio" value="" checked name="option_2" class="icheck">Delivery</label>
						</div>
						<div class="col-lg-6 col-md-12 col-sm-12 col-xs-6">
							<label><input type="radio" value="" name="option_2" class="icheck">Take Away</label>
						</div>
					</div><!-- Edn options 2 -->
                    
<!--					<hr>
                    <table class="table table_summary">
					<tbody>
					<tr>
						<td>
							 Total Points <span class="pull-right">5</span>
						</td>
					</tr>
					
					</tbody>
					</table>
 					<hr>
					<table class="table table_summary">
					<tbody>
					<tr>
						<td>
							 Subtotal <span class="pull-right">$32.50</span>
						</td>
					</tr>
					<tr>
						<td>
							 Delivery fee <span class="pull-right">$3</span>
						</td>
                        <td>
							 Delivery free
						</td>
					</tr>
					<tr>
						<td class="total">
							 TOTAL <span class="pull-right">$32.50</span>
						</td>
					</tr>
					</tbody>
					</table>
					<hr> -->
					<% 	
					if(items.size() > 0){ %>
					<a id="cartBtn" class="btn_full" href="jsp/checkout.jsp">Order now</a>
					<%} %>
				</div><!-- End cart_box -->
                </div><!-- End theiaStickySidebar -->
			</div><!-- End col-md-3 -->
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
    

 <form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>   
<!-- COMMON SCRIPTS -->
<script src="js/jquery-1.11.2.min.js"></script>
<script src="js/common_scripts_min.js"></script>
<script src="js/functions.js"></script>
<script src="assets/validate.js"></script>
     <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="js/jquery-ui.js"></script>
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
    
	$( "#logout" ).click(function() {
	  	$( "#logoutForm" ).submit();
	});
	
	function call(){ // refrshng the page and shwing added items to cart
	    $.ajax({
		  	method: "POST",
		  	url: "./FetchData",
		  	data: { action: "cartJson" }
		}).done(function( msg ) {
			console.log("===========>"+msg.length)
			$("#shoppingCart").empty();
			var text = "";
			var txtBtn = "";
			for(i=0;i<msg.length;i++){	
				
				text += '<tr><td><a href="#0" class="remove_item deleteItem" dishId="'+msg[i].dishId+'"><i class="icon_minus_alt"></i></a> '+msg[i].dishName+'</td>';
				text += '<td><strong class="pull-right">'+msg[i].dishPrice+'P</strong></td></tr>';
				
				//text += '<div class="col-md-12 thumbnail"><div class="col-md-6">'+msg[i].dishName+'</div><div class="col-md-6"><button class="btn btn-primary deleteItem" dishId="'+msg[i].dishId+'">X</button></div></div>';
			}
			if(msg.length == 0){
				text += '<tr><td>No items in cart</td></tr>';
				$("#cartBtn").remove();
			}else{
				//txtBtn += '<a class="btn_full" href="cart_step1.html">Order now</a>';
				if($("#cartBtn").length < 1){
					$("#cart_box").append('<a id="cartBtn" class="btn_full" href="jsp/checkout.jsp">Order now</a>');
				}
			}
			$("#shoppingCart").html(text);
		});

	}

 	$(document).ready(function() {
 		
 		$('body').on('click', '.addToCart', function() {
 		    	
 		    	var dishId = $(this).attr("dishId");
 		    	var dishName = $(this).attr("dishName");
 		    	
 		    	var dishPrice = $(this).attr("dishP");
 		    	var dishFullPrice = $(this).attr("dishFP");
 		    	
 		    	var notes = $("#"+dishId+"_notes").val();
 		    	//var notes = "";
 		    	console.log("ID = "+dishId+" - Name = "+dishName+" - NOTES = "+notes+" ==dishFullPrice=="+dishFullPrice+" -dishPrice- "+dishPrice)

  		 		$.ajax({
 				  	method: "POST",
 				  	url: "./CartServlet",
 				  	data: { button: "add", dishId: dishId, dishName: dishName, notes: notes, dishPrice : dishPrice, dishFullPrice : dishFullPrice }
 				}).done(function( msg ) {
 					console.log(msg);
 					$(".glyphicon-shopping-cart").addClass('transition');
 	 		        $(".badge").html(msg);
 	 		       // openDialog(dishId);
 	 		        call();
 	 		        setTimeout(function(){ 
 	 		        	$(".glyphicon-shopping-cart").removeClass('transition');
 	 		        }, 1000);
 	 		     // $( "#dialogDesc_"+dishId ).dialog( "close" );	
 				}); 
 		    	
 		    });
 		    
 		   $('body').on('click', '.deleteItem', function() {
 			 	
 			 	var dishId = $(this).attr("dishId");
 			 
 			 	console.log("ID = "+dishId)
 				
 					$.ajax({
 					  	method: "POST",
 					  	url: "./CartServlet",
 					  	data: { dishId: dishId }
 					}).done(function( msg ) {
 						console.log(msg);
 						$(".glyphicon-shopping-cart").addClass('transition');
 				        $(".badge").html(msg);
 				        call();
 					});
 			 	
 			 });
 		   
 	});
 	
 	function getFilters() {         
 	    var mealPref = "";
 	    var mealType = "";
 	   	var dineIn = 0;
 	    
 	    var temp = $("#tags").val();
 	    var length1 = temp.length;

 	    if(temp.charAt(length1-2) == ","){
 	    	mealPref = temp.slice(0, temp.length-2);
 	    }else{
 	    	mealPref = temp;
 	    }
 	    
/*  	    if($('#dineIn').is(":checked")){
 	    	dineIn = 1;
 	    } */
 	    
 	  	//var lRange =  $( "#slider-range" ).slider( "values", 0 );
	    //var hRange = $( "#slider-range" ).slider( "values", 1 );
 	    
 	    var temp = $("#cTags").val();
 	    var length1 = temp.length;

 	    if(temp.charAt(length1-2) == ","){
 	    	mealType = temp.slice(0, temp.length-2);
 	    }else{
 	    	mealType = temp;
 	    }
 	    
 	    console.log(mealPref+" == "+mealType);
 	    
 	    getDishes(mealPref,mealType);
 	 }
 	
 	function getDishes(mealPref, mealType){
 		var currRest = 0;
 		console.log(mealPref+"==================>"+currRest)
 		$.ajax({
 		  	method: "POST",
 		  	url: "ActionServlet",
 		  	data: { action: "menuFilter", mealPref : mealPref, mealType : mealType, restId : currRest }
 		}).done(function( msg ) {
 			console.log(msg); 
 			var text = "";
 			for(i=0;i<msg.length;i++){
 				
 				
 				text += '<div class="strip_list_menu" >';
 				text += '<div class="row">';
 				text += '<div class="col-md-12 col-sm-12">';
 				text += '<div class="desc">';
 				text += '<div class="thumb_strip">';
 				text += '<img src="images/foodPics/dish'+msg[i].dishId+'.jpg" alt="">';
 				text += '</div>';
 				text += '<h3>'+msg[i].dishName+'</h3>';
 				text += '<div class="type">'+msg[i].dishDesc+'</div>';
 	 			text += '<div class="type">'+msg[i].dishCat+'</div>';
	 			text += '<div class="type">'+msg[i].dishHealth+'</div>';
	 			text += '<h5 style="color:#67c03a;">$'+msg[i].dishFullPrice+'<span style="color:#3d4144;"> or </span>'+msg[i].dishPrice+' Points</h5>';
	 			text += '<div class="line"><h6></h6></div>';
	 			text += '</div>';
	 			text += '</div>';
 				text += '<div id="filtersMenu_col">';
 	 			text += '<a data-toggle="collapse" href="#collapseFiltersMenu'+msg[i].dishId+'" aria-expanded="true" aria-controls="collapseFiltersMenu" id="filtersMenu_col_bt" class="collapsed">More details <i class="icon-plus-1 pull-right"></i></a>';
				text += '<div class="collapse" id="collapseFiltersMenu'+msg[i].dishId+'">';
				text += '<div class="filterMenu_type">';
                text += '<h6></h6><h5>Notes:</h5>';
                text += '<div><textarea style="margin-left: 22px;" rows="4" cols="50" id="'+msg[i].dishId+'_notes"></textarea></div>';
                text += '<h6></h6>';
                text += '</div><!--End filterMenu_type -->';
	 			text += '<a href="#" dishId="'+msg[i].dishId+'" dishName="'+msg[i].dishName+'" dishP="'+msg[i].dishPrice+'" dishFP="'+msg[i].dishFullPrice+'" class="btn_full addToCart">Add</a>';
	 			text += '</div><!--End collapse -->';
	 			text += '</div><!--End filtersMenu col-->';
	 			text += '</div><!-- End row-->';
	 			text += '</div><!-- End strip_list_menu-->';
 						
 			}
 			
 			$("#dishes").html(text);
 			    
 	 		    $( ".dishDialog" ).dialog({
	 	 		      resizable: false,
	 	 		      autoOpen: false,
	 	 		      height:300,
	 	 		      width:800,
	 	 		      modal: true
	 	 		 }); 
 			    
 		});
 		
 	}
 	
 	
 	  $(function() {
 		    var availableTags = [
"Vegetarian",
"Fruitarian",
"Vegan",
"Flexitarian",
"Pescetarian",
"Plant-based",
"Weight control",
"Body for Life",
"Low carbohydrate",
"Low fat",
"Belief-based",
"High-protein",
"Halal",
"Kosher",
"Gluten free"
 		    ];
 		    
 		    var categories = [
"Mexican Food",
"Swedish Food",
"Latvian Food",
"Italian Food",
"Spanish Food",
"American Food",
"Scottish Food",
"British Food",
"Thai Food",
"Japanese Food",
"Chinese Food",
"Indian Food",
"Canadian Food",
"Russian Food",
"Jewish Food",
"Polish Food",
"German Food",
"French Food",
"Hawaiian Food",
"Brazilian Food",
"Peruvian Food",
"Salvadorian Food",
"Cuban Food",
"Tibetan Food",
"Egyptian Food",
"Greek Food",
"Belgian Foods",
"Irish Food",
"Welsh Food",
"Mormon Food",
"Cajun Food",
"Portuguese Food",
"Turkish Food",
"Haitian Food",
"Tahitian Food",
"Kenyan Food",
"Korean Food",
"Algerian Food",
"Nigerian Food",
"Libyan Food"
 		    ]; 
 		    
 		    function split( val ) {
 		      return val.split( /,\s*/ );
 		    }
 		    function extractLast( term ) {
 		      return split( term ).pop();
 		    }
 		 
 		     $( "#tags" )
 		      // don't navigate away from the field on tab when selecting an item
 		      .bind( "keydown", function( event ) {
 		        if ( event.keyCode === $.ui.keyCode.TAB &&
 		            $( this ).autocomplete( "instance" ).menu.active ) {
 		          event.preventDefault();
 		        }
 		      })
 		      .autocomplete({
 		        minLength: 0,
 		        source: function( request, response ) {
 		          // delegate back to autocomplete, but extract the last term
 		          response( $.ui.autocomplete.filter(
 		            availableTags, extractLast( request.term ) ) );
 		        },
 		        focus: function() {
 		          // prevent value inserted on focus
 		          return false;
 		        },
 		        select: function( event, ui ) {
 		          var terms = split( this.value );
 		          // remove the current input
 		          terms.pop();
 		          // add the selected item
 		          terms.push( ui.item.value );
 		          // add placeholder to get the comma-and-space at the end
 		          terms.push( "" );
 		          this.value = terms.join( ", " );
 		          return false;
 		        }
 		      });
 		    
 		    
 		    $( "#cTags" )
		      // don't navigate away from the field on tab when selecting an item
		      .bind( "keydown", function( event ) {
		        if ( event.keyCode === $.ui.keyCode.TAB &&
		            $( this ).autocomplete( "instance" ).menu.active ) {
		          event.preventDefault();
		        }
		      })
		      .autocomplete({
		        minLength: 0,
		        source: function( request, response ) {
		          // delegate back to autocomplete, but extract the last term
		          response( $.ui.autocomplete.filter(
		        		  categories, extractLast( request.term ) ) );
		        },
		        focus: function() {
		          // prevent value inserted on focus
		          return false;
		        },
		        select: function( event, ui ) {
		          var terms = split( this.value );
		          // remove the current input
		          terms.pop();
		          // add the selected item
		          terms.push( ui.item.value );
		          // add placeholder to get the comma-and-space at the end
		          terms.push( "" );
		          this.value = terms.join( ", " );
		          return false;
		        }
		      });
 		    
/*  		    $( "#slider-range" ).slider({
 	 		      range: true,
 	 		      min: 0,
 	 		      max: 20,
 	 		      values: [ 2, 10 ],
 	 		      slide: function( event, ui ) {
 	 		        $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
 	 		      }
 	 		    });
 	 		    $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
 	 		      " - $" + $( "#slider-range" ).slider( "values", 1 ) );  */
 		    
 		    
/*   	 		  $(function() {
 	 		    $( ".dishDialog" ).dialog({
 	 		      resizable: false,
 	 		      autoOpen: false,
 	 		      height:300,
 	 		      width:800,
 	 		      modal: true
 	 		    });
 	 		  });   */
 	 		  
  	 		 $('body').on('click', '.openDialog', function() {
	 			var dishId = $(this).attr("dishId");
	 			$( "#dialogDesc_"+dishId ).dialog( "open" );	 			
	 		});
  	 		
 		  });
 	  
 	  function openDialog(ele){
			var dishId = $(ele).attr("dishId");
			alert(dishId)
 			$( "#dialogDesc_"+dishId ).dialog( "open" ); 
 	  }
</script>
</body>
</html>