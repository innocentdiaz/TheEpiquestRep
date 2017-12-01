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
	name: "",
	lvl: 1,
	xp: 0,
	inventory: [],
	money: 0,
	safe: 0,
	rod: 0,
	armor: 0,
	weapon: 0,
	key: 1
};
//..info of player
var name = user.name;
var lvl = user.lvl;
var xp = user.xp;
var inventory = user.inventory;
var money = user.money;
var safe = user.safe;
var rod = user.rod;
var armor = user.armor;
var weapon = user.weapon;
var key = user.key; //while key == 1 you cannot fight the boss
//array of available fish
var fishes = ["Guppy", "SnakeFish", "DragonFish", "Boot", "Tuna", "GoldFish", "Guaba", "Man-eating snail", "Goblin shark"];
//array of outcome of swimming. has description, money and/or items
var swimmingOutcomes = [
	["Dived and came out with sand..", 0],
	["Dived in and found a sack of coins!", 30],
	["Dived in and found a gold ring! It's going in your inventory", 0, "Gold ring"],
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
	displayToPlayer("What is your name?");
	current = function () {
		name = question;
		displayToPlayer("Let us begin, " + name + "!");
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
	document.getElementById('mainh').innerHTML = (name);
	armor = 123;
	weapon = 98;
	lvl = 50;
	xp = 0;
	money += 500;
	rod = -100;
	alert('Your name: ' + name + '\bYour money: ' + money + '\b Your Safe: ' + safe + '\b Your rod dmg: ' + rod + '\b Your xp: ' + xp + '\b Your lvl: ' + lvl);
	displayToPlayer("You are the strongest hero go back to town?")
	current = function () {
		if (question == "YES") {
			townchoose()
		} else {
			displayToPlayer('Thank you for playing, ' + name + '!')
		}
	} //current
};
var check = function () {//this checks if xp is over 10 or money is less than 0
	if (xp >= 10) {
		lvl += 1;
		confirm("You have leveled up to level " + lvl + "!");
		xp -= 10;
		if (lvl == 2) {
			confirm('You can now go to the forest')
		} else if (lvl == 3) {
			confirm('You can now venture into the cave... At your own risk...');
		}
	}
	if (money < 0) {
		money = 0
	}
};
