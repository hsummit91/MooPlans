<%@ page language="java" import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Moo Login</title>
<script src="http://s.codepen.io/assets/libs/modernizr.js"
	type="text/javascript"></script>
<link rel="stylesheet" href="../css/reset.css">
<link rel='stylesheet prefetch' href='../css/font-awesome.css'>
<link rel="stylesheet" href="../css/style.css">
<style>
input[type="submit"] {
	font-family: FontAwesome;
}

</style>

<script type="text/javaScript">
function disableBackButton(){
	window.history.forward();
}
setTimeout("disableBackButton()", 0);
</script>
</head>
<body onload="disableBackButton();checkError();" background="../images/Logo Transparent.png">
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
	<form method="post" name="login" action="../Login" class="login">
		<fieldset>
			<legend class="legend">Login <span style="float: right;"><a href="register.jsp?pay=<%=pay %>">Not A Member?</a></span></legend>	
			<div class="input">
				<input type="email" name="email" placeholder="Email" required /> <span><i
					class="fa fa-envelope-o"></i></span>
			</div>

			<div class="input">
				<input type="password" name="password" placeholder="Password"
					required /> <span><i class="fa fa-lock"></i></span>
			</div>
			
			<input type="hidden" id="isError" value="<%=isError %>" />
			<input type="hidden" id="message" value="<%=valid %>" />
			<input type="hidden" name="pay" value="<%=pay %>" />
			<input type="submit" name="submit" class="submit" value="&#xf061;" />

		</fieldset>

		<div id="feedback" class="feedbackErr">
			
		</div>

	</form>
	<script src='../js/jquery.min.js'></script>

	<script src="../js/index.js"></script>


</body>
</html>