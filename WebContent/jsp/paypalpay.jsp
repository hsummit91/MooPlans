<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Pay through PayPal: http://www.TestAccount.com</title>
</head>
<% session.setAttribute("amt", "25");%>
<body onload="document.forms['paypalForm'].submit();">
<form name="paypalForm" action="https://www.sandbox.paypal.com/cgi-bin/webscr?175" method="post">
 <input type="hidden" name="cmd" value="_xclick" />
 <input type="hidden" name="business" value="okulkarni@albany.edu" />
 <!-- <input type="hidden" name="password" value="U@lbanyISO123" /> -->
 <input type="hidden" name="custom" value="1123" />
 <input type="hidden" name="item_name" value="Computer-Laptop" />
 <input type="hidden" name="amount" value="25"/>
 <input type="hidden" name="rm" value="1" />
 <!-- <input type="hidden" name="return" value="http://localhost:8080/MooPlans/jsp/paypalResponse.jsp" />
 <input type="hidden" name="cancel_return" value="http://localhost:8080/MooPlans/jsp/paypalResponseCancel.jsp?amt=175" /> -->
 <input type="hidden" name="cert_id" value="API Singature" />
</form>
</body>
</html>