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
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="../css/restaurant.css">
<script src=".https://cdnjs.cloudflare.com/ajax/libs/oj.JSFiddle/0.0.1/oj.JSFiddle.min.js" type="text/javascript"></script>
<title>Home Page</title>
</head>
<body>

<ul class="nav navbar-nav navbar-right">
		<li><a href="#" id="logout">Logout</a></li>
	</ul>
	<ul class="nav navbar-nav navbar-right">
		<li><a href="view.jsp" id="view">View Dishes</a></li>
	</ul>
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
	<sql:query dataSource="${dbSource}" var="dbResult">
         SELECT * FROM dishes where dish_rest_id=<%=user.getUser_id()%>;
      </sql:query>

	<div align="center" class="bootstrap">
		<form action="../AddDishes" method="get" id="surveyForm" class="form-horizontal">
			<h3 class="mystyle">Welcome Restaurant User</h3>
			<p class="mystyle">Add new Dish details</p>
			<p class="mystyle" style="color:red">All * fields are mandatory</p><br />
			<!-- <input type="hidden" name="dish_id" />  -->
			
			<div class="col-md-12">
			<table></table><label class="col-md-3">Name *</label> <input type="text" name="dish_name" class="col-md-6" required="required"/></div> 
			<div class="col-md-12"><label class="col-md-3">Description </label> <input type="text" name="dish_description" class="col-md-6" /></div>
					
			<div class="col-md-12"><label class="col-md-3">Cuisine *</label> 
			<div class="col-md-6">
     	<input width="20px" type='radio' name='dish_category' value='Japanese' id="Japanese" required="required"/> Japanese
     	<input width="20px" type='radio' name='dish_category' value='Chinese' id="Chinese"/> Chinese
		<input width="20px" type='radio' name='dish_category' value='American' id="American"/> American
		<input width="20px" type='radio' name='dish_category' value='Indian' id="Indian"/> Indian 
		<input width="20px" type='radio' name='dish_category' value='Canadian' id="Canadian"/> Canadian
		<input width="20px" type='radio' name='dish_category' value='Thai' id="Thai"/> Thai
		<input width="20px" type='radio' name='dish_category' value='Mexican' id="Mexican"/> Mexican
		<input width="20px" type='radio' name='dish_category' value='Spanish' id="Spanish"/> Spanish
		<input width="20px" type='radio' name='dish_category' value='British' id="British"/> British 
		<input width="20px" type='radio' name='dish_category' value='Swedish' id="Swedish"/> Swedish
		<input width="20px" type='radio' name='dish_category' value='Latvian' id="Latvian"/> Latvian
		<input width="20px" type='radio' name='dish_category' value='Italian' id="Italian"/> Italian
		<input width="20px" type='radio' name='dish_category' value='Scottish' id="Scottish"/> Scottish
		<input width="20px" type='radio' name='dish_category' value='Russian' id="Russian"/> Russian
		<input width="20px" type='radio' name='dish_category' value='Jewish' id="Jewish"/> Jewish
		<input width="20px" type='radio' name='dish_category' value='Polish' id="Polish"/> Polish
		<input width="20px" type='radio' name='dish_category' value='German' id="German"/> German
		<input width="20px" type='radio' name='dish_category' value='French' id="French"/> French
		<input width="20px" type='radio' name='dish_category' value='Hawaiian' id="Hawaiian"/> Hawaiian
		<input width="20px" type='radio' name='dish_category' value='Brazilian' id="Brazilian"/> Brazilian
		<input width="20px" type='radio' name='dish_category' value='Peruvian' id="Peruvian"/> Peruvian
		<input width="20px" type='radio' name='dish_category' value='Salvadorian' id="Salvadorian"/> Salvadorian
		<input width="20px" type='radio' name='dish_category' value='Cuban' id="Cuban"/> Cuban
		<input width="20px" type='radio' name='dish_category' value='Tibetan' id="Tibetan"/> Tibetan
		<input width="20px" type='radio' name='dish_category' value='Egyptian' id="Egyptian"/> Egyptian
		<input width="20px" type='radio' name='dish_category' value='Greek' id="Greek"/> Greek
		<input width="20px" type='radio' name='dish_category' value='Belgians' id="Belgians"/> Belgians
		<input width="20px" type='radio' name='dish_category' value='Irish' id="Irish"/> Irish
		<input width="20px" type='radio' name='dish_category' value='Welsh' id="Welsh"/> Welsh
		<input width="20px" type='radio' name='dish_category' value='Mormon' id="Mormon"/> Mormon
		<input width="20px" type='radio' name='dish_category' value='Cajun' id="Cajun"/> Cajun
		<input width="20px" type='radio' name='dish_category' value='Portuguese' id="Portuguese"/> Portuguese
		<input width="20px" type='radio' name='dish_category' value='Turkish' id="Turkish"/> Turkish
		<input width="20px" type='radio' name='dish_category' value='Haitian' id="Haitian"/> Haitian
		<input width="20px" type='radio' name='dish_category' value='Tahitian' id="Tahitian"/> Tahitian
		<input width="20px" type='radio' name='dish_category' value='Kenyan' id="Kenyan"/> Kenyan
		<input width="20px" type='radio' name='dish_category' value='Korean' id="Korean"/> Korean
		<input width="20px" type='radio' name='dish_category' value='Algerian' id="Algerian"/> Algerian
		<input width="20px" type='radio' name='dish_category' value='Nigerian' id="Nigerian"/> Nigerian
		<input width="20px" type='radio' name='dish_category' value='Libyan' id="Libyan"/> Libyan <br>
		<!-- Other <input width="250px" type="text" name="dish_category" /> -->
		</div>
			</div>
		
		<p class="col-md-12" style="color: blue">Hold down the Ctrl (windows) / Command (Mac) button to select multiple options.</p>
			<div class="col-md-9" style="float:center"><label class="col-md-3">Allergen(s)</label> 
			<select  style="width:40%" name="dish_allergen" multiple>
				  <option value="Eggs">Eggs</option>
				  <option value="Wheat">Wheat</option>
				  <option value="Peanuts">Peanuts</option>
				  <option value="Tree Nuts">Tree Nuts</option>
				     <option value="Soy">Soy</option>
				   <option value="Fish">Fish</option>
				    <option value="Shellfish">Shellfish</option>
				  <option value="Gluten Free">Gluten Free</option>
				  <option value="Dairy">Dairy</option>
		   </select>
				  Other <input width="250px" type="text" name="dish_allergen" />
     	   </div>

     	<div class="col-md-9"><label class="col-md-3">Diet(s)</label> 
			<select style="width:40%" name="dish_health" multiple>
				  <option value="Gluten Free">Gluten Free</option>
				  <option value="Kosher">Kosher</option>
				  <option value="Low Fat">Low Fat</option>
				  <option value="Low carbohydrate">Low carbohydrate</option>
				  <option value="Low Carb">Low Carb</option>
				  <option value="Halal">Halal</option>
				  <option value="Vegetarian">Vegetarian</option>
				  <option value="Vegan">Vegan</option>
				  <option value="Fruitarian">Fruitarian</option>
				  <option value="Flexitarian">Flexitarian</option>
				  <option value="Pescetarian">Pescetarian</option>
				  <option value="Plant-based">Plant-based</option>
				  <option value="Weight control">Weight control</option>
				  <option value="Body for Life">Body for Life</option>
				  <option value="Belief-based">Belief-based</option>
				  <option value="High-protein">High-protein</option>
		 </select>
			Other <input width="250px" type="text" name="dish_health" />
		</div>
			
			<div class="col-md-12"><label class="col-md-3">$ Price *</label> <input type="text" name="dish_full_price" 
			class="col-md-1" placeholder="0.00 or 00.00"  pattern="^\d+(\.)\d{2}$" required="required"/></div> 
			
			<p class="col-md-12" style="color: blue">Customized Options</p>	
			<div class="col-md-12"><label class="col-md-3">Command </label> 
			<input type="text"   placeholder="ex.Choose a bread,meat,dressings and upto 3 toppings"
			name="dish_command" class="col-md-6" required="required"/></div>
			<table id="dataTable" class="col-md-12" style="text-align: center;">
			        <tr>
			            <td>
			            <div id='TextBoxesGroup5' class="col-md-12">
						<div id="TextBoxDiv5">
						 <label>#1 Choose a </label>
						 <input style="width:20%" type='text' id='item1' name="item" placeholder="protein,cheese,bread, other.,">
						  <label>Item Name </label>
						 <input style="width:20%" type='text' id='type1' name="type" placeholder="white bread,swiss cheese, other.,">
						  <label>$ Item Price </label>
						 <input style="width:20%" type='text' id='price1' name="price" placeholder="0.00 or 00.00"  pattern="^\d+(\.)\d{2}$">
						</div>
					</div>
			            </td>
			        </tr>
			
			<div class="col-md-12" style="margin-top: 10px;margin-bottom: 10px;">
			<input type='button' value='Add More' id='addButton'>
			<input type='button' value='Remove' id='removeButton'>
			</div>
			</table>
			<br>
			<div class="col-md-12" style="margin-top: 10px;margin-bottom: 10px;">
		<input type="submit" value="Add New Dish" class="btn btn-primary btn-lg"/></div>
		</form>
		</div>
			
		<script src="../js/jquery.min.js" type="text/javascript"></script>
	<script src="../js/bootstrap.min.js" type="text/javascript"></script>
	<script src="../js/restaurant.js" type="text/javascript"></script>
	<form action="${pageContext.request.contextPath}/Logout"
		id="logoutForm" method="post"></form>
	<script type="text/javascript">
$( "#logout" ).click(function() {
	  $( "#logoutForm" ).submit();
});
</script>
</body>
</html>