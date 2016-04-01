<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Image"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Available Images</title>
</head>
<body>
	<table>
		<tbody>
			<%
				ArrayList<Image> img = (ArrayList<Image>) request.getAttribute("images");
				for (Image imageCodes : img) {
			%>
			<tr>
				<form action="./ImageUpload?action=image" method="get">
					<td><img alt="image" src="<%=imageCodes.getImagePath()%>"
						width="100px" /> <input type="radio" name="image"
						value="<%=imageCodes.getImageId()%>" /> 
			</tr>
			</tbody>
	</table><%}%>
	<input type="submit" value="Select"></td>
				</form>
		
</body>
</html>