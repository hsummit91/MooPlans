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
    
    <title>Moo Plans</title>
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
    
    <!-- Modernizr -->
	<script src="js/modernizr.js"></script> 
    
    <!-- Back to top -->
    <script src="js/top.js"></script>
    <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->

</head>

<body onload="onLoad()">
<%
		String valid = request.getParameter("errorMsg");
		String isError = request.getParameter("isError");
		if (valid == null){
			valid = "";
		}
		if(isError == null){
			isError = "";
		}
		String pay = "";
		try{
			pay = request.getParameter("pay");			
		}catch(Exception e){
			
		}
		if(pay == null){
			pay = "0";
		}
		System.out.println("Login|====>"+pay+"<====|");
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
    <header>
    <div class="container-fluid">
        <div class="row">
            <div class="col--md-4 col-sm-4 col-xs-4">
                <a href="index.html" id="logo">
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
                    
                    <li><a href="#0" data-toggle="modal" data-target="#login_2">Login</a></li>
                    <li><a href="#0" data-toggle="modal" data-target="#register">Register</a></li>
                    <li><a href="#">Blog</a></li>
                    <li><a href="#">Newsletter</a></li>
                    <li><a href="#">Pricing</a></li>
                    <li><a href="#">Order Now</a></li>
                </ul>
            </div><!-- End main-menu -->
            </nav>
        </div><!-- End row -->
    </div><!-- End container -->
    </header>
	<!-- End Header =============================================== -->
    
    <!-- SubHeader =============================================== -->
    <section class="header-video">
    <div id="hero_video">
        <div id="sub_content">
            
            <h1>A Meal Plan from local restaurants</h1>
            <p>
                Convenient and quick meals delivered directly to you
            </p>
            <p>
                !! Website Under Construction !!
            </p>
            <a class="btn_1" href="#">Order Now </a>
            
        </div><!-- End sub_content -->
    </div>
        
    <img src="img/video_fix.png" alt="" class="header-video--media" data-video-src="video/intro" data-teaser-source="video/intro" data-provider="Vimeo" data-video-width="1920" data-video-height="1010">
   
        
        
        <div id="count" class="hidden-xs">
        
            <div >
			<img src="img/scroll.png" alt="">
		      </div>
            
    </div>
    </section><!-- End Header video -->
    <!-- End SubHeader ============================================ -->
    
   <!-- Content ================================================== -->
    <!-- Start container -->
   <div class="container margin_60_35">
	<div class="row">
		<div class="col-md-4">
			<h2 class="nomargin_top" style="color:#e84b60;">Order food with our app</h2>
			<p>Individually cooked meals from local chefs</p>
			
			<h4 style="color:#e84b60;">SEARCH</h4>
			<p>
				Enter your address and MooPlans will display the menu/pre-saved menu choices. We make it simple to find the food you're craving. Just search....
			</p>
			<h4 style="color:#e84b60;">BROWSE</h4>
            <p>
				 Choose your meals, drinks from our menu/pre-saved menu and earn rewards in terms free meals. You can also schedule your delivery for future dates. Isn't its exciting on very easy clicks.
			</p>
			<h4 style="color:#e84b60;">EAT</h4>
            <p>
				 Enjoy your yummy meals and enjoy rewards in terms of free meals.
			</p>
            <a href="#"><img src="img/app_store.png" alt="" class="img-responsive" style="height:70%;"></a>
            
		</div>
		<div class="col-md-7 col-md-offset-1 text-right">
			<img src="img/devices.jpg" alt="" class="img-responsive">
		</div>
        
	</div><!-- End row -->
</div><!-- End container -->
    
    
     <div class="high_light">
      	<div class="container">
      		
            
            <div class="main_title">
            <h3 class="nomargin_top" style="color:#ffffff;">Why we are better</h3>
            
        </div>
	<div class="row">
		<div class="col-md-6">
			<div class="feature">
                
                <img class="features-img" src="img/meal.png"  alt="">
				
				<h2 style="color:#000000; font-size:24px; ">All unused meals roll-over after the semester ends.</h2>
				
			</div>
		</div>
		<div class="col-md-6">
			<div class="feature">
				<img class="features-img" src="img/time.png"  alt="">
				<h2 style="color:#000000; font-size:24px;">We are open on holidays, nights and weekends.</h2>
				
			</div>
		</div>
	</div><!-- End row -->
	<div class="row">
		<div class="col-md-6">
			<div class="feature">
				<img class="features-img" src="img/chef.png"  alt="">
				<h2 style="color:#000000; font-size:24px; ">Individually cooked meals from local chefs.</h2>
				
			</div>
		</div>
		<div class="col-md-6">
			<div class="feature">
				<img class="features-img" src="img/refill.png" alt="">
				<h2 style="color:#000000; font-size:24px; ">Refill your plan at any time. You're not locked in.</h2>
				
			</div>
		</div>
	</div><!-- End row -->
	<div class="row">
		<div class="col-md-6">
			<div class="feature">
				<img class="features-img" src="img/student.png" alt="">
				<h2 style="color:#000000; font-size:24px; ">Enjoy college with the best meal plan around.</h2>
				
			</div>
		</div>
		<div class="col-md-6">
			<div class="feature">
				<img class="features-img" src="img/free.png"  alt="">
				<h2 style="color:#000000; font-size:24px;">Free delivery always. Tipping not required!</h2>
				
			</div>
		</div>
	</div><!-- End row -->
            
            
            
        </div><!-- End container -->
      </div><!-- End hight_light -->
    
    
    
     
    
    <div class="container margin_60">
        
         <div class="main_title">
            <h2 class="nomargin_top" style="padding-top:0">How it works</h2>
             <h3 style="padding:0; margin:0;">"Ask not what you can do for you country...</h3>
             <h3 style="font-weight:bold; color:#e84b60; padding:0; margin:0;"> Ask what's for lunch!"</h3>
            
        </div>
        <div class="row">
            <div class="col-md-3">
                <div class="box_home" id="one">
                    <span>1</span>
                    <h3 style="font-weight:bold; color:#e84b60;">Search by campus</h3>
                    <p>
                        Find all restaurants available near your campus.
                    </p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="box_home" id="two">
                    <span>2</span>
                    <h3 style="font-weight:bold; color:#e84b60;">Choose a restaurant</h3>
                    <p>
                        We have more than 1000s of menus online.
                    </p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="box_home" id="three">
                    <span>3</span>
                    <h3 style="font-weight:bold; color:#e84b60;">Pay by card or cash</h3>
                    <p>
                        It's quick, easy and totally secure.
                    </p>
                </div>
            </div>
            <div class="col-md-3">
                <div class="box_home" id="four">
                    <span>4</span>
                    <h3 style="font-weight:bold; color:#e84b60;">Delivery or takeaway</h3>
                    <p>
                        Meals are delivered to your location for free
                    </p>
                </div>
            </div>
        </div><!-- End row -->
        
        <div id="delivery_time" class="hidden-xs">
            <strong><span>2</span><span>2</span></strong>
            <h4 style="font-weight:bold; color:#e84b60;">The minutes that usually takes to deliver!</h4>
        </div>
        </div><!-- End container -->
    
      <section class="parallax-window" data-parallax="scroll" data-image-src="img/food_campus.png" data-natural-width="1200" data-natural-height="600">
    <div class="parallax-content">
        <div class="sub_content">
            <img src="img/logo_m.png" />
            <h3 style=" font-weight:bold;">We also deliver it with care</h3>
            <h4 style=" color:#ffffff;">
                Student life can open up a whole new world of friends and experiences. Life gets busy. We created Moo Plans so you can have a lifestyle and a life with heavenly food at your place.. So you can eat well and still have time for the things you love like hanging with friends and family. Check out our menu, select an option that suits you and we’ll get it right over to you, hot and ready to eat.
            </h4>
        </div><!-- End sub_content -->
    </div><!-- End subheader -->
    </section><!-- End section -->
            
     <div class="white_bg">
    <div class="container margin_60">
        
        <div class="main_title">
           <h2 class="nomargin_top">Choose from pakages</h2>
            
        </div>
        
        
        <div class="row">
            	<div class="col-md-4 col-sm-4 " >
                	<a class="strip_list_package grid" href="packages.html">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc_package">
							<div class="thumb_strip_package">
								<img src="img/weekly.png" alt="">
							</div>
                            
							<!--
							<h4>Mini Package - 1</h4>
                            <h3>$35 per week</h3>
                            <div  class="the-icons "><i class="icon-coffee "></i><i class="icon-beer"></i> 6 Snacks OR <i class="icon-food ok"></i>3 Meals</div>  <a href="#0" data-toggle="modal" data-target="#login_2">Login</a>
						-->	
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-4-->
            
            
             <div class="col-md-4 col-sm-4 " >
                	<a class="strip_list_package grid" href="packages.html">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc_package">
							<div class="thumb_strip_package">
								<img src="img/monthly.png" alt="">
							</div>
							<!--
							<h4>Mini Package - 1</h4>
                            <h3>$35 per week</h3>
                            <div  class="the-icons "><i class="icon-coffee "></i><i class="icon-beer"></i> 6 Snacks OR <i class="icon-food ok"></i>3 Meals</div>
						-->	
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-4-->   
            
     <div class="col-md-4 col-sm-4 " >
                	<a class="strip_list_package grid" href="packages.html">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc_package">
							<div class="thumb_strip_package">
								<img src="img/semesterly.png" alt="">
							</div>
							<!--
							<h4>Mini Package - 1</h4>
                            <h3>$35 per week</h3>
                            <div  class="the-icons "><i class="icon-coffee "></i><i class="icon-beer"></i> 6 Snacks OR <i class="icon-food ok"></i>3 Meals</div>
						-->	
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-4-->
            </div><!-- End row-->
        
   
        
        
        
        <!--
            <a class="btn_full" href="#">Don't see one for you? Make yours: Just click  </a> 
        
    -->
        
        </div><!-- End container -->
        </div><!-- End white_bg -->
        
       <div class="high_light">
      	<div class="container">
      		<h3>Choose from over 3,000 Restaurants</h3>
            <p>Individually cooked meals from local chefs</p>
            <a href="#">View all Restaurants</a>
        </div><!-- End container -->
      </div><!-- End hight_light -->
            
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
			
			    <div id="errDialog" style="display:none" class="alert alert-danger" role="alert">
			  	<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
			  	<span class="sr-only">Error:</span>
			  	Something went wrong.. please try again
				</div>
			
				<a href="#" class="close-link"><i class="icon_close_alt2"></i></a>
				<form action="Login" name="login" method="post" class="popup-form" id="myLogin">
                	<div><img src="img/logo_m.png" /></div>
                    
					<input id="author" name="email" type="email" class="form-control form-white" placeholder="Username">
					<input id="lock" name="password" type="password" class="form-control form-white" placeholder="Password">

					<input type="hidden" id="message" value="" />
					<input type="hidden" name="pay" id="payL" value="0" />
					<div class="text-left">
						<a href="#">Forgot Password?</a>
					</div>
					<input type="hidden" id="isError" value="<%=isError %>" />
					<button type="submit" class="btn btn-submit">Sign in</button>
				</form>
			</div>
		</div>
	</div><!-- End modal -->   
    
<!-- Register modal -->   
<div class="modal fade" id="register" tabindex="-1" role="dialog" aria-labelledby="myRegister" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content modal-popup">
				<a href="#" class="close-link"><i class="icon_close_alt2"></i></a>
				<form action="#" class="popup-form" id="myRegister">
                	<div><img src="img/logo_m.png" /></div>
                	<input id="author" type="text" name="firstname" class="form-control form-white" placeholder="Name" required>
                	<input id="author" type="text" maxlength="10" name="phone" title="1234567890" pattern="\d{10}" class="form-control form-white" placeholder="Phone" required>
					<input id="author" type="text" name="email" class="form-control form-white" placeholder="Email" required>
					<input id="lock" name="password" type="password" class="form-control form-white" placeholder="Password" required>
                    <select class="form-control form-white" name="university" required="required">
								<option selected="selected" value="Campus Center">University at Albany: Campus Center</option>
								<option value="Dutch Quad">Dutch Quad</option>
								<option value="Colonial Quad">Colonial Quad</option>
								<option value="State Quad">State Quad</option>
								<option value="Indian Quad">Indian Quad</option>
								<option value="Freedom Apartments">Freedom Apartments</option>
								<option value="Liberty Terrace Apartments">Liberty Terrace Apartments</option>
								<option value="Empire Commons">Empire Commons</option>
								<option value="Alumni (Bus Stop)">Alumni (Bus Stop)</option>
					</select>
                    <input type="hidden" id="isError" value="" />
					<input type="hidden" id="message" value="" />
					<input type="hidden" id="pay" name="pay" value="0" />
					
                    <div id="pass-info" class="clearfix"></div>
					<div class="checkbox-holder text-left">
						<div class="checkbox">
							<input type="checkbox" value="accept_2" id="check_2" name="check_2" />
							<label for="check_2"><span>I Agree to the <a href="#"> <strong>Terms &amp; Conditions</strong></a></span></label>
						</div>
					</div>
					<button type="submit" class="btn btn-submit">Register</button>
				</form>
			</div>
		</div>
	</div><!-- End Register modal -->
    
    <!-- weekly packages-->   
<div class="modal fade" id="weekly" tabindex="-1" role="dialog" aria-labelledby="weekly" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content modal-popup">
				<a href="#" class="close-link"><i class="icon_close_alt2"></i></a>
				<!-- Content ================================================== -->
 <div class="container margin_60">
      <div class="container margin_60">
        
        <div class="main_title">
           <h2 class="nomargin_top">Available Plans</h2>
            
        </div>
        
        
        <div class="row">
            	<div class="col-md-4 col-sm-4 " >
                	<a class="strip_list grid" href="package1.html">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="img/package1.png" alt="">
							</div>
							
							<h4>Mini Package - 1</h4>
                            <h3>$35 per week</h3>
                            <div  class="the-icons "><i class="icon-coffee "></i><i class="icon-beer"></i> 6 Snacks OR <i class="icon-food ok"></i>3 Meals</div>
							
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-4-->
            
            
               <div class="col-md-4 col-sm-4" >
                	<a class="strip_list grid" href="package2.html">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="img/package2.png" alt="">
							</div>
							
							<h4>Mini Package - 2</h4>
							<h3>$55 per week</h3>
							<div  class="the-icons "><i class="icon-coffee ok"></i><i class="icon-beer"></i> 10 Snacks OR <i class="icon-food ok"></i>5 Meals</div>
							
						</div>
                    </a><!-- End strip_list-->
                   
                </div><!-- End col-md-4-->   
            
            <div class="col-md-4 col-sm-4" >
                	<a class="strip_list grid" href="package3.html">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="img/package3.png" alt="">
							</div>
							
							<h4>Snack Package - 3</h4>
                            <h3>$150 per month</h3>
                            <div  class="the-icons "><i class="icon-coffee "></i><i class="icon-beer"></i> 28 Snacks OR <i class="icon-food ok"></i>14 Meals</div>
							
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
            </div><!-- End row-->
        
   
        
         <div class="row">
                  <div class="col-md-4 col-sm-4" >
                	<a class="strip_list grid" href="package4.html">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="img/package4.png" alt="">
							</div>
							
							<h4>Basic Package - 4</h4>
							<h3>$400 per month</h3>
							<div  class="the-icons "><i class="icon-coffee ok"></i><i class="icon-beer"></i> 74 Snacks OR <i class="icon-food ok"></i>37 Meals</div>
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-4--> 
             
             
            	<div class="col-md-4 col-sm-4">
                	<a class="strip_list grid" href="package5.html">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="img/package5.png" alt="">
							</div>
							
							<h4>Commuter Package - 5</h4>
                            <h3>$1600 per semester</h3>
                            <div  class="the-icons "><i class="icon-coffee "></i><i class="icon-beer"></i> 240 Snacks OR <i class="icon-food ok"></i>120 Meals</div>
							
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-4-->
               <div class="col-md-4 col-sm-4">
                	<a class="strip_list grid" href="package6.html">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="img/package6.png" alt="">
							</div>
							
							<h4>Resident Package - 6</h4>
							<h3>$1900 per semester</h3>
							<div  class="the-icons "><i class="icon-coffee ok"></i><i class="icon-beer"></i> 350 Snacks OR <i class="icon-food ok"></i>175 Meals</div>
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-4-->                
            </div><!-- End row-->

        </div><!-- End container -->
</div><!-- End container -->
<!-- End Content =============================================== -->
			</div>
		</div>
	</div><!-- End modal --> 
    
<!-- COMMON SCRIPTS -->
<script src="js/jquery-1.11.2.min.js"></script>
<script src="js/common_scripts_min.js"></script>
<script src="js/functions.js"></script>
<script src="assets/validate.js"></script>

<!-- SPECIFIC SCRIPTS -->
<script src="js/video_header.js"></script>
<script>
$(document).ready(function() {
	'use strict';
   	  HeaderVideo.init({
      container: $('.header-video'),
      header: $('.header-video--media'),
      videoTrigger: $("#video-trigger"),
      autoPlayVideo: true
    });    

});
</script>

    
<!-- create the back to top button -->  
<script type="text/javascript">

$('body').prepend('<a href="#" class="back-to-top">Back to Top</a>');

var amountScrolled = 300;

$(window).scroll(function() {
	if ( $(window).scrollTop() > amountScrolled ) {
		$('a.back-to-top').fadeIn('fast');
	} else {
		$('a.back-to-top').fadeOut('fast');
	}
});

$('a.back-to-top, a.simple-back-to-top').click(function() {
	$('html, body').animate({
		scrollTop: 0
	}, 700);
	return false;
});

function onLoad(){
	$("#errDialog").hide();
	var pay = sessionStorage.getItem("amount");
	if(pay == null){
		pay = 0;
	}
	$("#pay").val(pay);
	$("#payL").val(pay);
	
	var error = $("#isError").val();
	if(error == "true"){
		$("#errDialog").show();
		$('#login_2').modal('show');
	}
}

</script>    
    
</body>
</html>