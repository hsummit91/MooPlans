<%@page import="com.mooplans.model.Restaurant"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Cart" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script src="../js/socialSharing.js" type="text/javascript"></script>
<title>Restaurants</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/menutable.css">
<link rel="stylesheet" type="text/css" href="../css/jquery-ui.css">
<style type="text/css">
.restImages{
	height: 200px;
	width: 200px;
}
.restButtons{
	height: 230px;
	width: 230px;
	margin-bottom: 1em; 
}
</style>
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
<div class="container">
      <!-- Static navbar -->
      <nav class="navbar navbar-default">
        <div class="container-fluid">
          <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
              <span class="sr-only">Toggle navigation</span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
              <span class="icon-bar"></span>
            </button>
            	<img class="block" id="u3284_img" src="../images/logo%20high%20quality.jpg" alt="Moo Plans" style="margin-right: 1em;"/>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="home.jsp">Home</a></li>
              <li class="active"><a href="#">Place Order</a></li>
              <li><a href="pastOrders.jsp">Past Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
            <li><a href="cart.jsp?added=false"><i class="glyphicon glyphicon-shopping-cart"></i><span class="badge"><%=shoppingCart.numberOfItems() %></span></a></li>
              <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Hi <%=user.getUser_firstname() %>! <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="mealPlans.jsp"><%=user.getUser_points()%> Points</a></li>
                  <li><a href="mealPlans.jsp">Purchase a Meal Plan</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Profile Settings</li>
                  <li><a href="../jsp/myProfile.jsp">View Profile</a></li>
                </ul>
              </li>
              <li><a href="#" id="logout">Logout</a></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div><!--/.container-fluid -->
      </nav>
      
         <!--#################### FILTERS  #################-->
      
      <div class="col-md-3 thumbnail">
		<div class="caption"><h3>Search Filters</h3>
		
		<div class="col-md-12 thumbnail">
		<div class="caption"><h3>Meal Preference</h3>
		<div class="row">
		  <div class="col-md-12" id="mealPreference">
		  	<div class="ui-widget">
	  			<input id="tags" size="32">
			</div>
		  </div>
		  
		</div>
		</div>
		</div>
		
		<div class="col-md-12 thumbnail">
		<div class="caption"><h3>Categories</h3>
		<div class="row">
		  <div class="col-md-12" id="category">
		  	<div class="ui-widget">
	  			<input id="cTags" size="32">
			</div>
		  </div>
		  
		</div>
		</div>
		</div>
		
		<div class="col-md-12 thumbnail">
		<div class="row">
		  <div class="col-md-12">
		    <div class="input-group">
		      <span class="input-group-addon">
		        <input type="checkbox" name="dineIn" id="dineIn" value="1">
		      </span>
		      <input type="button" class="form-control" value="Dine-in" aria-label="...">
		    </div><!-- /input-group -->
		  </div><!-- /.col-lg-6 -->
		  		  
		</div>
		</div>
		
		<div class="col-md-12 thumbnail">
		  <button class="col-md-12 btn btn-primary" onclick="getFilters()">Add Filter</button>
	  	</div>

		</div>
		
	  </div>
	  
	  <!--#################### FILTERS  #################-->
	  
	  <div class="col-md-9" id="restaurants"></div>
</div>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js" type="text/javascript"></script>
<script src="../js/jquery-ui.js"></script>
<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>
<script type="text/javascript">
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
		//console.log(msg); 
		var text = "";
		text += '<form method="post" id="ordersForm" name="formName" action="../ActionServlet?action=menuPage">';
		for(i=0;i<msg.length;i++){
					
			text += '<div class="col-xs-12 col-sm-6 col-md-3">';
			text += '<div class="thumbnail">';
			/* text += '<input type="image" class="restImages" name="restName" alt="'+msg[i].restName+'" value="'+msg[i].restName+'" src="../images/restLogos/'+msg[i].restName+'.jpg" />'; */
			text += '<img class="restImages" alt="'+msg[i].restName+'" restId="'+msg[i].restId+'" src="../images/restLogos/'+msg[i].restName+'.jpg" />';
			text += '<div class="caption">';
			text += '<h3>'+msg[i].restName+'</h3>';
			text += '<p>'+msg[i].restHealth+'</p>';
			text += '<p>Popular for: '+msg[i].restMealType+'</p>';
			text += '</div>';
			text += '</div>';
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
				
				//window.location.href = "menu.jsp?cust="+cust;
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
	      "veg",
	      "vegan",
	      "kosher",
	      "halal"
	    ];
	    
		var categories = [
		  "breakfast",
		  "lunch",
		  "dinner",
		  "half-meal"
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