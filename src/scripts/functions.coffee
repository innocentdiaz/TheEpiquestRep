displayToPlayer = (message) ->
	if window.typingInterval then clearInterval(window.typingInterval)
	$ '#display'
		.html ""
	$ ".buttons"
			.addClass('disabled')
	interval = 50
	index = 0
	window.typingInterval = setInterval ->	
		$("#display").append(message.charAt(index))
		index++
		if index is message.length
			clearInterval(window.typingInterval)
			$ ".buttons"
				.removeClass('disabled')
	, interval
	interval += 30

question = ''

push = (items) ->
	items.forEach(item -> userData.inventory.push item)

updatestats = ->
	check()

	$('#name').text userData.name
	$('#money').text userData.money
	$('#safe').text userData.safe
	$('#rod').text userData.rod
	$('#level').text userData.lvl
	$('#xp').text userData.xp
	$('#armor').text userData.armor
	$('#weapon').text userData.weapon
	localStorage.setItem('EQuserData', JSON.stringify(userData))

check = ->
	if userData.xp >= 10
		userData.lvl += 1
		confirm "You have leveled up to level #{userData.lvl}!"
		userData.xp -= 10
		switch userData.lvl
			when 2 then alert('You can now go to the forest')
			when 3 then alert('You can now venture into the cave... At your own risk...')
	if userData.money < 0 then userData.money = 0

playtheme = (selected) ->
	switch (selected)
		when 'bgmain'
			bgmain.loop = true
			bgmain.play()
reset = ->
	delete localStorage.EQuserData
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
		key: 1
	start()
# submit = (event) ->
	# keycode = event.keyCode

	# if keycode == 13
		# question = $('#inputBox').val()
		# $('#inputBox').val('')
		# current()
