$ ->
  $ '#controls,#commies'
    .hide()
question = ''
current = ->
mario = new Audio '../static/dire.mp3'
user =
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
name = user.name
lvl = user.lvl
xp = user.xp
inventory = user.inventory
money = user.money
safe = user.safe
rod = user.rod
armor = user.armor
weapon = user.weapon
key = user.key
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
  displayToPlayer('What is your name?')
  current = currents.name
win = ->
  $ '#mainh'
   .html name
  armor = 123
  weapon = 98
  lvl = 50
  xp = 0
  money += 500
  rod = -100
  showme()
  displayToPlayer('You are the strongest hero go back to town?')
  current = currents.win
check = ->
  if xp >= 10
    lvl += 1
    confirm "You have leveled up to level #{lvl}!"
    xp -= 10
    switch lvl
      when 2 then confirm('You can now go to the forest')
      when 3 then confirm('You can now venture into the cave... At your own risk...')
  if money < 0 then money = 0
