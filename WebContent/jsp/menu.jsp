<%@ page import="java.util.*"%>
<%@ page import="com.mooplans.model.Dishes"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Orders Menu</title>
<script src="./js/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="./css/dataTables.css">
 <link rel="stylesheet" type="text/css" href="./css/bootstrap.min.css">
<style type="text/css">
	#example_wrapper {
        width: 98%;
        margin: 1em 0 0 1em;
    }
    th{
        background-color: #2a363b !important;
    	color: #ff847c;
    	font-size: 20px;
    }
    td{
    	font-size: 18px;
    }
    .odd{
    	background-color: #FECEA8 !important;
    }
    tr.odd > .sorting_1{
    	background-color: #feb9a8 !important;
    }
	tr.even > .sorting_1{
		background-color: #fedcc1 !important;
	} 
	
	@media screen and (max-width: 800px){
		#example_wrapper {
        	width: 97%;
    	}
    	th{
    		font-size: 18px;
    	}
    	td{
    		font-size: 16px;
    	}
	}
	
		
	@media screen and (max-width: 640px){
		#example_wrapper {
        	width: 95%;
    	}
    	th{
    		font-size: 16px;
    	}
    	td{
    		font-size: 14px;
    	}
	}
	
	@media screen and (max-width: 480px){
		#example_wrapper {
        	width: 95%;
    	}
    	th{
    		font-size: 14px;
    	}
    	td{
    		font-size: 12px;
    	}
	}
	
	@media screen and (max-width: 390px){
		#example_wrapper {
        	width: 95%;
    	}
    	th{
    		font-size: 14px;
    		padding: 8px 10px;
    	}
    	td{
    		font-size: 12px;
    	}
	}
    
    @media screen and (max-width: 390px){
		#example_wrapper {
        	width: 95%;
    	}
    	th{
    		font-size: 12px;
    		padding: 5px 5px;
    	}
    	td{
    		font-size: 11px;
    	}
	}
    
</style>
</head>
<body>
	<form name="formName" method="post" action="./CartServlet">
 	<table id="example" class="display dataTable" cellspacing="0">
		<thead>
			<tr>
				<th>Food Item</th>
				<th>Category</th>
				<th>Points</th>
				<th></th>
			</tr>
		</thead>
		<tbody>

			<%
				ArrayList<Dishes> rest = (ArrayList<Dishes>) request.getAttribute("menuList");
				int index=0;
					for (Dishes dishes : rest) { 
			%>
			<tr>	
				<td>
					<%=dishes.getDishName()%>
				</td>
				<td>
					<%=dishes.getDishCategory()%>
				</td>
            	<td>
            		<%=dishes.getDishPrice()%>
            	</td>
            	<td>
            		<input type="submit" class="btn btn-primary" value="Add to cart">
            		<input type="hidden" name="dishId" value="<%=dishes.getDishId()%>"/>
            		<input type="hidden" name="dishName" value="<%=dishes.getDishName()%>" />
            		<input type="hidden" name="dishPoints" value="<%=dishes.getDishPrice()%>"/>
            	</td>
			</tr>          	
			<%}%>
		</tbody>
	</table>
	</form>
</body>
 <script src="./js/jquery.dataTables.min.js"></script>
 <script type="text/javascript">
 	$(document).ready(function() {
 	    var table = $('#example').DataTable();
 	});
</script>
</html>