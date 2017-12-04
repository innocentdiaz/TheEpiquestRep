var submit = function (event) { //WHEN YOU CLICK ENTER
    var keyCode = event.keyCode;
	if (keyCode == 13) {
		question = $("#inputBox").val();
		$("#inputBox").val("");
		current();
		console.log('question = ' + question);
	}
};