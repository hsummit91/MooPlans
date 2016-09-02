

$(document).ready(function(){

var counter = 2;


$("#addButton").click(function () {

if(counter>50){

alert("Only 50 textboxes allow");

return false;

}

var newTextBoxDiv = $(document.createElement('div'))

.attr("id", 'TextBoxDiv5' + counter);

newTextBoxDiv.after().html('<label>#'+ counter + ' Choose a </label>' +

'<input style="width:20%" type="text" name="item' + counter +

'" id="item' + counter + '" value="" placeholder="protein,cheese,bread, other.,">' + 

'<label> Item Name</label><input style="width:20%" type="text" name="type' + counter +

'" id="type' + counter + '" value="" placeholder="white bread,swiss chees, other.,">' +

'<label> $ Item Price</label><input style="width:20%" type="text" name="price' + counter +

'" id="price' + counter + '" value="" placeholder="0.00 or 00.00">');


newTextBoxDiv.appendTo("#TextBoxesGroup5");

counter++;

});



$("#removeButton").click(function () {

if(counter==1){

alert("No more textbox to remove");

return false;

}

counter--;

$("#TextBoxDiv5" + counter).remove();


});	

$("#surveyForm").submit(function(){

var msg = '';

var header = '';

var item1 = $('#item1').val();

for(i=1; i<counter; i++){

var str1 = $('#item' + i).val();


if(str1 != item1){

header = '#';

item1 = str1;

}

else

header = '';

msg += header + '{"'+$('#item' + i).val() + '",';

msg += '"'+$('#type' + i).val() + '",';

msg += '"'+$('#price' + i).val() + '"},';

}

var url = 'sides=#' + msg ;

alert(url);

//window.location = 'AddDishes?' + url;

//session(url);

});

});