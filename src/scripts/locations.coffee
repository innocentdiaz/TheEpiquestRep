question = ''
current = ->
display = (msg) ->
	if typeof msg is 'string'
		(n) ->
			displayToPlayer msg
			n()
	else
		f = (n) ->
			displayToPlayer msg.shift()
			if msg.length then setTimeout f, game.delay, n
			else n()
cur = (c) ->
	(n) ->
		if typeof currents[c] is 'function'
			current = currents[c]
			$ '.buttons'
				.html ''
			butts = currents[c]._buttons
			if butts
				$ '#input'
					.hide()
				if typeof butts is 'function' then butts = butts()
				for text in butts
					text = text.split('->')
					$('.buttons').append $("<button>#{text[0]}</button>").click (
						(t) -> ->
							question = t
							current t
					)(text[1] || text[0])
			else $('#input').show()
		else
			current = ->
			$ '#input'
				.hide()
			$ '.buttons'
				.text ''
			butts = currents[c]._buttons
			if typeof butts is 'function' then butts = butts()
			for text in butts
				text = text.split('->')
				$('.buttons').append $("<button>#{text[0]}</button>").click (
					(f) -> ->
						f()
				)(currents[c][(text[1] || text[0]).toLowerCase()])
		n()
yesno = ['Yes', 'No']
window.currents =
	name: ->
		userData.name = window.question
		updatestats()
		game
			.action display "Let us begin, #{userData.name}!"
			.action delay 3000
			.action townchoose
	town:
		_buttons: ->
			res = ['Work->work', 'Safe->safe', 'Fix your rod->fix', 'Sell things->sell', 'Go to beach->beach']
			if userData.lvl >= 2 then res = res.concat ['Go to forest->forest']
			if userData.lvl >= 3 then res = res.concat ['Go to cave->cave']
			return res
		safe: ->
			game
				.action display 'Store your money or recover it?'
				.action cur 'safe'
		cave: ->
			game
				.action display 'We are on our way to the cave.......'
				.action cavechoose
		forest: -> forestchoose()
		sell: ->
			if userData.inventory.length >= 1
				game
					.action display "Your items are: #{userData.inventory.join(', ')}. Sell?"
					.action cur 'sell'
			else
				game
					.action display 'You have no items in your inventory..'
					.action delay 3000
					.action townchoose
		stats: -> showme()
		beach: -> beachchoose()
		fix: ->
			game
				.action display "Fixing your rod will cost you #{userData.rod} money. Are you sure?"
				.action cur 'fix'
		work: -> choosework()
	fix:
		_buttons: yesno
		yes: ->
			if userData.money >= userData.rod
				userData.money -= userData.rod
				userData.rod = 0
				game
					.action display "You have #{userData.money} money and #{userData.rod} dmg!"
					.action delay 3000
					.action townchoose
			else
				game
					.action display 'Not enough money'
					.action delay 3000
					.action townchoose
		no: -> townchoose()
	sell:
		_buttons: yesno
		yes: ->
			userData.money += userData.inventory.length * 2.5
			userData.inventory.length = 0
			game
				.action display "You have sold all your items. Your money is #{userData.money}."
				.action delay 3000
				.action townchoose
		no: ->
			game.action townchoose
	safe:
		_buttons: ['Store money to safe->store', 'Recover all moneys from safe->recover']
		store: ->
			if userData.money >= 1
				userData.safe += userData.money
				userData.money = 0
				game
					.action display 'You stored all your money in the safe'
					.action delay 3000
					.action townchoose
			else
				game
					.action display 'You have no money!'
					.action delay 3000
					.action townchoose
		recover: ->
			if userData.safe >= 1
				userData.money += userData.safe
				userData.safe = 0
				game
					.action display 'You recovered all your money from the safe'
					.action delay 3000
					.action townchoose
			else
				game
					.action display 'There is nothing in the safe!'
					.action delay 3000
					.action townchoose
	beach:
		_buttons: ['Fishing->fish', 'Go swimming->swim', 'Go back to town->leave']
		fish: ->
			if userData.rod <= 15
				game
					.action display 'You go to fish!'
					.action delay 3000
					.action fishing
			else
				game
					.action display "#{userData.rod}dmg"
					.action delay 3000
					.action beachchoose
		swim: ->
			game
				.action display 'You go swimming'
				.action delay 3000
				.action swimming
		leave: ->
			game
				.action display 'Going to town'
				.action delay 3000
				.action townchoose
	fishing:
		_buttons: yesno
		yes: -> fishing()
		no: -> beachchoose()
	swimming:
		_buttons: yesno
		yes: -> swimming()
		no: -> beachchoose()
	win:
		_buttons: yesno
		yes: -> townchoose()
		no: -> game.action display "Thank you for playing, #{userData.name}!"
	forest:
		_buttons: ['Go fight to arena->arena', 'Go to shop->shop', 'Go hunting->hunt', 'Leave back to town->leave']
		arena: ->
			game
				.action display 'You head to the arena....'
				.action delay 3000
				.action arenachoose
		shop: ->
			game
				.action display [
					'You are greeted by a cartoonish goblin named floop-flop'
					'floop-flop: BUY SOMESTUFF yeS? OOWeeE ITS TOPNPOTCH FOREST WEAPONS AND ARMOR YEs'
					'Upgrade Armor for 20 money, Upgrade Weapon for 15, or leave.'
				]
				.action cur 'floop'
		hunt: ->
			game
				.action display 'You head to the hunting grounds...'
				.action delay 3000
				.action huntchoose
		leave: ->
			game
				.action display 'You head to the town'
				.action delay 3000
				.action townchoose
	floop:
		_buttons: ['Upgrade armor->armor', 'Upgrade weapon->weapon', 'Leave shop->leave']
		armor: ->
			if userData.money >= 20
				userData.armor += 1
				userData.money -= 20
				updatestats()
				game
					.action display 'Your armor goes up by 1 point! You lose 20. Armor, weapon or leave?'
					.action cur 'floop'
			else
				game
					.action display 'Not enough money! Armor, weapon or leave?'
					.action cur 'floop'
		weapon: ->
			if userData.money >= 15
				userData.weapon += 1
				userData.money -= 15
				updatestats()
				game
					.action display 'Your weapon goes up by 1 point! You lose 15 money. Armor, weapon or leave?'
					.action cur 'floop'
			else
				game
					.action display 'Not enough money! Armor, weapon or leave?'
					.action cur 'floop'
		leave: ->
			game
				.action display 'Floop: floop ya\' lateR PARTNR\''
				.action delay 3000
				.action forestchoose
	arena:
		_buttons: yesno
		yes: ->
			random = Math.random() * 100 + 1
			switch
				when random <= 5
					game
						.action display 'THE MUTANT has entered the match!'
						.action delay 3000
					if userData.armor >= 13 and userData.weapon >= 11
						game
							.action display 'You SLAYED THE MUTANT! +15xp, +50money'
							.action delay 3000
						if userData.hasDefeatedMutant
							game
								.action display 'The cave trembles and echoes are heard.'
								.action delay 3000
						userData.xp += 15
						userData.money += 50
						moneygainFX.play()
						hasDefeatedMutant = true
						updatestats()
						game.action arenachoose
					else
						userData.money -= 10
						updatestats()
						game
							.action display 'You were PWNED by the mutant and sent to the hospital! Get better equipment!'
							.action delay 3000
							.action townchoose
				when random <= 20
					game
						.action display 'SKELETRON has entered the match!'
						.action delay 3000
					if userData.armor >= 10 and userData.weapon >= 7
						userData.xp += 5
						userData.money += 20
						moneygainFX.play()
						updatestats()
						game
							.action display 'You PWNED SKELETRON and from his aqcuired +20money and +5xp'
							.action delay 3000
							.action arenachoose
					else
						userData.xp -= 1
						userData.money -= 5
						updatestats()
						game
							.action display 'SKELETRON SENT YOU RUNNING BACK HOME!Get better equipment!'
							.action delay 3000
							.action townchoose
				when random <= 40
					game
						.action display 'INFECTED GLOB has entered the match!'
					if userData.armor >= 6 and userData.weapon >= 7
						userData.money += 10
						userData.xp += 4
						updatestats()
						game
							.action display 'You killed the INFECTED GLOB! Gained +10money and +4xp'
							.action delay 3000
							.action arenachoose
					else
						userData.money -= 5
						updatestats()
						game
							.action display 'The Glob jaZZED you UP BACK to the hospital! -5money - Get better equipment!'
							.action delay 3000
							.action townchoose
				when random <= 60
					game
						.action display 'An imp joined the fight'
						.action delay 3000
					if userData.armor >= 4 and userData.weapon >= 4
						userData.money += 15
						moneygainFX.play()
						userData.xp += 2
						updatestats()
						game
							.action display 'You SMACKED the imp! +15 money +2xp'
							.action delay 3000
							.action arenachoose
					else
						userData.money -= 3
						updatestats()
						game
							.action display 'Daaaang that imp frigged you UP! Go back home!  -3 money. Get better equipment!'
							.action delay 3000
							.action townchoose
				when random <= 70
					game
						.action display 'Goblins joined the battle-!'
						.action delay 3000
					if userData.armor >= 2 and userData.weapon >= 2
						userData.money += 15
						userData.xp += 2
						updatestats()
						game
							.action display 'You rekt those goblins UP +15money +2xp'
							.action delay 3000
							.action arenachoose
					else
						userData.money -= 3
						updatestats()
						game
							.action display 'Snap! Those goblins diddled you! Go back home and get better equipment!'
							.action delay 3000
							.action townchoose
				when random <= 100
					userData.money += 5
					game
						.action display 'You fought a boot and won.. +5 money'
						.action delay 3000
						.action arenachoose
		no: ->
			game
				.action display 'You head back.'
				.action delay 3000
				.action forestchoose
	cave:#The cave should have more gameplay
		_buttons: yesno
		yes: ->
			game
				.action display 'You go throught the doors, as they close behind you, you find yourself in a massive chamber with a large world-devourer infront of you!'
				.action delay 3000
			if userData.armor >= 30 and userData.weapon >= 30
				game
					.action display 'You slice the devourer in two. killing it instantly because of your massive strength. YOU WIN!'
					.action delay 3000
					.action (n) ->
						win()
						n()
			else
				game
					.action display [
						'The devourer expands his long putrid body out of the a massive hole in the wall, charging at you'
						'Attack or defend?'
					]
					.action cur 'devourer'
		no: ->
			game
				.action display 'You run out of the cave and back to the town'
				.action delay 3000
				.action townchoose
	devourer:
		_buttons: ['Attack', 'Defend']
		attack: ->
			if userData.armor >= 19 and userData.weapon >= 10
				if userData.weapon >= 12
					game
						.action display [
							'You destroy the devourer with one massive plasma blast. YOU WIN'
							"Thank you for playing #{userData.name}!"
						]
						.action (n) ->
							win()
							n()
				else
					game
						.action display 'You defend against the mighty creature - but as you do, it begins circling around you. As a final resort you unleash all of your power, killing you and the creature, curing the world of the the devourer. You win the ULTIMATE HERO ENDING'
					$ '#mainh'
						.html "#{userData.name} the hero"
					reset()
			else
				userData.money -= 30
				updatestats()
				game
					.action display 'You were too weak to defend yourself. The devourer eats you up in one large gulp. Game Over. Try getting better gear'
					.action delay 3000
					.action townchoose
		defend: ->
			if userData.armor >= 19 and userData.weapon >= 10
				game
					.action display 'You defend against the mighty creature - but as you do, it begins circling around you. As a final resort you unleash all of your power, killing you and the creature, curing the world of the the devourer. You win the ULTIMATE HERO ENDING'
				$ '#mainh'
					.html "#{userData.name} the hero"
				reset()
			else
				userData.money -= 30
				updatestats()
				game
					.action display 'You were too weak to defend yourself. The devourer eats you up in one large gulp. Game Over. Try getting better gear'
					.action delay 3000
					.action townchoose
	hunt:
		_buttons: yesno
		yes: -> huntchoose()
		no: ->
			game
				.action display 'Heading back...'
				.action delay 3000
				.action forestchoose
forestchoose = (n) ->
	game
		.action display 'There are three paths, one leads you to a shop, the other to an arena, and the last to hunting grounds. Which way to do you pick?'
		.action cur 'forest'
	if n then n()
floop = ->
	game.action cur 'floop'
arenachoose = (n) ->
	game
		.action display 'You arrive at the \'Dome of Death\'. Fight?'
		.action cur 'arena'
	if n then n()
hunts = [
	{
		num: 10
		msg: 'You hunted a unichord! It\'s going in your inventory.. Hunt again?'
		props:
			inventory: 'Unichord'
	},
	{
		num: 20
		msg: 'You hunted a goblin! He pays you to let him go. Hunt again?'
		props:
			money: 10
	},
	{
		num: 30
		msg: 'You hunted a shell-snake! It\'s going in your inventory.. Hunt again?'
		props:
			inventory: 'shell-snake'
	},
	{
		num: 40
		msg: 'You hunted a grizzlor bear! It\'s going into your inventory! Hunt again?'
		props:
			inventory: 'Grizzlor mama'
	},
	{
		num: 42
		msg: 'You hunted a.. Kairy?! Kairy shines up your armor and runs back into the bushes. +1armor - Hunt again?'
		props:
			armor: 1
	},
	{
		num: 50
		msg: 'You hunted a... boot? You throw it away. Hunt again?'
	},
	{
		num: 55,
		msg: 'You hunted a flying-butt! It\'s going in your inventory.. Hunt again?'
		props:
			inventory: 'flying ass'
	},
	{
		num: 65
		msg: 'You hunted an ordinary rabbit. It\'s going in your inventory.. Hunt again?'
		props:
			inventory: 'wabbit'
	},
	{
		num: 75
		msg: 'You hunted a pegavis! It\'s going in your inventory.. Hunt again?'
		props:
			inventory: 'Pegavis'
	},
	{
		num: 76
		msg: 'You hunted a bug... but it is not a bug, it is feature. Hunt again?'
		props:
			inventory: 'feature'
	},
	{
		num: 100,
		msg: 'You\'ve been raided by imps! -50 money. Try again?'
		props:
			money: -50
	}
]
huntchoose = (n) ->
	random = Math.random() * hunts[-1..][0].num
	for hunt in hunts
		if random <= hunt.num
			curr = hunt
			break
	game
		.action display curr.msg
		.action cur 'hunt'
	if 'props' of curr
		props = curr.props
		userData.money += props.money if 'money' of props
		updatestats()
		userData.armor += props.armor if 'armor' of props
		userData.inventory.push props.inventory if 'inventory' of props
	if n then n()
cavechoose = (n) ->
		if userData.hasDefeatedMutant
			if Math.random() * 100 + 1 <= 20
				game
					.action display 'You are attacked by a spider-skeleton-dungeon-keeper at the entrance!'
					.action delay 3000
				if userData.armor >= 16 and userData.weapon >= 12
					game
						.action display 'You kill the spider-skeleton. Let\'s enter.'
						.action delay 3000
						.action cavechoose
				else
					game
						.action display 'You were too weak to fight the spider-skeleton-dungeon-keeper. Get better equipment'
						.action delay 3000
						.action townchoose
			else
				game
					.action display [
						'We have entered the cave.'
						'It\'s dark, you cant see anything'
						'Flames ignite besides you down a long corridor that lead towards two large doors. Enter?'
					]
					.action cur 'cave'
		else
			game
				.action display 'There is nothing here for you yet...'
				.action delay 3000
				.action townchoose
		if n then n()
beachchoose = (n) ->
	game
		.action display 'We are at the beach. Fish, swim, or leave?'
		.action cur 'beach'
	if n then n()
fishing = (n) ->
		if userData.rod <= 15
			random = Math.floor(Math.random() * fishes.length + 1)
			if random >= fishes.length
				userData.rod += 3
				userData.money -= 10
				updatestats()
				game
					.action display 'You were attacked by a sea glob fish! You lost 10 money and now have +3 rod damage. Try again?'
					.action cur 'fishing'
			else
				userData.inventory.push(fishes[random])
				game
					.action display "#{userData.name} caught a #{fishes[random]}! It\'s going in your inventory. Try again?"
					.action cur 'fishing'
		else
			game
				.action display "Your rod has #{userData.rod} damage! Go fix it at the town!"
				.action delay 3000
				.action beachchoose
		if n then n()
swimming = (n) ->
	random = Math.floor Math.random() * swimmingOutcomes.length + 1
	if random >= swimmingOutcomes.length # if you are unlucky
		userData.money /= 2
		game
			.action display "#{userData.name} was stung by a deadly jelly fish! You lost half of your money at the town hospital"
			.action delay 3000
			.action townchoose
	else # else if you catch something
		
		userData.money += swimmingOutcomes[random].props.money
		updatestats()
		game
			.action display "#{swimmingOutcomes[random].msg}. Dive in again?"
		if swimmingOutcomes[random].items # if it has items
			
			userData.inventory.push(swimmingOutcomes[random].props.items...)
			game
				.action delay 3000
				.action display "Added #{swimmingOutcomes[random].props.items.join(', ')} to inventory"
		game.action cur 'swimming'
		if n then n()
townchoose = (n) ->
	switch
		when userData.lvl >= 3
			game
				.action display 'We are in the town'
		when userData.lvl == 2
			game
				.action display 'We are in the town'
		else
			game
				.action display 'We are in the town'
	game.action cur 'town'
	if n then n()
choosework = (n) ->
	random = Math.random() * 10 + 1
	switch
		when random <= 2
			userData.money += 25
			moneygainFX.play()
			userData.xp += 1
			updatestats()
			game
				.action display "You go to the library and help out with storing while you've gained experience from reading. Also you get paid"
				.action delay 3000
				.action townchoose
		when random >= 8
			userData.money -= 10
			updatestats()
			game
				.action display 'While looking for a job you get robbed. You lose 10 money!'
				.action delay 3000
				.action townchoose
		when random <= 4
			userData.money += 15
			moneygainFX.play()
			game
				.action display 'You work at the pub and get paid 15 money!'
				.action delay 3000
				.action townchoose
		when random <= 7
			userData.xp += 1
			updatestats()
			game
				.action display 'You go to the local car wash and gain some experience!'
				.action delay 3000
				.action townchoose
		else
			game
				.action display 'No one wants to hire you! Tough luck.'
				.action delay 3000
				.action townchoose
	if n then n()
