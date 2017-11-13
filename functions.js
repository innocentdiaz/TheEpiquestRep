var submit = function () {//WHEN YOU CLICK ENTER
	var keyCode = event.which || event.keyCode;
    if(keyCode == 13){
		question = $("#inputBox").val()
		$("#inputBox").val("")
        current()
		console.log('question = ' + question)
        
    }
};

function push(item) {
	inventory.push(item)
};

function showme() {
	alert('NAME: ' + name + '.\b MONEY, SAFE AND ROD: ' + money + ', ' + safe + ', ' + rod + '.\b LVL AND XP: ' + lvl + ', ' + xp + '. ARMOR AND WEAPON: ' + armor + ' ' + weapon);
};

function playtheme(selected) {
	switch (selected) {
	case 'mario':
		mario.loop = true;
		mario.play();
		break;
	}
};

function reset() {
    question = confirm("Reset game?")
    if(question == false){

    }
    else if(question == true){
        location.reload()
    }

}

function nightmode() {
	$("body").css("background-color", "black")
	$("button").css("background-color", "grey")
	$("#display").css("border-color", "white")
};

function daymode() {
	$("body").css("background-color", "white")
	$("button").css("background-color", "green")
	$("#display").css("border-color", "black")
};

var displayToPlayer = function(message){//function to display a message
    $("#display").html(message)
};