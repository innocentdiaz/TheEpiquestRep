var townchoose = function () {

		if (lvl >= 3) {
			document.getElementById('display').innerHTML = "=TOWN= Work, fix, sell, safe, beach, forest, cave =TOWN="
		} else if (lvl == 2) {
			document.getElementById('display').innerHTML = "=TOWN= Work, fix, sell, safe, beach, forest =TOWN="
		} else {
			document.getElementById('display').innerHTML = "=TOWN= Work, fix, sell, safe, beach =TOWN="
		}
		current = function () {

			if (question.toUpperCase() == "WORK") {
				choosework();
			} else if (question.toUpperCase() == "FIX") {
				current = function () {
					document.getElementById('display').innerHTML = "Fixing your rod will cost you " + rod + " money. Are you sure?";
					if (question.toUpperCase() == "YES") {
						if (money >= rod) {
							money -= rod;
							rod = 0;
							document.getElementById('display').innerHTML = "You have " + money + " money and " + rod + " dmg!";
							setTimeout(function () {
								townchoose();
							}, 2000);
						} else if (money <= rod) {
							document.getElementById('display').innerHTML = 'Not enough money';
							setTimeout(function () {
								townchoose();
							}, 2000);
						}
					} else if (question.toUpperCase() == 'NO') {
						townchoose()
					}
				} //end of current when fix
				current()
			} else if (question.toUpperCase() == "SELL" && inventory.length >= 1) {
				current = function () {
					document.getElementById('display').innerHTML = "your items are: " + inventory.join(', ') + ". Sell?";
					if (question.toUpperCase() == "YES") {
						money = money + inventory.length * 2.5;
						for (i = 0; i < inventory.length; i++) {
							delete inventory[i]
						};
						inventory.length = 0;
						document.getElementById('display').innerHTML = "You have sold all your items. Your money is " + money + ".";
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
			} else if (question.toUpperCase() == "SELL" && inventory.length < 1) {
				document.getElementById('display').innerHTML = "You have no items in your inventory..";
				setTimeout(function () {
					townchoose()
				}, 1800);
			} else if (question.toUpperCase() == "STATS") {
				document.getElementById('display').innerHTML = 'Your name: ' + name + '\b Your money: ' + money + '\b Your Safe: ' + safe + '\b Your rod dmg: ' + rod + '\b Your xp: ' + xp + '\b Your lvl: ' + lvl + '\b Your armor: ' + armor + "\b Your weapon: " + weapon;
				setTimeout(function () {
					townchoose()
				}, 5555);
			} else if (question.toUpperCase() == "BEACH") {
				beachchoose()
			} else if (question.toUpperCase() == "FOREST" && lvl >= 2) {
				document.getElementById('display').innerHTML = "We are on our way to the enchanted forest.......";
				setTimeout(function () {
					forestchoose()
				}, 1500);
			} else if (question.toUpperCase() == "CAVE" && lvl >= 3) {
				document.getElementById('display').innerHTML = "We are on our way to the cave.......";
				setTimeout(function () {
					cavechoose()
				}, 1500);
			} else if (question.toUpperCase() == "SAFE") {
				current = function () {
					document.getElementById('display').innerHTML = "Store your money or recover it?";
					if (question.toUpperCase() == "STORE") {
						if (money >= 1) {
							safe += money;
							money = 0;
							document.getElementById('display').innerHTML = 'You stored all your money in the safe';
							setTimeout(function () {
								townchoose()
							}, 1500);
						} else {
							document.getElementById('display').innerHTML = 'You have no money!';
							setTimeout(function () {
								townchoose()
							}, 1500);
						}
					} else if (question.toUpperCase() == "RECOVER") {
						if (safe >= 1) {
							money += safe;
							safe = 0;
							document.getElementById('display').innerHTML = 'You recovered all your money from the safe';
							setTimeout(function () {
								townchoose()
							}, 1500);
						} else {
							document.getElementById('display').innerHTML = 'There is nothing in the safe!';
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
					document.getElementById('display').innerHTML = "You go to the library and help out with storing while you've gained experience from reading. Also you get paid";
					money += 25;
					xp += 1;
					console.log('You have ' + xp + 'xp! ' + ' Money:' + money);
					check();
					setTimeout(function () {
						townchoose();
					}, 2500);
				} else if ((Math.random() * 10) + 1 >= 8) {
					document.getElementById('display').innerHTML = "While looking for a job you get robbed. You lose 10 money!";
					money -= 10;
					check();
					console.log('Money: ' + money);
					setTimeout(function () {
						townchoose();
					}, 2500);
				} else if ((Math.random() * 10) + 1 <= 4) {
					document.getElementById('display').innerHTML = "You work at the pub and get paid 15 money!";
					money += 15;
					console.log("Money: " + money);
					setTimeout(function () {
						townchoose();
					}, 2500);
				} else if ((Math.random() * 10) + 1 <= 7) {
					document.getElementById('display').innerHTML = "You go to the local car wash and gain some experience!";
					xp += 1;
					console.log('You have ' + xp + 'xp! ');
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
