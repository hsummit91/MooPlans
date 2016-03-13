$( ".input" ).focusin(function() {
  $( this ).find( "span" ).animate({"opacity":"0"}, 200);
});

$( ".input" ).focusout(function() {
  $( this ).find( "span" ).animate({"opacity":"1"}, 300);
});

$(".login").submit(function(){
		  $(this).find(".submit i").removeAttr('class').addClass("fa fa-check").css({"color":"#fff"});
		  $(".submit").css({"background":"#2ecc71", "border-color":"#2ecc71"});
		  $(".feedback").css({"background":"#2ecc71", "color":"#fff"});
		  $(".feedback").show().animate({"opacity":"1", "bottom":"-80px"}, 400);
		  $("input").css({"border-color":"#2ecc71"});
		  $("#feedback").html("processing request..");
});

function checkError(){
	var isError = $("#isError").val();	
	console.log("---"+isError);
	
	if(isError == "true"){
		var message = $("#message").val();
		  $(this).find(".submit i").removeAttr('class').addClass("fa fa-check").css({"color":"#D8000C"});
		  $(".submit").css({"background":"#FFBABA", "border-color":"#FFBABA"});
		  $("#feedback").addClass("feedbackErr");
		  $("#feedback").css({"background":"#FFBABA", "color":"#D8000C"});
		  $("#feedback").show().animate({"opacity":"1", "bottom":"-80px"}, 400);
		  $("input").css({"border-color":"#FFBABA"});
		  $("#feedback").html(message);
	}
}