var beachchoose = function () {
		displayToPlayer("We are at the beach. Fish, swim, or leave?")
		current = function () {
			//this will make the input input.value
			//if you choose to fish
			if (question.toUpperCase() == "FISH") {
				if (rod <= 15) {
					displayToPlayer("You go to fish!")
					//function to fish .. in case you want to fish directly
					var fishing = function () {
							if (rod <= 15) {
								MathRandom = Math.floor(Math.random() * fishes.length + 1);
								if (MathRandom >= fishes.length) {
									displayToPlayer("You were attacked by a sea glob fish! You lost 10 money and now have +3 rod damage. Try again?")
									rod += 3;
									money -= 10;
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
									displayToPlayer(name + " caught a " + fishes[MathRandom] + "! It's going in your inventory. Try again?");
									inventory.push(fishes[MathRandom])
									current = function () {
										if (question.toUpperCase() == "YES") {
											fishing()
										} else if (question.toUpperCase() == "NO") {
											beachchoose()
										}
									}
								}
							} else {
								displayToPlayer("Your rod has " + rod + " damage! Go fix it at the town!");
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
					displayToPlayer(rod + "dmg");
					beachchoose()
				}
			} else if (question.toUpperCase() == "SWIM") {
				//SWIMMING WILL WORK LIKE THIS
				//Array of swimmingPosibilites will be made
				//Array of arrays
				//Each array array will contain the posibility and how much money you will gain/lose
				//example
				/*
				swimmingPossibilities = [["Found gold while diving", 15],["Attacked by shark, lost 2 gold", -2]]
				*/
				displayToPlayer("You go swimming..")
				var swimming = function () {
					MathRandom = Math.floor(Math.random() * swimmingOutcomes.length + 1)
					if (MathRandom >= swimmingOutcomes.length) {
						displayToPlayer(name + " was stung by a deadly jelly fish! You lost half of your money at the town hospital")
						money /= 2;
						setTimeout(function () {
							townchoose()
						}, 3000)
					} else {
						displayToPlayer(swimmingOutcomes[MathRandom][0] + ". Dive in again?")
						money += swimmingOutcomes[MathRandom][1]
						check()
						if (swimmingOutcomes[MathRandom][2]) { //this outcome also adds to your inventory
							setTimeout(function () {
								inventory.push(swimmingOutcomes[MathRandom][2])
								displayToPlayer("Added " + swimmingOutcomes[MathRandom][2] + " to inventory")
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
