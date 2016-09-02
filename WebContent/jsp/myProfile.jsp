<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Image"%>
<!DOCTYPE html>
<!--[if IE 9]><html class="ie ie9"> <![endif]-->
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="keywords" content="pizza, delivery food, fast food, sushi, take away, chinese, italian food">
    <meta name="description" content="">
    
    <title>Moo Plans - Store Home</title>
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
    <link href="../css/ion.rangeSlider.css" rel="stylesheet">
    <link href="../css/ion.rangeSlider.skinFlat.css" rel="stylesheet" >

    <!--[if lt IE 9]>
      <script src="js/html5shiv.min.js"></script>
      <script src="js/respond.min.js"></script>
    <![endif]-->

</head>

<body onload="getUserDetails()">
	<%
		//allow access only if session exists
	User user = null;
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("login.jsp");
	}else {
		user = (User) session.getAttribute("User");
	}%>
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
                    <li><a href="#" class="active">Account</a></li>
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

    <div class="container margin_120 content_bg">
 
    
	<div class="row">
			
        
		<div class="col-md-offset-2 col-md-8">
            
            <div class="box_style_2 info">
                <h2 class="inner" style="text-align:center;">Convenient & quick meals delivered directly to you</h2>
                
                <div class="strip_list" style="margin-bottom:5px;">
				
				<div class="row">
					<div class="col-md-7 col-sm-7">
						<div class="desc">
							<div class="thumb_strip" style="border:0px solid #ededed;">
								<img id="profileImg" src="" alt="">
							</div>
							
							<h3 class="name" id="name"></h3>
							<div class="user_location" id="address">
								
							</div>
							
						
						</div>
					</div>
					<div class="col-md-5 col-sm-5">
						<div class="menu_manage">
							<div >
                                <h5>You have....</h5>
                                <h3><i class="icon-right-dir"></i><%=user.getUser_points()%> <span style="font-size:70%;">Points</span></h3>
                                <h3><a href="mealPlans.jsp">Purchase a Meal Plan</a></h3>
                                <h6></h6>
								<a href="#" data-toggle="modal" data-target="#myModal" style="font-size:20px;  text-align: center;"><i class="icon-pencil"></i>Change Profile Picture</a>
							</div>
						</div>
					</div>
				</div><!-- End row-->
			</div><!-- End strip_list-->
        
           
<!--      <div class="row" >
         <h3 style="text-align:center; color:#686e72; padding-bottom:10px;">My Momo Plan</h3>
		<div class="col-md-5 col-sm-5 " style="padding-left:80px; ">
						
			<div class="thumb_strip1" >
                <a href=""><img src="../img/scan.png" alt="" align="middle"></a>
			</div>
	   </div>
		<div class="col-md-5 col-sm-5" style="padding-left:80px; ">
			<div class="thumb_strip1" >
                <a href=""><img src="../img/rewards.png" alt="" align="middle"></a>
			</div>
		</div>
  
         </div>End row -->
                
        
	 <div class="delivery">
						<h3 style="color:#686e72;">Your Contact Info</h3>
				<h6></h6>	
         <h2><i class="icon-right-open"></i> <span id="email"></span></h2>
         <h4 id="phone"></h4>
					</div>

                  
                    <a style="font-size:18px; padding:8px 8px;" class="btn_full " href="home.jsp"> Order Now <i class="icon_wallet"></i> </a>
                
                
             
                
				</div><!-- End box_style_1 -->

			</div><!-- col-md-offset-3 col-md-6 -->
        
        
        
	</div><!-- End row -->
</div><!-- End container -->
<!-- End Content =============================================== -->

<!-- Modal -->
<div id="myModal" class="modal fade" role="dialog">
  <div class="modal-dialog">

    <!-- Modal content-->
    <div class="modal-content">
       <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        <h4 class="modal-title">Select your Avatar</h4>
      </div>
      <p>
      <div class="modal-body">
  			<%
			ArrayList<Image> img = (ArrayList<Image>) session.getAttribute("images");
			for (Image imageCodes : img) {
  			%>
  			<p>
			<div class="col-xs-6 col-md-3 foo" style="height: 150px;width: 150px;margin: 0.5em">
			<img alt="Profile Image" data-dismiss="modal" onclick="getPath(this)" id="<%=imageCodes.getImageId()%>" style="height: inherit;width: inherit;cursor: pointer;" src="<%=imageCodes.getImagePath()%>" />
		    </div></p> 
  			<%}%>	  
      </div>
      
       <div class="modal-footer">
      </div>
    </div>

  </div>
</div>

 <!-- Footer ================================================== -->
    <footer >
    <div class="container" style="background-color:#ffffff;">
        <div class="row" style="background-color:#ffffff;">
           
            <div class="col-md-2 col-sm-2" style="background-color:#ffffff;">
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
    
	$( "#logout" ).click(function() {
		  $( "#logoutForm" ).submit();
	});
	
	function getUserDetails(){				
	    $.ajax({
			  method: "POST",
			  url: "../FetchData",
			  data: { action: "getUserDetails", userId: "<%=user.getUser_id()%>"  }
			}).done(function( msg ) {
				  sessionStorage.setItem("myProfilPoints", msg.points);
				  console.log(msg.firstName);
				  var lastName = "";
				  if(msg.lastName != undefined){
					  lastName = msg.lastName;
				  }
				  $("#name").html(msg.firstName + " " + lastName);
				  $("#points").html(msg.points);
				  $("#email").html(msg.email);
				  $("#phone").html(msg.phone);
				  $("#address").html(msg.address);
				  $("#university").html(msg.university);
				  $("#profileImg").attr("src",msg.image);
				  
				 // window.parent.updatePoints();
			});    
	}
	
	function getPath(ele){
		var path = $(ele).attr("src");
		var imgId = $(ele).attr("id");
		$("#profileImg").attr("src",path);
		$("#imageSelector").hide();
		$(".container").show("slow");
		//console.log(imgId)
	    $.ajax({
			  method: "POST",
			  url: "../ImageUpload",
			  data: { imageId : imgId }
			}).done(function( msg ) {
				  console.log(msg);
			});  
	}
	
    $( "#logout" ).click(function() {
    	  $( "#logoutForm" ).submit();
    });
</script>
    

</body>
</html>