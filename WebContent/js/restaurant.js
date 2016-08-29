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
				'<input style="width:20%" type="text" name="choices' + counter +
				'" id="sides' + counter + '" value="" placeholder="protein,cheese,bread, other.,">' + 
				'<label> Item Name</label><input style="width:20%" type="text" name="choices' + counter +
				'" id="sides' + counter + '" value="" placeholder="white bread,swiss chees, other.,">' +
				'<label> $ Item Price</label><input style="width:20%" type="text" name="choices' + counter +
				'" id="sides' + counter + '" value="" placeholder="0.00 or 00.00">');

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
});