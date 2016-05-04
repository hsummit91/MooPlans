<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Payment</title>
</head>
<body>
<% String pay = request.getParameter("pay"); 
	if(pay == null){
		pay = "0";
	}
%>
<form id="payment" action="${initParam['posturl']}" method="post">
<input type="hidden" name="upload" value="1"/>
<input type="hidden" name="return" value="${initParam['returnurl']}"/>
<input type="hidden" name="cmd" value="_cart"/>
<input type="hidden" name="business" value="${initParam['business']}"/>

<input type="hidden" name="item_name_1" value="Meal Package"/>
<input type="hidden" name="amount_1" value="<%=pay%>" />
<!-- <input type="text" name="quantity_1" value="1"/> -->
<input type="submit" value="Payment"/>
</form>
<script src="../js/jquery.min.js"></script>
<script type="text/javaScript">
	/* function disableBackButton() {
		window.history.forward();
	}
	setTimeout("disableBackButton()", 0); */
	
	$( document ).ready(function() {
		$( "#payment" ).submit();
	});
	
</script>
</body>
</html>