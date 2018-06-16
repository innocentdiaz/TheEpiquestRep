game =
	queue: []
	current: 0
	nextOn: off
	next: ->
		game.nextOn = on
		if game.current >= game.queue.length
			game.nextOn = off
			game.queue = []
			game.current = 0
		else game.queue[game.current++](game.next)
	action: (act) ->
		@queue.push act
		if !@nextOn then @next()
		@
	delay: 3000

delay = (c) ->
	(n) => setTimeout n, c
# window.__defineSetter__ 'current', (v) -> console.log(v) or console.trace()
$ ->
	$ '#submit'
		.click ->
			question = window.question = $('#inputBox').val()
			$('#inputBox').val('')
			window.current(question)
		.parent()
		.submit -> false
	$ '.sound'
		.click ->
			el = $ this
			if el.hasClass 'off'
				bgmain.play()
			else
				bgmain.pause()
			el.toggleClass 'off'

	


userData =
	name: ''
	lvl: 1
	xp: 0
	inventory: []
	money: 0
	safe: 0
	rod: 0
	armor: 0
	weapon: 0
	hasDefeatedMutant: false

window.typingInterval = false# This will store the typing intervals for the message typing animations, so that they can be cleared on command
start = ->
	if typeof(Storage) is "undefined"# if browser does not support local storage
		displayToPlayer "This browser does not support local storage"
		return

	$ '#controls,#commies,#display'
		.show()
	$ '.button'
		.hide()
	if 'EQuserData' of localStorage
		userData = JSON.parse(localStorage.EQuserData)
		updatestats()
		townchoose()
	else
		displayToPlayer 'Welcome, adventurer. What is your name?'
		window.current = currents.name

question = ''
window.current = ->
hoverFX = new Audio '../static/button-hover.wav'
bgmain = new Audio '../static/locust.mp3'
moneygainFX = new Audio '../static/money-gain.mp3'
bgmain.looped = true
fishes = ['Guppy', 'SnakeFish', 'DragonFish', 'Boot', 'Tuna', 'GoldFish', 'Guaba', 'Man-eating snail', 'Goblin shark']

# Array of outcome of swimming. Has description, Money and/or items
swimmingOutcomes = [
	{description: 'Dived and came out with sand..', money: 0},
	{description: 'Dived in and found a sack of coins!', money: 30},
	{description: 'Dived in and found a gold ring! It\'s going in your inventory', money: 0, items: ['Gold ring']},
	{description: 'Dived in and found a boot, It\'s useless', money: 0},
	{description: 'Dived in and found a small sack of coins!', money: 10},
	{description: 'Dived in and came out with nothing', money: 0},
	{description: 'Dived in and came out with a large sack of coins!', money: 45},
	{description: 'Dived in and came out with a book.', money: 0, items: ['Book']}
]

win = ->
	$ '#mainh'
		.html userData.name
	userData.armor = 123
	userData.weapon = 98
	userData.lvl = 50
	userData.xp = 0
	userData.money += 500
	userData.rod = -100
	showme()
	displayToPlayer 'You are the strongest hero go back to town?'
	current = currents.win
check = ->
	if userData.xp >= 10
		userData.lvl += 1
		confirm "You have leveled up to level #{userData.lvl}!"
		userData.xp -= 10
		switch userData.lvl
			when 2 then alert('You can now go to the forest')
			when 3 then alert('You can now venture into the cave... At your own risk...')
	if userData.money < 0 then userData.money = 0

$ document
	.ready =>
		start()