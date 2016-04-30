<%@ page language="java" import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Moo Registration</title>
<script src="http://s.codepen.io/assets/libs/modernizr.js"
	type="text/javascript"></script>
<link rel="stylesheet" href="../css/reset.css">
<link rel='stylesheet prefetch' href='../css/font-awesome.css'>
<link rel="stylesheet" href="../css/style.css">
<style>
input[type="submit"] {
	font-family: FontAwesome;
}

 td{
 vertical-align: middle !important;
 margin: 10px;
}

.login{
	width: 600px !important;
}

.input input{
	margin-left: 2em !important;
	margin-bottom: 0.5em !important;
	width: 420px !important;
}

.input select{
	margin-left: 2em !important;
	margin-bottom: 0.5em !important;
	width: 95% !important;
}

@media screen and (max-width:640px){
	.login{
		width: 500px !important;
	}
	.input input{
		margin-left: 1.5em !important;
		width: 320px !important;
	}
	
	.input select{
		margin-left: 1.5em !important;
		width: 94% !important;
	}

}

@media screen and (max-width:480px){
	
	.login{
		width: 300px !important;
	}
	.input input{
		margin-left: 1em !important;
		width: 180px !important;
	}
	
	.input select{
		margin-left: 1em !important;
		width: 91% !important;
	}
}

@media screen and (max-width:320px){
	
	.login{
		width: 300px !important;
	}
	.input input{
		margin-left: 1em !important;
		width: 180px !important;
	}
	
	.input select{
		margin-left: 1em !important;
		width: 91% !important;
	}
	
}
</style>
</head>
<body onload="checkError();" background="../images/Logo Transparent.png">
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
	%>	
	<form method="post" name="register" action="../Registration"
		class="login">
		<fieldset>
			<legend class="legend">Get registered with Moo Plans <span style="float: right;"><a href="login.jsp?pay=<%=pay %>">Already a Member?</a></span></legend>
			<div class="input">

				<table style="with: 100%">
					<tr>
						<td>First Name</td>
						<td><input type="text" name="firstname"
							placeholder="First Name" required /></td>
					<tr>
						<td>Last Name</td>
						<td><input type="text" name="lastname"
							placeholder="Last Name" /></td>
					<tr>
						<td>Email ID</td>
						<td><input type="email" name="email"
							placeholder="Email address" required /></td>
					</tr>
					<tr>
						<td>Password</td>
						<td><input type="password" name="password" placeholder="Password"
							required /></td>
					</tr>
					<tr>
						<td>Cell Phone</td>
						<td><input type="text" maxlength="10" name="phone"
							title="1234567890" pattern="\d{10}"
							placeholder="Cell Phone" required /></td>
					</tr>
					<tr>
						<td>Address</td>
						<td><input type="text" name="address"
							placeholder="Home/University Address" required /></td>
					</tr>
					<tr>
						<td>University</td>
						<td><select name="university" required="required">
								<option selected="selected" value="SUNY Albany Uptown">SUNY
									Albany Uptown</option>
								<option value="SUNY Albany Downtown">SUNY Albany
									Downtown</option>
								<option value="Saint Rose">Saint Rose</option>
						</select></td>
					</tr>
				</table>
			</div>
			<input type="hidden" id="isError" value="<%=isError %>" />
			<input type="hidden" id="message" value="<%=valid %>" />
			<input type="hidden" name="pay" value="<%=pay %>" />
			<input type="submit" name="register" class="submit" value="&#xf061;" />
		</fieldset>

	</form>
	<script src='../js/jquery.min.js'></script>

	<script src="../js/index.js"></script>

</body>
</html>