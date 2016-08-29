<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
   <head>
      <meta http-equiv="Content-Type" content="text/html;
         charset=UTF-8">
      <title>Update Dishes</title>
   </head>
   <body>
     <sql:setDataSource var="dbSource" driver="com.mysql.jdbc.Driver"
                         url="jdbc:mysql://moop2823825443.c1cyexirjeyj.us-west-2.rds.amazonaws.com/moop2823825443"
                         user="moop2823825443" password="mooplans2016"/>


      <sql:update dataSource="${dbSource}" var="dbResult">
         UPDATE dishes SET dish_name=?, dish_description=?, dish_category=?, dish_allergen=?,
           dish_health=? , dish_full_price=? , dish_command=?, dish_choice=?  WHERE dish_id=?;
         <sql:param value="${param.dish_name}" />
         <sql:param value="${param.dish_description}" />
         <sql:param value="${param.dish_category}" />
          <sql:param value="${param.dish_allergen}" />
          <sql:param value="${param.dish_health}" />
           <sql:param value="${param.dish_full_price}" />
         <sql:param value="${param.dish_command}" />
         <sql:param value="${param.dish_choice}" />
         <sql:param value="${param.id}" />
      </sql:update>

      <c:if test="${dbResult>=1}">
         <c:redirect url="view.jsp" >
            <c:param name="msg" value="1 record updated" />
         </c:redirect>
      </c:if>
   </body>
</html>