<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Past Orders</title>
<script src="../js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="../css/dataTables.css">
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/menutable.css">
<script type="text/javascript">
function getPastOrders(){				
    $.ajax({
		  method: "POST",
		  url: "../FetchData",
		  data: { action: "getPastOrders", userId: 1  }
		}).done(function( msg ) {
			  console.log(msg.length);
			  
			    var text = "";
			    
		    	text += '<table id="example" class="display dataTable" width="100%" cellspacing="0">';
		    	text += '<thead><tr>';
		    	text += '<th>Order ID</th>';
		    	text += '<th>Date</th>';
		    	text += '<th>Delivered at</th>';
		    	text += '<th>Dishes</th>';
		    	text += '<th>Total</th>';
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
			    		text += '<td>'+msg[i].orderDate+'</td>';
			    		text += '<td>'+msg[i].deliver+'</td>';
			    		text += '<td>'+orders+'</td>';
			    		text += '<td>'+msg[i].orderTotal+'</td>';
			    		text += '</tr>';
			    	}
			    		    	
			    }
			    text += '</tbody></table>';
			     
			     $("#history").html(text);
			     $('#example').DataTable();
		});    
}
</script>
</head>
<body onload="getPastOrders()">
<div id="history"></div>
</body>
 <script src="../js/jquery.dataTables.min.js"></script>
</html>