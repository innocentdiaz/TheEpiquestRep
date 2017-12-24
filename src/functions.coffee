window.displayToPlayer = (message) -> $('#display').html message
question = ''
# user.inventory = []

push = (item) -> user.inventory.push item

updatestats = ->
  # $ '#stats'
    # .html "Name: #{user.name} Money: #{user.money} Safe: #{user.safe} Rod: #{user.rod} Level: #{user.lvl} XP: #{user.xp} Armor: #{user.armor} Weapon: #{user.weapon}"
  $('#name').text user.name
  $('#money').text user.money
  $('#safe').text user.safe
  $('#rod').text user.rod
  $('#level').text user.lvl
  $('#xp').text user.xp
  $('#armor').text user.armor
  $('#weapon').text user.weapon
  localStorage.player = JSON.stringify(user)
playtheme = (selected) ->
  switch (selected)
    when 'mario'
      mario.loop = true
      mario.play()


# submit = (event) ->
  # keycode = event.keyCode

  # if keycode == 13
    # question = $('#inputBox').val()
    # $('#inputBox').val('')
    # current()
