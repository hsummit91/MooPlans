<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@ page import="com.mooplans.model.Image"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-js">
	<head>
	<link rel="stylesheet" type="text/css" href="../css/default.css" />
	<link rel="stylesheet" type="text/css" href="../css/component.css" />
	<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
	<link rel="stylesheet" type="text/css" href="../css/profile.css" />
	<script src="../js/jquery.min.js"></script>
	<script src="../js/bootstrap.min.js"></script>
	<script type="text/javascript">
	function getUserDetails(){				
	    $.ajax({
			  method: "POST",
			  url: "../FetchData",
			  data: { action: "getUserDetails", userId: "1"  }
			}).done(function( msg ) {
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
			});    
	}
	
	function selectImage(){
		$(".container").hide();
		$("#imageSelector").show("slow");
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
	</script>
	</head>
	<body onload="getUserDetails()">

<div class="container">
	<div class="row login_box">
	    <div class="col-md-12 col-xs-12" align="center">
            <div class="line"><h3>My Profile</h3></div>
            <!-- <div class="outter"></div> -->
            <div class="profile-header-container">   
    		<div class="profile-header-img">
                <img class="img-circle" id="profileImg" src="" />
                <!-- badge -->
                <div class="rank-label-container">
                    <a href="#" onclick="selectImage()" ><span class="label label-default rank-label">Change Image</span></a>
                </div>
            </div>
        </div>   
            <h1><div id="name"></div></h1>
            <!-- <span><div id="points"></div></span> -->
	    </div>
        <div class="col-md-6 col-xs-6 follow line" align="center">
            <h3>
                 <span><span id="points"></span> Points</span>
            </h3>
        </div>
        <div class="col-md-6 col-xs-6 follow line" align="center">
            <h3 class="points">
                 <span>Add Points</span>
            </h3>
        </div>
        
        <div class="col-xs-6 login_control">
                
                <div class="control">
                    <div class="label" id="email"></div>
                </div>
                
        </div>
        <div class="col-xs-6 login_control">
                
                <div class="control">
                     <div class="label" id="phone"></div>
                </div>
        </div>
		<div class="col-xs-12 login_control">
                
                <div class="control">
                     <div class="label" id="address"></div>
                </div>
        </div>
     </div>
  </div>
  <div id="imageSelector" style="display: none;">
  <%
	ArrayList<Image> img = (ArrayList<Image>) session.getAttribute("images");
	for (Image imageCodes : img) {
  %>
	<div class="col-xs-6 col-md-3 foo" style="height: 250px;width: 250px;margin: 0.5em">
		<img alt="Profile Image" onclick="getPath(this)" id="<%=imageCodes.getImageId()%>" style="height: inherit;width: inherit;cursor: pointer;" src="<%=imageCodes.getImagePath()%>" />
	</div> 

  <%}%>
  </div>
	</body>
</html>