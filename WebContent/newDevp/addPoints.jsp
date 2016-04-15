<!DOCTYPE html>
<html>
<title>Add Points</title>
<div id="result"></div>
<script>
var selectedValue = "";
function changeFunc() {
	var temp = "25";
    var selectBox = document.getElementById("selectBox");
    selectedValue = selectBox.options[selectBox.selectedIndex].value;
   // alert(selectedValue);
  
//Check browser support
if (typeof(Storage) !== "undefined") {
	if(selectedValue == "Mini Plan") selectedValue = "25";
	else if(selectedValue == "Medium Plan") selectedValue = "50";
	else if(selectedValue == "Large Plan") selectedValue = "100";
	else if(selectedValue == "Premium Plan") selectedValue = "175";
    // Store
    localStorage.setItem("points", selectedValue);
    // Retrieve
    document.getElementById("result").innerHTML = localStorage.getItem("points");
} else {
    document.getElementById("result").innerHTML = "Sorry, your browser does not support Web Storage...";
}
}

function setVal(){
	if(selectedValue == ""){
		localStorage.setItem("points", "25");	
	}
}
</script>
</head>
<body>
<div style="text-align: center;">
<% 
String msg = (String)session.getAttribute("message");
if(msg != null){
%><h4><%=msg%></h4><%}%>
<form action="https://www.paypal.com/cgi-bin/webscr" method="post"
target="_top">
<input type="hidden" name="cmd" value="_s-xclick"> <input
type="hidden" name="hosted_button_id" value="QM2U39HHQ6LLG">
<table align="center">
<tr>
<td><input type="hidden" name="on0" value="Meal Plans">Meal Plans</td>
</tr>
<tr>
<td><select name="os0" id="selectBox" onchange="changeFunc();">
<option value="Mini Plan">Mini Plan</option>
<option value="Medium Plan">Medium Plan</option>
<option value="Large Plan">Large Plan</option>
<option value="Premium Plan">Premium Plan</option>
</select></td>
</tr>
</table>
<input type="hidden" name="currency_code" value="USD"> <input onclick="setVal()"
type="image"
src="https://www.paypalobjects.com/en_US/i/btn/btn_buynowCC_LG.gif"
border="0" name="submit"
alt="PayPal - The safer, easier way to pay online!"> <img
alt="" border="0"
src="https://www.paypalobjects.com/en_US/i/scr/pixel.gif" width="1"
height="1">
</form>
</div>
<img src="https://www.paypalobjects.com/webstatic/en_US/i/buttons/cc-badges-ppmcvdam.png" alt="Buy now with PayPal" />
</body>
</html>