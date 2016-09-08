<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>All Orders</title>
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
</head>
<body>
<div id="container">
</div>
</body>
<script src="../js/jquery-1.11.2.min.js"></script>
<script type="text/javascript">

$(document).ready(function() {
	$.ajax({
		  	method: "POST",
		  	url: "../FetchData",
		  	data: { action: "getallOrders" }
		}).done(function( msg ) {
			console.log(msg);
			
		    var text = "";
		    
	    	text += '<table id="example" class="table table-bordered" width="100%" cellspacing="0">';
	    	text += '<thead><tr>';
	    	text += '<th>Order ID</th>';
	    	text += '<th>User ID</th>';
	    	text += '<th>Date</th>';
	    	text += '<th>Delivered at</th>';
	    	text += '<th>Phone</th>';
	    	text += '<th>Payment Mode</th>';
	    	text += '<th>Total</th>';
	    	text += '<th>Time</th>';
	    	text += '<th>Dishes</th>';
	    	text += '<th>Notes</th>';	    	
	    	text += '</tr></thead><tbody>';
	    	
		    if(msg == "" || msg == null || msg.length == 0){
		    	
		    }else{
		    	
		    	for(i=0;i<msg.length;i++){
		    		
		    		var orders = "";
		    		
		    		for(j=0;j<msg[i].orderItems.length;j++){
		    			orders += "<li>" + msg[i].orderItems[j] + "</li>";
		    		}
		    		
		    		text += '<tr  id="'+msg[i].orderId+'" >';
		    		text += '<td>'+msg[i].orderId+'</td>';
		    		text += '<td>'+msg[i].userId+'</td>';
		    		text += '<td>'+msg[i].orderDate+'</td>';
		    		text += '<td>'+msg[i].deliver+'</td>';
		    		text += '<td>'+msg[i].orderPhone+'</td>';
		    		text += '<td>'+msg[i].paymentMode+'</td>';
		    		text += '<td>'+msg[i].orderTotal+'</td>';
		    		text += '<td>'+msg[i].time+'</td>';
		    		text += '<td>'+orders+'</td>';
		    		text += '<td>'+msg[i].notes+'</td>';
		    		
		    		text += '</tr>';
		    	}
		    		    	
		    }
		    text += '</tbody></table>';
		     
		    console.log(text)
		    
		     $("#container").html(text);
			
		}); 
});
</script>
</html>