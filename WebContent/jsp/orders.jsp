<%@page import="com.mooplans.model.Restaurant"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Cart" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<!--[if IE 9]><html class="ie ie9"> <![endif]-->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="pizza, delivery food, fast food, sushi, take away, chinese, italian food">
    <meta name="description" content="">
    
    <title>Moo Plans - Restaurants</title>
    <!-- Favicons-->
    <link rel="icon" type="image/png" sizes="16x16" href="../img/favicon-16x16.png">
    <link rel="apple-touch-icon" sizes="57x57" href="../img/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="72x72" href="../img/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="114x114" href="../img/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="144x144" href="../img/apple-icon-144x144.png">
    
    <!-- GOOGLE WEB FONT -->
    <link href='https://fonts.googleapis.com/css?family=Lato:400,700,900,400italic,700italic,300,300italic' rel='stylesheet' type='text/css'>

    <!-- BASE CSS -->
    <link href="../css/base.css" rel="stylesheet">
    
    <!-- Radio and check inputs -->
    <link href="../css/skins/square/grey.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">

    <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->

</head>

<body>
<%
	//allow access only if session exists	
	Cart shoppingCart = null;
	User user = null;
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
    <div class="main_title">
           <h2 class="nomargin_top">Featured Restaurants</h2>
            
        </div>
    
	<div class="row">
    
		<div class="col-md-3">
			
			<div id="filters_col">
				<a data-toggle="collapse" href="#collapseFilters" aria-expanded="true" aria-controls="collapseFilters" id="filters_col_bt">Filters <i class="icon-plus-1 pull-right"></i></a>
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
<!--                         <div class="filter_type">
                            <h5>Type</h5>
						<ul>
							<li><label><input type="checkbox" checked class="icheck">All <small>(49)</small></label></li>
							<li><label><input type="checkbox" class="icheck">American <small>(12)</small></label></li>
							<li><label><input type="checkbox" class="icheck">Chinese <small>(5)</small></label></li>
							<li><label><input type="checkbox" class="icheck">Hamburger <small>(7)</small></label></li>
							<li><label><input type="checkbox" class="icheck">Fish <small>(1)</small></label></li>
							<li><label><input type="checkbox" class="icheck">Mexican <small>(49)</small></label></li>
							<li><label><input type="checkbox" class="icheck">Pizza <small>(22)</small></label></li>
							<li><label><input type="checkbox" class="icheck">Sushi <small>(43)</small></label></li>
						</ul>
					</div>
                    <div class="filter_type">
						<h5>Rating</h5>
						<ul>
							<li><label><input type="checkbox" class="icheck"><span class="rating">
							<i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star voted"></i>
							</span></label></li>
							<li><label><input type="checkbox" class="icheck"><span class="rating">
							<i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star"></i>
							</span></label></li>
							<li><label><input type="checkbox" class="icheck"><span class="rating">
							<i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star"></i><i class="icon_star"></i>
							</span></label></li>
							<li><label><input type="checkbox" class="icheck"><span class="rating">
							<i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star"></i><i class="icon_star"></i><i class="icon_star"></i>
							</span></label></li>
							<li><label><input type="checkbox" class="icheck"><span class="rating">
							<i class="icon_star voted"></i><i class="icon_star"></i><i class="icon_star"></i><i class="icon_star"></i><i class="icon_star"></i>
							</span></label></li>
						</ul>
					</div>
                    <div class="filter_type">
						<h5>Options</h5>
						<ul class="nomargin">
							<li><label><input type="checkbox" class="icheck">Delivery</label></li>
							<li><label><input type="checkbox" class="icheck">Take Away</label></li>
							<li><label><input type="checkbox" class="icheck">Dine In</label></li>
						</ul>
					</div> -->
					<!--	<div class="checkbox-holder1 text-left">
						<div class="checkbox1">
							<input type="checkbox" value="accept_2" id="check_2" name="check_2" />
                            <label for="check_2"><span>Dine In</span></label>
						
					</div>-->
					<h6></h6>
				<a class="btn_full" onclick="getFilters()">Add Filter </a>
                    
				</div><!--End collapse -->
			</div><!--End filters col-->
		</div><!--End col-md -->
        
		<div class="col-md-9" id="restaurants">

		</div><!-- End col-md-9-->
        
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
                    <img src="../img/cards.png" alt="" class="img-responsive">
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
<script src="../js/jquery-ui.js"></script>

<!-- SPECIFIC SCRIPTS -->
<script src="../js/theia-sticky-sidebar.js"></script>
<script>
    jQuery('#sidebar').theiaStickySidebar({
      additionalMarginTop: 80
    });
    
    
    $( "#logout" ).click(function() {
  	  $( "#logoutForm" ).submit();
  });

  function getRestaurants(mealPref, mealType){
  	console.log(mealPref+"==================>")
  	$.ajax({
  	  	method: "POST",
  	  	url: "../ActionServlet",
  	  	data: { action: "restPage", mealPref : mealPref, mealType : mealType }
  	}).done(function( msg ) {
  		console.log(msg); 
   		var text = "";
  		text += '<form method="post" id="ordersForm" name="formName" action="../ActionServlet?action=menuPage">';
  		for(i=0;i<msg.length;i++){
  			
  			
  			text += '<div class="strip_list" >';
  			text += '<div class="row">';
  			text += '<div class="col-md-9 col-sm-9">';
  			text += '<div class="desc">';
  			text += '<div class="thumb_strip">';
  			text += '<img src="'+msg[i].restImage+'" alt="">';
  			text += '</div>';
  			text += '<div class="rating">';
  			text += '<i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star voted"></i><i class="icon_star"></i>';
  			text += '</div>';
  			text += '<h3>'+msg[i].restName+'</h3>';
  			text += '<div class="type">'+msg[i].restHealth+'</div>';
  			text += '<div class="location">Popular for: '+msg[i].restMealType+'</div>';
  			text += '<ul>';
  			text += '<li>Open<i class="icon-clock ok"></i></li>';
  			text += '</ul>';
  			text += '</div>';
  			text += '</div>';
  			text += '<div class="col-md-3 col-sm-3">';
  			text += '<div class="go_to">';
  			text += '<div>';
  			text += '<a restId="'+msg[i].restId+'" href="#" class="btn_1 restImages">View Menu</a>';
  			text += '</div></div></div></div></div>';
  			
  			
/*   			text += '<div class="col-xs-12 col-sm-6 col-md-3">';
  			text += '<div class="thumbnail">';
  			text += '<img class="restImages" alt="'+msg[i].restName+'" restId="'+msg[i].restId+'" src="../images/restLogos/'+msg[i].restName+'.jpg" />';
  			text += '<div class="caption">';
  			text += '<h3>'+msg[i].restName+'</h3>';
  			text += '<p>'+msg[i].restHealth+'</p>';
  			text += '<p>Popular for: '+msg[i].restMealType+'</p>';
  			text += '</div>';
  			text += '</div>';
  			text += '</div>';		 */		
  			
  		}
  		
  		if(msg.length==0){
  			text += '<div class="strip_list" >';
  			text += '<h3> Sorry we are closed for today.. Please check back tomorrow!</h3>';
  			text += '</div>';
  		}
  		text += '</form>';
  		$("#restaurants").html(text); 
  		
   		 $(".restImages").click(function(){
  				var rest = $(this).attr("restId");
  				console.log("-->RestID-->"+rest)
  				
  			$('<input />').attr('type', 'hidden')
  			              .attr('name', 'restId')
  			              .attr('value', rest)
  			              .appendTo('#ordersForm');
  			$('#ordersForm').submit();					
  		});  
  	});
  	
  }

  $( document ).ready(function() {			
  	getRestaurants("",""); // on load without filers
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
   	    
   	    if($('#dineIn').is(":checked")){
   	    	dineIn = 1;
   	    }
   	    	    
   	    var temp = $("#cTags").val();
   	    var length1 = temp.length;

   	    if(temp.charAt(length1-2) == ","){
   	    	mealType = temp.slice(0, temp.length-2);
   	    }else{
   	    	mealType = temp;
   	    }
   	    
   	    console.log(mealPref+" == "+mealType+ " == "+dineIn);
   	    
   	   getRestaurants(mealPref,mealType);
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
  		    
  	  });
</script>

</body>
</html>