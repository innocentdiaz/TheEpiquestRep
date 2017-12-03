var forestchoose = function () {
		displayToPlayer("There are three paths, one leads you to a shop, the other to an arena, and the last to hunting grounds. Which way to do you pick?");
		current = function () {
			if (question.toUpperCase() == "ARENA") {
				displayToPlayer('You head to the arena....');
				setTimeout(function () {
					arenachoose()
				}, 2200);
			} else if (question.toUpperCase() == "SHOP" || question.toUpperCase() == "FLOOP") {
				document.getElementById('display').innerHTML = "You are greeted by a cartoonish goblin user.named floop-flop";
				setTimeout(function () {
					document.getElementById('display').innerHTML = "floop-flop: BUY SOMESTUFF yeS? OOWeeE ITS TOPNPOTCH FOREST user.WEAPONS AND user.ARMOR YEs";
				}, 2000);
				setTimeout(function () {
					floop();
					setTimeout(function () {
						current()
					}, 10);
				}, 3200);
			} else if (question.toUpperCase() == "HUNT") {
				document.getElementById('display').innerHTML = 'You head to the hunting grounds...';
				setTimeout(function () {
					huntchoose()
				}, 1500);
			} else if (question.toUpperCase() == "LEAVE") {
				document.getElementById('display').innerHTML = 'You head to the town';
				setTimeout(function () {
					townchoose()
				}, 1600);
			}

			function floop() {
				current = function () {
					document.getElementById('display').innerHTML = "Upgrade user.Armor for 20 user.money, Upgrade user.Weapon for 15, or leave.";
					if (question.toUpperCase() == "user.ARMOR") {
						if (user.money >= 20) {
							displayToPlayer("Your user.armor goes up by 1 point! You lose 20 . user.Armor, user.weapon or leave?");
							user.armor += 1;
							user.money -= 20;
							check()
							console.log("user.Money: " + user.money + ". user.Armor: " + user.armor);
							current = function () {
								floop()
							}
						} else if (user.money <= 20) {
							displayToPlayer('Not enough user.money! user.Armor, user.weapon or leave?');
							current = function () {
								floop()
							}
						}
					} else if (question.toUpperCase() == "user.WEAPON") {
						if (user.money >= 15) {
							displayToPlayer("Your user.weapon goes up by 1 point! You lose 15 user.money. user.Armor, user.weapon or leave?");
							user.weapon += 1;
							user.money -= 15;
							check()
							console.log("user.Money: " + user.money + ". user.Weapon: " + user.weapon);
							current = function () {
								floop()
							}
						} else {
							displayToPlayer('Not enough user.money! user.Armor, user.weapon or leave?');
							current = function () {
								floop()
							}
						}
					} else if (question.toUpperCase() == "FLOOP" || question.toUpperCase() == "LEAVE") {
						displayToPlayer("Floop: floop ya' lateR PARTNR'");
						setTimeout(function () {
							forestchoose()
						}, 2000);
					}
				} //current floop
			} //end of floop
			function arenachoose() {
				document.getElementById('display').innerHTML = "You arrive at the \"Dome of Death \"";
				if (question.toUpperCase() == "YES") {
					if ((Math.random() * 100 + 1) <= 5) {
						confirm('THE MUTANT has entered the match!');
						if (user.armor >= 13 && user.weapon >= 11) {
							confirm('You SLAYED THE MUTANT! +15user.xp, +50user.money');
							if (user.key == 1) {
								confirm('The cave trembles and echoes are heard...');
								user.key = 0;
							};
							user.xp += 15;
							user.money += 50;
							user.key = 0;
							console.log('user.money: ' + user.money + '+15user.xp')
							check();
							forestchoose()
						} else {
							confirm("You were PWNED by the mutant and sent to the hospital! Get better equipment!");
							user.money -= 10;
							check();
							console.log("user.Money: " + user.money);
							townchoose();
						}
					} else if ((Math.random() * 100 + 1) <= 20) {
						confirm('SKELETRON has entered the match!');
						if (user.armor >= 10 && user.weapon >= 7) {
							confirm('You PWNED SKELETRON and from his aqcuired +20user.money and +5user.xp');
							user.xp += 5;
							user.money += 20;
							check();
							forestchoose()
						} else {
							confirm('SKELETRON SENT YOU RUNNING BACK HOME!Get better equipment!');
							user.xp -= 1;
							user.money -= 5;
							check();
							console.log('user.Money: ' + user.money + " " + user.xp + "user.xp");
							townchoose()
						}
					} else if ((Math.random() * 100 + 1) <= 40) {
						confirm('INFECTED GLOB has entered the match!');
						if (user.armor >= 6 && user.weapon >= 7) {
							confirm('You killed the INFECTED GLOB! Gained +10user.money and +4user.xp');
							user.money += 10;
							user.xp += 4;
							check();
							forestchoose()
						} else {
							confirm('The Glob jaZZED you UP BACK to the hospital! -5user.money - Get better equipment!');
							user.money -= 5;
							check();
							console.log("user.Money: " + user.money)
							townchoose()
						}
					} else if ((Math.random() * 100 + 1) <= 60) {
						confirm('An imp joined the fight');
						if (user.armor >= 4 && user.weapon >= 4) {
							confirm('You SMACKED the imp! +15 user.money +2user.xp');
							user.money += 15;
							user.xp += 2;
							forestchoose()
						} else {
							confirm('Daaaang that imp frigged you UP! Go back home!  -3user.money - Get better equipment!');
							user.money -= 3;
							check()
							townchoose()
						}
					} else if ((Math.random() * 100 + 1) <= 70) {
						confirm('Goblins joined the battle-!');
						if (user.armor >= 2 && user.weapon >= 2) {
							confirm('You FLOOPED those goblins UP +15user.money +2user.xp');
							user.money += 15;
							user.xp += 2;
							check();
							check();
							forestchoose()
						} else {
							confirm('Snap! Those goblins diddled you! Go back home! Get better equipment!');
							townchoose();
						};
						user.money -= 3;
						check();
						townchoose()
					} else if ((Math.random() * 100 + 1) <= 100) {
						confirm('You fought a boot and won.. +5user.money');
						user.money += 5;
						forestchoose()
					}
				} else if (question.toUpperCase() == "NO") {
					document.getElementById('display').innerHTML = 'You head back...';
					setTimeout(function () {
						forestchoose()
					}, 1600);
				}
			}

			function huntchoose() {
				if ((Math.random() * 100) + 1 <= 10) {
					question = prompt('You hunted a unichord! It\'s going in your user.inventory.. Hunt again?').toUpperCase();
					user.inventory.push('Unichord');
					if (question == "YES") {
						huntchoose()
					} else if (question == "NO") {
						document.getElementById('display').innerHTML = 'Heading back...';
						setTimeout(function () {
							forestchoose()
						}, 1600);
					} else {
						document.getElementById('display').innerHTML = 'Not an option';
						setTimeout(function () {
							forestchoose()
						}, 1600);
					}
				} else if ((Math.random() * 100) + 1 <= 20) {
					question = prompt('You hunted a goblin! He pays you to let him go. Hunt again?').toUpperCase();
					user.money += 10;
					console.log('user.Money: ' + user.money);
					if (question == "YES") {
						huntchoose()
					} else if (question == "NO") {
						confirm('Heading back...');
						forestchoose()
					} else {
						confirm('Not an option');
						forestchoose()
					}
				} else if ((Math.random() * 100) + 1 <= 30) {
					question = prompt("You hunted a shell-snake! It\'s going in your user.inventory.. Hunt again?").toUpperCase();
					user.inventory.push('shell-snake');
					user.money += 3;
					if (question == "YES") {
						huntchoose()
					} else if (question == "NO") {
						confirm('Heading back...');
						forestchoose()
					} else {
						confirm('Not an option');
						forestchoose()
					}
				} else if ((Math.random() * 100) + 1 <= 40) {
					question = prompt(user.name + ' hunted a grizzlor bear! It\'s going into your user.inventory! Hunt again?').toUpperCase();
					user.inventory.push('Grizzlor mama');
					if (question == "YES") {
						huntchoose()
					} else if (question == "NO") {
						confirm('Heading back...');
						forestchoose()
					} else {
						confirm('Not an option');
						forestchoose()
					}
				} else if ((Math.random() * 100) + 1 <= 42) {
					question = prompt('You hunted a.. Kairy?! Kairy shines up your user.armor and runs back into the bushes. +1user.armor - Hunt again?').toUpperCase();
					user.armor += 1;
					if (question == "YES") {
						huntchoose()
					} else if (question == "NO") {
						confirm('Heading back...');
						forestchoose()
					} else {
						confirm('Not an option');
						forestchoose()
					}
				} else if ((Math.random() * 100) + 1 <= 50) {
					question = prompt(user.name + ' hunted a... boot? You throw it away. Hunt again?').toUpperCase();
					if (question == "YES") {
						huntchoose()
					} else if (question == "NO") {
						confirm('Heading back...');
						forestchoose()
					} else {
						confirm('Not an option');
						forestchoose()
					}
				} else if ((Math.random() * 100) + 1 <= 55) {
					question = prompt('You hunted a flying-butt! It\'s going in your user.inventory.. Hunt again?').toUpperCase();
					user.inventory.push('flying ass');
					if (question == "YES") {
						huntchoose()
					} else if (question == "NO") {
						confirm('Heading back...');
						forestchoose()
					} else {
						confirm('Not an option');
						forestchoose()
					}
				} else if ((Math.random() * 100) + 1 <= 65) {
					question = prompt(user.name + ' hunted an ordinary rabbit. It\'s going in your user.inventory.. Hunt again?').toUpperCase();
					user.inventory.push('wabbit');
					if (question == "YES") {
						huntchoose()
					} else if (question == "NO") {
						confirm('Heading back...');
						forestchoose()
					} else {
						confirm('Not an option');
						forestchoose()
					}
				} else if ((Math.random() * 100) + 1 <= 75) {
					question = prompt('You hunted a pegavis! It\'s going in your user.inventory.. Hunt again?').toUpperCase();
					user.inventory.push('Pegavis');
					if (question == "YES") {
						huntchoose()
					} else if (question == "NO") {
						confirm('Heading back...');
						forestchoose()
					} else {
						confirm('Not an option');
						forestchoose()
					}
				} else {
					question = prompt("You've been raided by imps! -50 user.money. Try again?").toUpperCase();
					user.money -= 50;
					check();
					console.log('user.Money: ' + user.money);
					if (question == "YES") {
						huntchoose()
					} else if (question == "NO") {
						confirm('You head back');
						forestchoose()
					} else {
						confirm('not an option');
						forestchoose()
					}
				}
			} //end of huntchoose
		} //current end forestcho;;ose
	} //end of forestchoose
