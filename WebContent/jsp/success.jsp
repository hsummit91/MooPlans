<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Food ordered.</title>
</head>
<body>
<% 
String msg = (String)session.getAttribute("message");
%>
<h1> Wow!!! food ordered success.</h1>
<h4><%=msg%></h4>
</body>
</html>