<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Image"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<script src="./js/jquery.min.js"></script>
<title>Available Images</title>
</head>
<body>
<%
	ArrayList<Image> img = (ArrayList<Image>) request.getAttribute("images");
	for (Image imageCodes : img) {
%>
	<div class="col-xs-6 col-md-3 foo" style="height: 250px;width: 250px;margin: 0.5em">
		<img alt="Profile Image" onclick="getPath(this)" style="height: inherit;width: inherit;cursor: pointer;" src="<%=imageCodes.getImagePath()%>" />
	</div> 

<%}%>
		
</body>
<script type="text/javascript">
	function getPath(ele){
		console.log($(ele).attr("src"));
	}
</script>
</html>