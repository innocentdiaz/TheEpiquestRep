var beachchoose = function () {
		displayToPlayer("We are at the beach. Fish, swim, or leave?")
		current = function () {
			//this will make the input input.value
			//if you choose to fish
			if (question.toUpperCase() == "FISH") {
				if (user.rod <= 15) {
					displayToPlayer("You go to fish!")
					//function to fish .. in case you want to fish directly
					var fishing = function () {
							if (user.rod <= 15) {
								MathRandom = Math.floor(Math.random() * fishes.length + 1);
								if (MathRandom >= fishes.length) {
									displayToPlayer("You were attacked by a sea glob fish! You lost 10 user.money and now have +3 user.rod damage. Try again?")
									user.rod += 3;
									user.money -= 10;
									check();
									check();
									current = function () {
										if (question.toUpperCase() == "YES") {
											fishing()
										} else if (question.toUpperCase() == "NO") {
											beachchoose()
										}
									}
								} else {
									displayToPlayer(user.name + " caught a " + fishes[MathRandom] + "! It's going in your user.inventory. Try again?");
									user.inventory.push(fishes[MathRandom])
									current = function () {
										if (question.toUpperCase() == "YES") {
											fishing()
										} else if (question.toUpperCase() == "NO") {
											beachchoose()
										}
									}
								}
							} else {
								displayToPlayer("Your user.rod has " + user.rod + " damage! Go fix it at the town!");
								setTimeout(function () {
									beachchoose()
								}, 1500);
							}
						}
						//player chose to go fishing()
					setTimeout(function () {
						fishing()
					}, 1500);
				} else {
					displayToPlayer(user.rod + "dmg");
					beachchoose()
				}
			} else if (question.toUpperCase() == "SWIM") {
				//SWIMMING WILL WORK LIKE THIS
				//Array of swimmingPosibilites will be made
				//Array of arrays
				//Each array array will contain the posibility and how much user.money you will gain/lose
				//example
				/*
				swimmingPossibilities = [["Found gold while diving", 15],["Attacked by shark, lost 2 gold", -2]]
				*/
				displayToPlayer("You go swimming..")
				var swimming = function () {
					MathRandom = Math.floor(Math.random() * swimmingOutcomes.length + 1)
					if (MathRandom >= swimmingOutcomes.length) {
						displayToPlayer(user.name + " was stung by a deadly jelly fish! You lost half of your user.money at the town hospital")
						user.money /= 2;
						setTimeout(function () {
							townchoose()
						}, 3000)
					} else {
						displayToPlayer(swimmingOutcomes[MathRandom][0] + ". Dive in again?")
						user.money += swimmingOutcomes[MathRandom][1]
						check()
						if (swimmingOutcomes[MathRandom][2]) { //this outcome also adds to your user.inventory
							setTimeout(function () {
								user.inventory.push(swimmingOutcomes[MathRandom][2])
								displayToPlayer("Added " + swimmingOutcomes[MathRandom][2] + " to user.inventory")
							}, 1500)
						}
						setTimeout(function () {
							current = function () {
								if (question.toUpperCase() == "YES") {
									swimming()
								} else if (question.toUpperCase() == "NO") {
									beachchoose()
								}
							}
						}, 3200)
					}
				}
				setTimeout(swimming(), 1500) //swimming will be called when the player does "SWIM"
			} else if (question.toUpperCase() == "LEAVE") {
				displayToPlayer("going to town");
				setTimeout(function () {
					townchoose()
				}, 1600);
			}
		} //current when beachchoose
	} //beachchoose
