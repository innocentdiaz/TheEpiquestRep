current = ->
forestchoose = ->
  displayToPlayer 'There are three paths, one leads you to a shop, the other to an arena, and the last to hunting grounds. Which way to do you pick?'
  current = currents.forest
floop = ->
  current = currents.floop
arenachoose = ->
  displayToPlayer 'You arrive at the \'Dome of Death\'. Fight?'
  current = currents.arena
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
huntchoose = ->
  random = Math.random() * hunts[-1..][0].num
  for hunt in hunts
    if random <= hunt.num
      cur = hunt
      break
  question = prompt cur.msg
    .toUpperCase()
  if 'props' of cur
    props = cur.props
    money += props.money if 'money' of props
    check()
    armor += props.armor if 'armor' of props
    inventory.push props.inventory if 'inventory' of props
  switch question
    when 'YES' then huntchoose()
    when 'NO'
      displayToPlayer 'Heading back...'
      setTimeout (-> forestchoose()), 1600
    else
      displayToPlayer 'Not an option'
      setTimeout (-> forestchoose()), 1600
