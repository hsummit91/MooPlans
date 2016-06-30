<%@page import="org.json.JSONArray"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Dishes"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Cart" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<script src="./js/socialSharing.js" type="text/javascript"></script>
<title>Orders Menu</title>
<link rel="stylesheet" type="text/css" href="./css/dataTables.css">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="./css/menutable.css">
<link rel="stylesheet" type="text/css" href="./css/jquery-ui.css">
<style>
.img-zoom {
    width: 310px;
    -webkit-transition: all .2s ease-in-out;
    -moz-transition: all .2s ease-in-out;
    -o-transition: all .2s ease-in-out;
    -ms-transition: all .2s ease-in-out;
}

.transition {
    -webkit-transform: scale(2); 
    -moz-transform: scale(2);
    -o-transform: scale(2);
    transform: scale(2);
}

.dishThumbnail {
    background-color: #fff;
    border: 1px solid #ddd;
    border-radius: 4px;
    display: block;
    line-height: 1.42857;
    margin-bottom: 20px;
    padding: 4px;
    transition: all 0.2s ease-in-out 0s;
}
</style>
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
            	<img class="block" id="u3284_img" src="images/logo%20high%20quality.jpg" alt="Moo Plans" style="margin-right: 1em;"/>
          </div>
          <div id="navbar" class="navbar-collapse collapse">
            <ul class="nav navbar-nav">
              <li><a href="jsp/home.jsp">Home</a></li>
              <li class="active"><a href="jsp/orders.jsp">Place Order</a></li>
              <li><a href="jsp/pastOrders.jsp">Past Orders</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
             <li><a href="jsp/cart.jsp?added=false"><i class="glyphicon glyphicon-shopping-cart"></i><span class="badge"><%=shoppingCart.numberOfItems() %></span></a></li>
             <li class="dropdown">
                <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">Hi <%=user.getUser_firstname()%>! <span class="caret"></span></a>
                <ul class="dropdown-menu">
                  <li><a href="jsp/mealPlans.jsp"><%=user.getUser_points()%> Points</a></li>
                  <li><a href="jsp/mealPlans.jsp">Purchase a Meal Plan</a></li>
                  <li role="separator" class="divider"></li>
                  <li class="dropdown-header">Profile Settings</li>
                  <li><a href="jsp/myProfile.jsp">View Profile</a></li>
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
		<p>
		  <label for="amount">Price range:</label>
		  <input type="text" id="amount" readonly style="border:0; color:#f6931f; font-weight:bold;">
		</p>
		 
		<div id="slider-range"></div>
		</div>
		
		<div class="col-md-12 thumbnail">
		<div class="caption"><h3>Meal Type</h3>
		<div class="row">
		  <div class="col-md-12"  id="mealType">
		    <div class="input-group">
		      <span class="input-group-addon">
		        <input type="checkbox" name="mealType" value="breakfast">
		      </span>
		      <input type="button" class="form-control" value="Breakfast" aria-label="...">
		    </div><!-- /input-group -->
		    
		    <div class="input-group">
		      <span class="input-group-addon">
		        <input type="checkbox" name="mealType" value="lunch">
		      </span>
		      <input type="button" class="form-control" value="Lunch" aria-label="...">
		    </div><!-- /input-group -->
		    
		    <div class="input-group">
		      <span class="input-group-addon">
		        <input type="checkbox" name="mealType" value="dinner">
		      </span>
		      <input type="button" class="form-control" value="Dinner" aria-label="...">
		    </div><!-- /input-group -->
		    
		    <div class="input-group">
		      <span class="input-group-addon">
		        <input type="checkbox" name="mealType" value="half-meal">
		      </span>
		      <input type="button" class="form-control" value="Half-Meal" aria-label="...">
		    </div><!-- /input-group -->
		    
		  </div><!-- /.col-lg-6 -->
		  		  
		</div>
		</div>
		
		<div class="col-md-12 thumbnail">
		  <button class="col-md-12 btn btn-primary" onclick="getFilters()">Add Filter</button>
	  	</div>
		
		</div>
		</div>
		
	  </div>
	  
	  <!--#################### FILTERS  #################-->
	
	<div class="col-md-6" id="dishes">
	
 	<div>
	
	<%
			JSONArray rest = (JSONArray) request.getAttribute("menuList");
			//out.println(rest.length());
			for (int i = 0; i < rest.length(); i++) { 
			%>
		 	<div class="col-xs-12 col-sm-12 col-md-12 thumbnail">
			<!-- <div> -->
			<img alt="DISH" src="images/o-crop-u4520.jpg" style="padding-top: 1em;padding-bottom: 1em;" class="col-xs-12 col-sm-6 col-md-3" />
				<div class="col-md-9">
		        	<div class="col-md-9"><h4><%=rest.getJSONObject(i).get("dishName")%></h4></div>
		        	<div class="col-md-3"><h4 class="btn-primary" style="margin-left: 7px;border-radius:5px;margin-right: 17px;padding-left: 6px;"><%=rest.getJSONObject(i).get("dishPrice")%> P </h4></div>
		        	
		        	<div class="col-md-9"><%=rest.getJSONObject(i).get("dishCat")%></div>
		        	<div class="col-md-3"><button dishId="<%=rest.getJSONObject(i).get("dishId") %>" dishName="<%=rest.getJSONObject(i).get("dishName") %>" class="btn btn-primary openDialog">Add</button></div>
		        	
		        	<div class="col-md-12"><%=rest.getJSONObject(i).get("dishHealth")%></div>
		      	</div>
			<!-- </div> -->
			<div class="dishDialog" id="dialogDesc_<%=rest.getJSONObject(i).get("dishId") %>" title="<%=rest.getJSONObject(i).get("dishName") %>">
			  <p><span class="ui-icon ui-icon-info" style="float:left; margin:0 7px 20px 0;"></span><%=rest.getJSONObject(i).get("dishDesc") %></p>
			  <button dishId="<%=rest.getJSONObject(i).get("dishId") %>" dishName="<%=rest.getJSONObject(i).get("dishName") %>" class="btn btn-primary addToCart">Add to Cart</button>
			</div>
			</div>        	
			<%}%>

		
	</div> 
	
	</div>
	
	<div class="col-md-3 thumbnail">
	  
		<div class="caption"><h3>Shopping Cart</h3>
		<div id="shoppingCart">

		<%  HashMap<Integer, String> items = shoppingCart.getCartItems(); %>
				
				
		<% int count = 0;
		for(Integer key: items.keySet()){
			count++;%>
		
		<div class="col-md-12 thumbnail"><div class="col-md-6"><%= items.get(key)%></div><div class="col-md-6"><button class='btn btn-primary deleteItem' dishId="<%=key %>">X</button></div></div>	
		
		<% 	}
		if(items.size() == 0){ %>
			<div class="thumbnail">No items in cart</div>
		<% } %>
		
		<% 	if(!items.isEmpty()){ %>
				<a href="jsp/checkout.jsp"><input type='submit' style='margin-left: 16px;' class='btn btn-primary' value='Proceed Checkout'></a>
		<%} %>
		</div>      
		
		
		</div>

	</div>
	
</div>
<%
String restaurant = (String) request.getAttribute("restaurant");
%>
<input type="hidden" value="<%=restaurant %>" id="currentRestaurant" > 
<script src="./js/jquery.min.js"></script>
<script src="./js/bootstrap.min.js" type="text/javascript"></script>
<script src="./js/jquery-ui.js"></script>
<form action="${pageContext.request.contextPath}/Logout" id="logoutForm" method="post"></form>
<script type="text/javascript">
	$( "#logout" ).click(function() {
	  	$( "#logoutForm" ).submit();
	});
	
	function call(){
	    $.ajax({
		  	method: "POST",
		  	url: "./FetchData",
		  	data: { action: "cartJson" }
		}).done(function( msg ) {
			console.log("===========>"+msg.length)
			$("#shoppingCart").empty();
			var text = "";
			for(i=0;i<msg.length;i++){				
				text += '<div class="col-md-12 thumbnail"><div class="col-md-6">'+msg[i].dishName+'</div><div class="col-md-6"><button class="btn btn-primary deleteItem" dishId="'+msg[i].dishId+'">X</button></div></div>';
			}
			if(msg.length == 0){
				text += '<div class="thumbnail">No items in cart</div>';
			}else{
				text += "<a href='jsp/checkout.jsp'><input type='submit' style='margin-left: 16px;' class='btn btn-primary' value='Proceed Checkout'></a>";
			}
			$("#shoppingCart").html(text);
		});

	}

 	$(document).ready(function() {
 		
 		    $('.addToCart').click(function() {
 		    	
 		    	var dishId = $(this).attr("dishId");
 		    	var dishName = $(this).attr("dishName");
 		    	console.log("ID = "+dishId+" - Name = "+dishName)
				call();
  		 		$.ajax({
 				  	method: "POST",
 				  	url: "./CartServlet",
 				  	data: { button: "add", dishId: dishId, dishName: dishName }
 				}).done(function( msg ) {
 					console.log(msg);
 					$(".glyphicon-shopping-cart").addClass('transition');
 	 		        $(".badge").html(msg);
 	 		       // openDialog(dishId);
 	 		        call();
 	 		        setTimeout(function(){ 
 	 		        	$(".glyphicon-shopping-cart").removeClass('transition');
 	 		        }, 1000);
 	 		      $( "#dialogDesc_"+dishId ).dialog( "close" );	
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
 	    
/*  	    var $set = $('#mealPreference :checked');
 	    var len = $set.length;
 	    $set.each(function(index, element) {
 	        if (index == len - 1) {
 	        	mealPref += $(this).val();
 	        }else{
 	        	mealPref += $(this).val() + ",";	
 	        }
 	    }); */
 	    
 	    var temp = $("#tags").val();
 	    var length1 = temp.length;
 	    //console.log("length -"+length1)
 	    if(temp.charAt(length1-2) == ","){
 	    	mealPref = temp.slice(0, temp.length-2);
 	    }else{
 	    	mealPref = temp;
 	    }
 	    
 	    //console.log("====>"+mealPref)

 	    var $set = $('#mealType :checked');
 	    var len = $set.length;
 	    $set.each(function(index, element) {
 	        if (index == len - 1) {
 	        	mealType += $(this).val();
 	        }else{
 	        	mealType += $(this).val() + ",";	
 	        }
 	    });
 	    
 	    console.log(mealPref+" == "+mealType);
 	    
 	    getDishes(mealPref,mealType);
 	 }
 	
 	function getDishes(mealPref, mealType){
 		var currRest = $("#currentRestaurant").val();
 		console.log(mealPref+"==================>"+currRest)
 		$.ajax({
 		  	method: "POST",
 		  	url: "ActionServlet",
 		  	data: { action: "menuFilter", mealPref : mealPref, mealType : mealType, restId : currRest }
 		}).done(function( msg ) {
 			//console.log(msg); 
 			var text = "";
 			for(i=0;i<msg.length;i++){
 						
 				text += '<div class="col-xs-12 col-sm-12 col-md-12 thumbnail">';
 				text += '<img class="col-xs-12 col-sm-6 col-md-3" src="images/o-crop-u4520.jpg" style="padding-top: 1em;padding-bottom: 1em;" />';
 				text += '<div class="col-md-9">';
 				text += '<div class="col-md-9"><h4>'+msg[i].dishName+'</h4></div>';
 				text += '<div class="col-md-3"><h4 class="btn-primary" style="margin-left: 7px;border-radius:5px;margin-right: 17px;padding-left: 6px;">'+msg[i].dishPrice+' P </h4></div>';
 				
 				text += '<div class="col-md-9">'+msg[i].dishCat+'</div>';
 				text += '<div class="col-md-3"><button dishId="'+msg[i].dishId+'" class="btn btn-primary openDialog">Add</button></div>';
 				
 				text += '<div class="col-md-12">'+msg[i].dishHealth+'</div>';
 				
 				text += '</div>';
 				
 				text += '<div class="dishDialog" id="dialogDesc_'+msg[i].dishId+'" title='+msg[i].dishName+'>';
 				text += '<p><span class="ui-icon ui-icon-info" style="float:left; margin:0 7px 20px 0;"></span>'+msg[i].dishName+'</p>';
 				text += '<button dishId='+msg[i].dishId+' class="btn btn-primary addToCart">Add to Cart</button>';
 				
 				text += '</div>';
 				text += '</div>';		
 						
 			}
 			
 			$("#dishes").html(text);
 			
/*  			 $(".restImages").click(function(){
 					var rest = $(this).attr("restId");
 					console.log("-->RestID-->"+rest)
 					
 				$('<input />').attr('type', 'hidden')
 				              .attr('name', 'restId')
 				              .attr('value', rest)
 				              .appendTo('#ordersForm');
 				$('#ordersForm').submit();					
 					
 					//window.location.href = "menu.jsp?cust="+cust;
 			    }); */
 			    
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
 		      "veg",
 		      "vegan",
 		      "kosher",
 		      "halal"
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
 		    
 		    
 		    $( "#slider-range" ).slider({
 	 		      range: true,
 	 		      min: 0,
 	 		      max: 20,
 	 		      values: [ 2, 10 ],
 	 		      slide: function( event, ui ) {
 	 		        $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
 	 		      }
 	 		    });
 	 		    $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
 	 		      " - $" + $( "#slider-range" ).slider( "values", 1 ) );
 		    
 		    
  	 		  $(function() {
 	 		    $( ".dishDialog" ).dialog({
 	 		      resizable: false,
 	 		      autoOpen: false,
 	 		      height:300,
 	 		      width:800,
 	 		      modal: true
 	 		    });
 	 		  });  
 	 		  
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
 	  
/*  	  $(function() {
 		    $( "#slider-range" ).slider({
 		      range: true,
 		      min: 0,
 		      max: 500,
 		      values: [ 75, 300 ],
 		      slide: function( event, ui ) {
 		        $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
 		      }
 		    });
 		    $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
 		      " - $" + $( "#slider-range" ).slider( "values", 1 ) );
 		  }); */
</script>
</body>
</html>