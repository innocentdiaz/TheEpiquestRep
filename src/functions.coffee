question = ''
inventory = []
submit = ->
  keyCode = event.which || event.keyCode
  if keyCode is 13
    question = $('#inputBox').val()
    $('#inputBox').val ''
    current()
    console.log "question = #{question}"
push = (item) -> inventory.push(item)
showme = -> alert "NAME: #{name}\nMONEY, SAFE AND ROD: #{money}, #{safe}, #{rod}\nLVL AND XP: #{lvl}, #{xp}\nARMOR AND WEAPON: #{armor}, #{weapon}"
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
