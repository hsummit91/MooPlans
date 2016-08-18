<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html;
         charset=UTF-8">
      <title>Delete restaurant</title>
   </head>
   <body>
    <sql:setDataSource var="dbSource" driver="com.mysql.jdbc.Driver"
                         url="jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443"
                         user="moop2823825443" password="mooplans2016"/>
      <sql:update dataSource="${dbSource}" var="dbResult">
         DELETE FROM restaurant WHERE rest_id=${param.id};
      </sql:update>
      <c:if test="${dbResult>=1}">
         <c:redirect url="index.jsp" >
            <c:param name="msg" value="1 record deleted." />
         </c:redirect>
      </c:if>
   </body>
</html>