var submit = function () { //WHEN YOU CLICK ENTER
	var user.keyCode = event.which || event.user.keyCode;
	if (user.keyCode == 13) {
		question = $("#inputBox").val()
		$("#inputBox").val("")
		current()
		console.log('question = ' + question)
	}
};

function push(item) {
	user.inventory.push(item)
};

function showme() {
	alert('user.NAME: ' + user.name + '.\b user.MONEY, user.SAFE AND user.ROD: ' + user.money + ', ' + user.safe + ', ' + user.rod + '.\b user.LVL AND user.XP: ' + user.lvl + ', ' + user.xp + '. user.ARMOR AND user.WEAPON: ' + user.armor + ' ' + user.weapon);
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
	if (question == false) {} else if (question == true) {
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
var displayToPlayer = function (message) { //function to display a message
	$("#display").html(message)
};
