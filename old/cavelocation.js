var cavechoose = function () {
		if (key == 0) {
			if ((Math.random() * 100) + 1 <= 20) {
				confirm("You are attacked by a spider-skeleton-dungeon-keeper at the entrance!");
				if (armor >= 16 && weapon >= 12) {
					confirm('You kill the spider-skeleton. Let\'s enter.');
					cavechoose()
				} else {
					confirm('You were too weak to fight the spider-skeleton-dungeon-keeper. Get better equipment');
					townchoose()
				}
			} else {
				confirm('we have entered the cave.')
				confirm('it\'s dark, you cant see anything')
				question = prompt("Flames ignite besides you down a long corridor that lead towards two large doors. Enter?").toUpperCase();
				if (question == "YES") {
					confirm("You go throught the doors, as they close behind you, you find yourself in a massive chamber with a large world-devourer infront of you!");
					if (armor >= 30 && weapon >= 30) {
						confirm('You slice the devourer in two. killing it instantly because of your massive strength. YOU WIN!');
						key += 1;
						win()
					} else {
						confirm('The devourer expands his long putrid body out of the a massive hole in the wall, charging at you')
						if (armor >= 19 && weapon >= 10) {
							prompt('Attack or defend?', 'attack, defend').toUpperCase();
							if (question == "ATTACK" && weapon >= 12) {
								confirm('You destroy the devourer with one massive plasma blast. YOU WIN');
								win()
							} else {
								confirm('You defend against the mighty creature - but as you do, it begins circling around you. As a final resort you unleash all of your power, killing you and the creature, curing the world of the the devourer. You win the ULTIMATE HERO ENDING');
								confirm('Thank you for playing' + name + '!');
								$("#mainh").html(name + ' the hero');
								reset()
							}
						} else {
							confirm('You were too weak to defend yourself. The devourer eats you up in one large gulp. Game Over. Try getting better gear');
							money -= 30;
							check()
							console.log(money);
							townchoose();
						}
					}
				} else if (question == "NO") {
					confirm("You run out of the cave and back to the town");
					townchoose()
				} else {
					confirm('not an option. You are pushed out of the cave');
					townchoose()
				}
			}
		} else {
			confirm('there is nothing here for you');
			townchoose()
		}
	} //end of cavechoose
