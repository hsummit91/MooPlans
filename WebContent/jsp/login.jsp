<%@ page language="java" import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
</head>
<body background="../images/Logo black.png">
	<%
		String valid = (String) request.getAttribute("errormsg");
		if (valid != null)
			out.print(valid);
	%>

	<form method="post" name="login" action="../Login" class="login">
		<fieldset>
			<legend class="legend">Login</legend>
			<div class="input">
				<input type="email" name="email" placeholder="Email" required /> <span><i
					class="fa fa-envelope-o"></i></span>
			</div>

			<div class="input">
				<input type="password" name="password" placeholder="Password"
					required /> <span><i class="fa fa-lock"></i></span>
			</div>

			<input type="submit" name="submit" class="submit" value="&#xf061;" />

		</fieldset>

		<div class="feedback">
			login successful <br /> redirecting...
		</div>

	</form>
	<script src='../js/jquery.min.js'></script>

	<script src="../js/index.js"></script>


</body>
</html>