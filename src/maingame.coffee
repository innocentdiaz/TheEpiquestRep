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

delay = (c) ->
  (n) => setTimeout n, c
# window.__defineSetter__ 'current', (v) -> console.log(v) or console.trace()
$ ->
  $ '.sound'
    .click ->
      el = $ this
      if el.hasClass 'off'
        mario.play()
      else
        mario.pause()
      el.toggleClass 'off'

  start()


u =
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
window.user = null
start = ->
  if typeof(Storage) is "undefined"#if browser does not support local storage
    displayToPlayer "This browser does not support local storage"
    return
  $ '#controls,#commies,#display'
    .show()
  $ '.button'
    .hide()
  if 'player' of localStorage
    u = JSON.parse(localStorage.player)
    createUser()
    townchoose()
    updatestats()
  else
    createUser()
    displayToPlayer 'What is your name?'
    window.current = currents.name
createUser = ->
  window.user = new Proxy u, {
    set: (t, p, v) ->
      t[p] = v
      updatestats()
  }
# console.log(start)
question = ''
window.current = ->
mario = new Audio '../static/locust.mp3'
moneygainFX = new Audio '../static/money-gain.mp3'
mario.looped = true
fishes = ['Guppy', 'SnakeFish', 'DragonFish', 'Boot', 'Tuna', 'GoldFish', 'Guaba', 'Man-eating snail', 'Goblin shark']
# array of outcome of swimming. has description, money and/or items
swimmingOutcomes = [
  ['Dived and came out with sand..', 0],
  ['Dived in and found a sack of coins!', 30],
  ['Dived in and found a gold ring! It\'s going in your inventory', 0, 'Gold ring'],
  ['Dived in and found a boot, It\'s useless', 0],
  ['Dived in and found a small sack of coins!', 10],
  ['Dived in and came out with nothing', 0],
  ['Dived in and came out with a large sack of coins!', 45],
  ['Dived in and came out with a book.', 0, 'Book']
]


win = ->
  $ '#mainh'
   .html user.name
  user.armor = 123
  user.weapon = 98
  user.lvl = 50
  user.xp = 0
  user.money += 500
  user.rod = -100
  showme()
  displayToPlayer 'You are the strongest hero go back to town?'
  current = currents.win
check = ->
  if user.xp >= 10
    user.lvl += 1
    confirm "You have leveled up to level #{user.lvl}!"
    user.xp -= 10
    switch user.lvl
      when 2 then alert('You can now go to the forest')
      when 3 then alert('You can now venture into the cave... At your own risk...')
  if user.money < 0 then user.money = 0
