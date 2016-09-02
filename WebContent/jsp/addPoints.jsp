<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Payment</title>
<link href="../css/style.css" rel="stylesheet">
</head>
<body>
    <div id="preloader">
        <div class="sk-spinner sk-spinner-wave" id="status">
            <div class="sk-rect1"></div>
            <div class="sk-rect2"></div>
            <div class="sk-rect3"></div>
            <div class="sk-rect4"></div>
            <div class="sk-rect5"></div>
        </div>
    </div><!-- End Preload -->
<% String pay = request.getParameter("pay"); 
	if(pay == null){
		pay = "0";
	}
	double tax = Integer.parseInt(pay) * (0.08);
%>
<form id="payment" action="${initParam['posturl']}" method="post">
<input type="hidden" name="upload" value="1"/>
<input type="hidden" name="return" value="${initParam['returnurl']}"/>
<input type="hidden" name="cmd" value="_cart"/>
<input type="hidden" name="business" value="${initParam['business']}"/>

<input type="hidden" name="item_name_1" value="Meal Plan"/>
<input type="hidden" name="amount_1" value="<%=pay%>" />
<%-- <input type="hidden" name="tax_1" value="<%=tax%>" /> --%>
<!-- <input type="text" name="quantity_1" value="1"/> -->
<input style="display: none;" type="submit" value="Payment"/>
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