$ ->
  $ '#controls,#commies'
    .hide()
question = ''
current = ->
mario = new Audio '../static/dire.mp3'
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
user = new Proxy u, {
  set: (t, p, v) ->
    t[p] = v
    updatestats()
}
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

start = ->
  $ '#controls,#commies'
    .show()
  $ '.button'
    .hide()
  displayToPlayer 'What is your name?'
  current = currents.name
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
  displayToPlayer('You are the strongest hero go back to town?')
  current = currents.win
check = ->
  if user.xp >= 10
    user.lvl += 1
    confirm "You have leveled up to level #{user.lvl}!"
    user.xp -= 10
    switch user.lvl
      when 2 then confirm('You can now go to the forest')
      when 3 then confirm('You can now venture into the cave... At your own risk...')
  if user.money < 0 then user.money = 0
