var townchoose = function () {
	if (user.lvl >= 3) {
		document.getElementById('display').innerHTML = "=TOWN= Work, fix, sell, user.safe, beach, forest, cave =TOWN="
	} else if (user.lvl == 2) {
		document.getElementById('display').innerHTML = "=TOWN= Work, fix, sell, user.safe, beach, forest =TOWN="
	} else {
		document.getElementById('display').innerHTML = "=TOWN= Work, fix, sell, user.safe, beach =TOWN="
	}
	current = function () {
		if (question.toUpperCase() == "WORK") {
			choosework();
		} else if (question.toUpperCase() == "FIX") {
			current = function () {
				document.getElementById('display').innerHTML = "Fixing your user.rod will cost you " + user.rod + " user.money. Are you sure?";
				if (question.toUpperCase() == "YES") {
					if (user.money >= user.rod) {
						user.money -= user.rod;
						user.rod = 0;
						document.getElementById('display').innerHTML = "You have " + user.money + " user.money and " + user.rod + " dmg!";
						setTimeout(function () {
							townchoose();
						}, 2000);
					} else if (user.money <= user.rod) {
						document.getElementById('display').innerHTML = 'Not enough user.money';
						setTimeout(function () {
							townchoose();
						}, 2000);
					}
				} else if (question.toUpperCase() == 'NO') {
					townchoose()
				}
			} //end of current when fix
			current()
		} else if (question.toUpperCase() == "SELL" && user.inventory.length >= 1) {
			current = function () {
				document.getElementById('display').innerHTML = "your items are: " + user.inventory.join(', ') + ". Sell?";
				if (question.toUpperCase() == "YES") {
					user.money = user.money + user.inventory.length * 2.5;
					for (i = 0; i < user.inventory.length; i++) {
						delete user.inventory[i]
					};
					user.inventory.length = 0;
					document.getElementById('display').innerHTML = "You have sold all your items. Your user.money is " + user.money + ".";
					setTimeout(function () {
						townchoose()
					}, 2000);
				} else if (question.toUpperCase() == "NO") {
					setTimeout(function () {
						townchoose()
					}, 2000);
				}
			} //end of current when SELL
			current()
		} else if (question.toUpperCase() == "SELL" && user.inventory.length < 1) {
			document.getElementById('display').innerHTML = "You have no items in your user.inventory..";
			setTimeout(function () {
				townchoose()
			}, 1800);
		} else if (question.toUpperCase() == "STATS") {
			document.getElementById('display').innerHTML = 'Your user.name: ' + user.name + '\b Your user.money: ' + user.money + '\b Your user.Safe: ' + user.safe + '\b Your user.rod dmg: ' + user.rod + '\b Your user.xp: ' + user.xp + '\b Your user.lvl: ' + user.lvl + '\b Your user.armor: ' + user.armor + "\b Your user.weapon: " + user.weapon;
			setTimeout(function () {
				townchoose()
			}, 5555);
		} else if (question.toUpperCase() == "BEACH") {
			beachchoose()
		} else if (question.toUpperCase() == "FOREST" && user.lvl >= 2) {
			document.getElementById('display').innerHTML = "We are on our way to the enchanted forest.......";
			setTimeout(function () {
				forestchoose()
			}, 1500);
		} else if (question.toUpperCase() == "CAVE" && user.lvl >= 3) {
			document.getElementById('display').innerHTML = "We are on our way to the cave.......";
			setTimeout(function () {
				cavechoose()
			}, 1500);
		} else if (question.toUpperCase() == "user.SAFE") {
			current = function () {
				document.getElementById('display').innerHTML = "Store your user.money or recover it?";
				if (question.toUpperCase() == "STORE") {
					if (user.money >= 1) {
						user.safe += user.money;
						user.money = 0;
						document.getElementById('display').innerHTML = 'You stored all your user.money in the user.safe';
						setTimeout(function () {
							townchoose()
						}, 1500);
					} else {
						document.getElementById('display').innerHTML = 'You have no user.money!';
						setTimeout(function () {
							townchoose()
						}, 1500);
					}
				} else if (question.toUpperCase() == "RECOVER") {
					if (user.safe >= 1) {
						user.money += user.safe;
						user.safe = 0;
						document.getElementById('display').innerHTML = 'You recovered all your user.money from the user.safe';
						setTimeout(function () {
							townchoose()
						}, 1500);
					} else {
						document.getElementById('display').innerHTML = 'There is nothing in the user.safe!';
						setTimeout(function () {
							townchoose()
						}, 1500);
					}
				}
			} //end of store/recover
			current()
		} else {
			confirm("Thats not an option");
			townchoose();
		}
	} //end of current, when you toenchoose
}; //townchoose
var choosework = function () {
		current = function () {
			if ((Math.random() * 10) + 1 <= 2) {
				document.getElementById('display').innerHTML = "You go to the library and help out with storing while you've gained euser.xperience from reading. Also you get paid";
				user.money += 25;
				user.xp += 1;
				console.log('You have ' + user.xp + 'user.xp! ' + ' user.Money:' + user.money);
				check();
				setTimeout(function () {
					townchoose();
				}, 2500);
			} else if ((Math.random() * 10) + 1 >= 8) {
				document.getElementById('display').innerHTML = "While looking for a job you get robbed. You lose 10 user.money!";
				user.money -= 10;
				check();
				console.log('user.Money: ' + user.money);
				setTimeout(function () {
					townchoose();
				}, 2500);
			} else if ((Math.random() * 10) + 1 <= 4) {
				document.getElementById('display').innerHTML = "You work at the pub and get paid 15 user.money!";
				user.money += 15;
				console.log("user.Money: " + user.money);
				setTimeout(function () {
					townchoose();
				}, 2500);
			} else if ((Math.random() * 10) + 1 <= 7) {
				document.getElementById('display').innerHTML = "You go to the local car wash and gain some euser.xperience!";
				user.xp += 1;
				console.log('You have ' + user.xp + 'user.xp! ');
				check();
				setTimeout(function () {
					townchoose();
				}, 2500);
			} else {
				document.getElementById('display').innerHTML = "No one wants to hire you! Tough luck.";
				setTimeout(function () {
					townchoose();
				}, 2500);
			}
		} //end of current when choose work
		current()
	} //end of choosework
