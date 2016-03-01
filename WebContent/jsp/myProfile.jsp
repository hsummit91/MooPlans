<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en" class="no-js">
	<head>
	<link rel="stylesheet" type="text/css" href="../css/default.css" />
	<link rel="stylesheet" type="text/css" href="../css/component.css" />
	<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css" />
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
			});
	    
	}
	</script>
	<style type="text/css">

*{
    font-family: 'Raleway', sans-serif;
    color : #FFF;
    
}


div span {
     font-weight: 200;
}

h1{
     font-weight: 200;
}

.login_box{
    background: #FF847C;
    width:50%;
    position:absolute;
    top:2%;
    left:25.5%;
    
    -webkit-box-shadow: 0px 0px 8px 0px rgba(50, 50, 50, 0.54);
-moz-box-shadow:    0px 0px 8px 0px rgba(50, 50, 50, 0.54);
box-shadow:         0px 0px 8px 0px rgba(50, 50, 50, 0.54);
}

@media (max-width: 767px) {
    .login_box{
        background: #FF847C;
        width:90%;
        height:80%;
        position:absolute;
        top:10%;
        left:5%;
        
        -webkit-box-shadow: 0px 0px 8px 0px rgba(50, 50, 50, 0.54);
-moz-box-shadow:    0px 0px 8px 0px rgba(50, 50, 50, 0.54);
box-shadow:         0px 0px 8px 0px rgba(50, 50, 50, 0.54);
    }
}


.follow{
    background-color:#E84A5F;
    cursor:pointer;
}

.follow:hover{
    background-color: #FECEA8; /*E84A5F FECEA8*/
    color:black;
    cursor:pointer;
}
.follow:hover span{
    color:black;
}

.login_control{
    background-color:#FFF;
    padding:10px;
    
}

.control {
    color:#000;
    margin:10px;
    text-align: center;
}

.label {
    color: #E84A5F;
    font-size: 18px;
    font-weight: 500;
}

.line{
    border-bottom : 2px solid #E84A5F;
}


.outter{
    padding: 0px;
    border: 1px solid rgba(255, 255, 255, 0.29);
    border-radius: 50%;
    background-color: #2A363B;
    width: 150px;
    height: 150px;
}


.profile-header-img > img.img-circle {
    width: 150px;
    height: 150px;
    border: 1px solid #2A363B;
}

.rank-label-container {
    margin-top: -19px;
    text-align: center;
    cursor: pointer;
}

.label.label-default.rank-label {
    background-color: #2A363B;
    padding: 5px 10px 5px 10px;
    border-radius: 27px;
}
	</style>
	</head>
	<body onload="getUserDetails()">
<div class="container">
	<div class="row login_box">
	    <div class="col-md-12 col-xs-12" align="center">
            <div class="line"><h3>My Profile</h3></div>
            <!-- <div class="outter"></div> -->
            <div class="profile-header-container">   
    		<div class="profile-header-img">
                <img class="img-circle" src="//lh3.googleusercontent.com/-6V8xOA6M7BA/AAAAAAAAAAI/AAAAAAAAAAA/rzlHcD0KYwo/photo.jpg?sz=120" />
                <!-- badge -->
                <div class="rank-label-container">
                    <span class="label label-default rank-label">Change Image</span>
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
	</body>
</html>