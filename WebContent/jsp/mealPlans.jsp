<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Cart"%>
<%@ page import="com.mooplans.model.Order"%>
<!DOCTYPE html>
<!--[if IE 9]><html class="ie ie9"> <![endif]-->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="pizza, delivery food, fast food, sushi, take away, chinese, italian food">
    <meta name="description" content="">
    
    <title>Moo Plans - Packages</title>
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
                    <li><a class="active" href="#">Meal Plans</a></li>
                    <li><a href="#"  id="logout">Logout</a></li>
                </ul>
            </div><!-- End main-menu -->
            </nav>
        </div><!-- End row -->
        
    </div><!-- End container -->
    </header>
    <!-- End Header =============================================== -->





<!-- Content ================================================== -->
 <div class="container margin_60">
      <div class="container margin_60">
        
        <div class="main_title">
           <h2 class="nomargin_top">Available Packages</h2>
            
        </div>
        
        
        <div class="row">
            
            
            
            <div class="col-md-12">
       
       	 
         <div class="panel-group" id="payment">
                  <div class="panel panel-default">
                    <div class="panel-heading">
                      <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse"  data-parent="#payment" href="#collapseOne">Weekly Reoccurring<i class="indicator icon_plus_alt2 pull-right"></i></a>
                      </h4>
                    </div>
                    <div id="collapseOne" class="panel-collapse collapse" >
                      <div class="panel-body" >
                        These are  great little packages to try out Moo Plans! Our service is great for a break between classes, or an easy chef-made dinner two or three times per week. You can order and schedule ahead for delivery, or dine-in at the restaurant. Order any time (even holidays) and even can use your meals whenever you want.<h6></h6>


                           <div class="row">
            	
                               <div class="col-md-3 col-sm-3 " >
                	<a class="strip_list grid" href="addPoints.jsp?pay=36" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/36Weekly.png" alt="">
							</div>
	
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-4-->
            
            
               <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=60" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/60weekly.png" alt="">
							</div>
							
							
						</div>
                    </a><!-- End strip_list-->
                   
                </div><!-- End col-md-4-->   
            
            <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=84" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/84weekly.png" alt="">
							</div>
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
                               
                               <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=108" data-target="#package">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/108weekly.png" alt="">
							</div>
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
            </div><!-- End row-->
        <div class="row">
     <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=132" data-target="#package">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/132weekly.png" alt="">
							</div>
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
                               
                               <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=156" data-target="#package">
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/156weekly.png" alt="">
							</div>
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
            </div><!-- End row-->
        
        
                      </div>
                    </div>
                  </div>
                  <div class="panel panel-default">
                    <div class="panel-heading">
                      <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#payment" href="#collapseTwo">Monthly Reoccurring<i class="indicator icon_plus_alt2 pull-right"></i></a>
                      </h4>
                    </div>
                    <div id="collapseTwo" class="panel-collapse collapse">
                         <div class="panel-body">
                      These are  great packages to try out Moo Plans! Our service is great for a break between classes, or an easy chef-made dinner two or three times per week. You can order and schedule ahead for delivery, or dine-in at the restaurant. Order any time (even holidays) and even can use your meals whenever you want.<h6></h6>


                           <div class="row">
            	
                               <div class="col-md-3 col-sm-3 " >
                	<a class="strip_list grid" href="addPoints.jsp?pay=160" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/160monthly.png" alt="">
							</div>
	
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-4-->
            
            
               <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=320" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/320monthly.png" alt="">
							</div>
							
							
						</div>
                    </a><!-- End strip_list-->
                   
                </div><!-- End col-md-4-->   
            
            <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=479" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/479monthly.png" alt="">
							</div>
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
                
                  <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=639" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/639monthly.png" alt="">
							</div>
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
            </div><!-- End row-->
            
        <div class="row">
     <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=798" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/798mothly.png" alt="">
							</div>
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
                               
                               <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=958" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/958monthly.png" alt="">
							</div>
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
            </div><!-- End row-->
                      </div>
                    </div>
                  </div>
                  <div class="panel panel-default">
                    <div class="panel-heading">
                      <h4 class="panel-title">
                        <a class="accordion-toggle" data-toggle="collapse" data-parent="#payment" href="#collapseThree">Semesterly Reoccurring<i class="indicator icon_plus_alt2 pull-right"></i></a>
                      </h4>
                    </div>
                    <div id="collapseThree" class="panel-collapse collapse">
                      <div class="panel-body">
                      These are  great  packages to try out Moo Plans! Our service is great for a break between classes, or an easy chef-made dinner two or three times per week. You can order and schedule ahead for delivery, or dine-in at the restaurant. Order any time (even holidays) and even can use your meals whenever you want.<h6></h6>


                           <div class="row">
            	
                               <div class="col-md-3 col-sm-3 " >
                	<a class="strip_list grid" href="addPoints.jsp?pay=1296" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/1296semesterly.png" alt="">
							</div>
	<h6>Compare to UAlbany at : $2,000</h6>
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-4-->
            
            
               <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=1890" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/1890semesterly.png" alt="">
							</div>
							
							<h6>Compare to UAlbany at : $2,405</h6>
						</div>
                    </a><!-- End strip_list-->
                   
                </div><!-- End col-md-4-->   
            
            <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=2484" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/2484semesterly.png" alt="">
							</div>
							
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
                               
                               <div class="col-md-3 col-sm-3" >
                	<a class="strip_list grid" href="addPoints.jsp?pay=3078" >
                    	<div class="ribbon_1">Popular</div>
                    	<div class="desc">
							<div class="thumb_strip">
								<img src="../img/3078semesterly.png" alt="">
							</div>
							
						</div>
                    </a><!-- End strip_list-->
                </div><!-- End col-md-6-->
            </div><!-- End row-->
                      </div>
                    </div>
                  </div>
                </div><!-- End panel-group -->
                
               
                
         
        </div><!-- End col-md-12 -->
            
            
            
            
            
          </div>
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            

        </div><!-- End container -->
</div><!-- End container -->
<!-- End Content =============================================== -->

<!-- Footer ================================================== -->
	<footer>
        <div class="container">
            <div class="row">
                <div class="col-md-4 col-sm-3">
                  	<h3>Secure payments with</h3>
                    <p><img src="../img/cards.png" alt="" class="img-responsive"></p>
                    
                </div>
                <div class="col-md-3 col-sm-3">
                    <h3>About</h3>
                    <ul>
                        <li><a href="about.html">About us</a></li>
                        <li><a href="faq.html">Faq</a></li>
                         <li><a href="contacts.html">Contacts</a></li>
                        <li><a href="#0">Terms and conditions</a></li>
                    </ul>
                </div>
                <div class="col-md-3 col-sm-3"  id="newsletter">
                    <h3>Newsletter</h3>
                    <p>Join our newsletter to keep be informed about offers and news.</p>
					<div id="message-newsletter_2"></div>
						<form method="post" action="assets/newsletter.php" name="newsletter_2" id="newsletter_2">
                        <div class="form-group">
                            <input name="email_newsletter_2" id="email_newsletter_2"  type="email" value=""  placeholder="Your mail" class="form-control">
                          </div>
                            <input type="submit" value="Subscribe" class="btn_1" id="submit-newsletter_2">
                    	</form>
                </div>
                <div class="col-md-2 col-sm-3">
                    <h3>Settings</h3>
                    <div class="styled-select">
                        <select class="form-control" name="lang" id="lang">
                            <option value="English" selected>English</option>
                            <option value="French">French</option>
                            <option value="Spanish">Spanish</option>
                            <option value="Russian">Russian</option>
                        </select>
                    </div>
                    <div class="styled-select">
                        <select class="form-control" name="currency" id="currency">
                            <option value="USD" selected>USD</option>
                            <option value="EUR">EUR</option>
                            <option value="GBP">GBP</option>
                            <option value="RUB">RUB</option>
                        </select>
                    </div>
                </div>
            </div><!-- End row -->
            <div class="row">
                <div class="col-md-12">
                    <div id="social_footer">
                        <ul>
                            <li><a href="#0"><i class="icon-facebook"></i></a></li>
                            <li><a href="#0"><i class="icon-twitter"></i></a></li>
                            <li><a href="#0"><i class="icon-google"></i></a></li>
                            <li><a href="#0"><i class="icon-instagram"></i></a></li>
                            <li><a href="#0"><i class="icon-pinterest"></i></a></li>
                            <li><a href="#0"><i class="icon-vimeo"></i></a></li>
                            <li><a href="#0"><i class="icon-youtube-play"></i></a></li>
                        </ul>
                        <p>© Quick Food 2015</p>
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
				<form action="Login" name="login" method="post" class="popup-form" id="myLogin">
                	<div><img src="../img/logo_m.png" /></div>
                                        
                    <input type="hidden" id="isError" value="" />
					<input type="hidden" id="message" value="" />
					<input type="hidden" id="payL" name="pay" value="0" />
					
					<input id="author" name="email" type="email" class="form-control form-white" placeholder="Username">
					<input id="lock" type="password" name="password" class="form-control form-white" placeholder="Password">
					<div class="text-left">
						<a href="#">Forgot Password?</a>
					</div>
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
				<form class="popup-form" method="post" name="register" action="Registration" id="myRegister">
                	<div><img src="../img/logo_m.png" /></div>
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
						<!-- <div class="checkbox"> -->
							<!-- <input type="checkbox" value="accept_2" id="check_2" name="check_2" /> -->
							<label for="check_2"><a href="#" data-toggle="modal" data-target="#login_2" onclick="toggleModal()"><span>Already Registered? Please <strong>Login</strong></span></a></label>
						<!-- </div> -->
					</div>
					<button type="submit" class="btn btn-submit">Register</button>
				</form>
			</div>
		</div>
	</div><!-- End Register modal -->
    
    <!-- package modal -->   
<div class="modal fade" id="package" tabindex="-1" role="dialog" aria-labelledby="package" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content modal-popup">
				<a href="#" class="close-link"><i class="icon_close_alt2"></i></a>
				<form action="register.html" class="popup-form" id="package">
					<a href="#0" onclick="toggleModal();choosePackage(50)" data-toggle="modal" class="btn btn-submit" data-target="#register"><i class="icon-food"></i>Reserve It</a>
                    <a href="#0" onclick="toggleModal()" data-toggle="modal" class="btn btn-submit" data-target="#register"><i class="icon-wallet"></i>Order Now</a>
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

<!-- SPECIFIC SCRIPTS -->
<script src="../js/theia-sticky-sidebar.js"></script>
<script>
    jQuery('#sidebar').theiaStickySidebar({
      additionalMarginTop: 80
    });
    
    $(document).ready(function() {
		var msg = $("#dispError").html();
    	if(msg == null || msg == ""){
    		
    	}else{
    		$("#errDialog").show();
    	}

    });
    
    $( "#logout" ).click(function() {
    	  $( "#logoutForm" ).submit();
    });
</script>

</body>
</html>