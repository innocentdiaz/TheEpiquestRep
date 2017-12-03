question = ''
# user.inventory = []
submit = ->
  keyCode = event.which || event.keyCode
  if keyCode is 13
    question = $('#inputBox').val()
    $('#inputBox').val ''
    current()
    console.log "question = #{question}"
push = (item) -> user.inventory.push item
showme = -> alert "NAME: #{user.name}\nMONEY, SAFE AND ROD: #{user.money}, #{user.safe}, #{user.rod}\nLVL AND XP: #{user.lvl}, #{user.xp}\nARMOR AND WEAPON: #{user.armor}, #{user.weapon}"
updatestats = ->
  $ '#stats'
    .html "Name: #{user.name} Money: #{user.money} Safe: #{user.safe} Rod: #{user.rod} Level: #{user.lvl} XP: #{user.xp} Armor: #{user.armor} Weapon: #{user.weapon}"
playtheme = (selected) ->
  switch (selected)
    when 'mario'
      mario.loop = true
      mario.play()
reset = ->
  if confirm('Reset game?').toUpperCase() is 'YES'
    location.reload()
nightmode = ->
  $ 'body'
    .css 'background-color', 'black'
  $ 'button'
    .css 'background-color', 'grey'
  $ '#display'
    .css 'border-color', 'white'
daymode = ->
  $ 'body'
    .css 'background-color', 'white'
  $ 'button'
    .css 'background-color', 'green'
  $ '#display'
    .css 'border-color', 'black'

displayToPlayer = (message) -> $('#display').html message
