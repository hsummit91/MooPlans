<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.User"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type"
	content="text/html;
         charset=UTF-8">
<title>Delete restaurant</title>
</head>
<body>
	<%
		//allow access only if session exists
	User user = null;
	if(session.getAttribute("User") == null){
		out.print("Session Invalidate");
	    response.sendRedirect("redirect.jsp");
	}else {
		user = (User) session.getAttribute("User");
	}
%>
	<sql:setDataSource var="dbSource" driver="com.mysql.jdbc.Driver"
		url="jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443"
		user="moop2823825443" password="mooplans2016" />
	<sql:update dataSource="${dbSource}" var="dbResult">
         DELETE FROM dishes WHERE dish_id=${param.id} and dish_rest_id=<%=user.getUser_id()%>;
      </sql:update>
	<c:if test="${dbResult>=1}">
		<c:redirect url="view.jsp">
			<c:param name="msg" value="1 record deleted." />
		</c:redirect>
	</c:if>
</body>
</html>