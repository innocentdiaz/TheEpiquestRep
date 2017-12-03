$('body').ready(function () {
	$('#controls').hide()
	$('#commies').hide()
});
//defines the input and current function globally
var question;
var current;
//defines audios
var mario = new Audio("dire.mp3");
var user = { //this is the player
	user.name: "",
	user.lvl: 1,
	user.xp: 0,
	user.inventory: [],
	user.money: 0,
	user.safe: 0,
	user.rod: 0,
	user.armor: 0,
	user.weapon: 0,
	user.key: 1
};
//..info of player
var user.name = user.user.name;
var user.lvl = user.user.lvl;
var user.xp = user.user.xp;
var user.inventory = user.user.inventory;
var user.money = user.user.money;
var user.safe = user.user.safe;
var user.rod = user.user.rod;
var user.armor = user.user.armor;
var user.weapon = user.user.weapon;
var user.key = user.user.key; //while user.key == 1 you cannot fight the boss
//array of available fish
var fishes = ["Guppy", "SnakeFish", "DragonFish", "Boot", "Tuna", "GoldFish", "Guaba", "Man-eating snail", "Goblin shark"];
//array of outcome of swimming. has description, user.money and/or items
var swimmingOutcomes = [
	["Dived and came out with sand..", 0],
	["Dived in and found a sack of coins!", 30],
	["Dived in and found a gold ring! It's going in your user.inventory", 0, "Gold ring"],
	["Dived in and found a boot, It's useless", 0],
	["Dived in and found a small sack of coins!", 10],
	["Dived in and came out with nothing", 0],
	["Dived in and came out with a large sack of coins!", 45],
	["Dived in and came out with a book.", 0, "Book"]
];

function start() {
	$('#controls').show();
	$('#commies').show();
	$(".button").hide();
	displayToPlayer("What is your user.name?");
	current = function () {
		user.name = question;
		displayToPlayer("Let us begin, " + user.name + "!");
		setTimeout(function () {
			displayToPlayer('Where do you want to go?');
		}, 1500);
		current = function () {
			if (question.toUpperCase() == "TOWN") {
				townchoose();
			} else if (question.toUpperCase() == "BEACH") {
				beachchoose();
			} else {
				displayToPlayer("Unknown location - you wander off and end up at the beach")
				setTimeout(function () {
					beachchoose();
				}, 1500)
			}
		}
	}
};

function win() {//this is the winning function
	document.getElementById('mainh').innerHTML = (user.name);
	user.armor = 123;
	user.weapon = 98;
	user.lvl = 50;
	user.xp = 0;
	user.money += 500;
	user.rod = -100;
	alert('Your user.name: ' + user.name + '\bYour user.money: ' + user.money + '\b Your user.Safe: ' + user.safe + '\b Your user.rod dmg: ' + user.rod + '\b Your user.xp: ' + user.xp + '\b Your user.lvl: ' + user.lvl);
	displayToPlayer("You are the strongest hero go back to town?")
	current = function () {
		if (question == "YES") {
			townchoose()
		} else {
			displayToPlayer('Thank you for playing, ' + user.name + '!')
		}
	} //current
};
var check = function () {//this checks if user.xp is over 10 or user.money is less than 0
	if (user.xp >= 10) {
		user.lvl += 1;
		confirm("You have leveled up to level " + user.lvl + "!");
		user.xp -= 10;
		if (user.lvl == 2) {
			confirm('You can now go to the forest')
		} else if (user.lvl == 3) {
			confirm('You can now venture into the cave... At your own risk...');
		}
	}
	if (user.money < 0) {
		user.money = 0
	}
};
