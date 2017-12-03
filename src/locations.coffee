question = ''
current = ->
# money = 0
# safe = 0
# rod = 0
# key = 0
# name = ''
currents =
  name: ->
    user.name = question
    displayToPlayer "Let us begin, #{ user.name}!"
    townchoose()
  town: ->
    switch question.toUpperCase()
      when 'WORK' then choosework()
      when 'FIX'
        displayToPlayer "Fixing your rod will cost you #{user.rod} money. Are you sure?"
        current = currents.fix
      when user.inventory.length >= 1 and 'SELL'
        displayToPlayer "your items are: #{user.inventory.join(', ')}. Sell?"
        current = currents.sell
      when user.inventory.length < 1 and 'SELL'
        displayToPlayer 'You have no items in your inventory..'
        setTimeout (-> townchoose()), 1800
      when 'STATS' then showme()
      when 'BEACH' then beachchoose()
      when  user.lvl >= 2 and 'FOREST'
        displayToPlayer 'We are on our way to the enchanted forest.......'
        setTimeout (-> forestchoose()), 1500
      when user.lvl >= 3 and 'CAVE'
        displayToPlayer 'We are on our way to the cave.......'
        setTimeout (-> cavechoose()), 1500
      when 'SAFE'
        displayToPlayer 'Store your money or recover it?'
        current = currents.safe
      else
        displayToPlayer 'Thats not an option'
  fix: ->
    switch question.toUpperCase()
      when 'YES'
        if user.money >= user.rod
          user.money -= user.rod
          user.rod = 0
          displayToPlayer "You have #{user.money} money and #{user.rod} dmg!"
          setTimeout (-> townchoose()), 2000
        else
          displayToPlayer 'Not enough money'
          setTimeout (-> townchoose()), 2000
      when 'NO' then townchoose()
  sell: ->
    switch
      when 'YES'
        user.money += user.inventory.length * 2.5
        user.inventory.length = 0
        displayToPlayer "You have sold all your items. Your money is #{user.money}."
        setTimeout (-> townchoose()), 2000
      when 'NO'
        setTimeout (-> townchoose()), 2000
  safe: ->
    switch question.toUpperCase()
      when 'STORE'
        if user.money >= 1
          user.safe += user.money
          user.money = 0
          displayToPlayer 'You stored all your money in the safe'
          setTimeout (-> townchoose()), 1500
        else
          displayToPlayer 'You have no money!'
          setTimeout (-> townchoose()), 1500
      when 'RECOVER'
        if user.safe >= 1
          user.money += user.safe
          user.safe = 0
          displayToPlayer 'You recovered all your money from the safe'
          setTimeout (-> townchoose()), 1500
        else
          displayToPlayer 'There is nothing in the safe!'
          setTimeout (-> townchoose()), 1500
  beach: ->
    switch question.toUpperCase()
      when 'FISH'
        if user.rod <= 15
          displayToPlayer('You go to fish!')
          setTimeout (-> fishing()), 1500
        else
          displayToPlayer "#{user.rod}dmg"
          beachchoose()
      when 'SWIM'
        displayToPlayer('You go swimming..')
        setTimeout swimming(), 1500
      when 'LEAVE'
        displayToPlayer 'going to town'
        setTimeout (-> townchoose()), 1600
  fishing: ->
    switch question.toUpperCase()
      when 'YES' then fishing()
      when 'NO' then beachchoose()
  swimming: ->
    switch question.toUpperCase()
      when 'YES' then swimming()
      when 'NO' then beachchoose()
  win: ->
    if question.toUpperCase() is 'YES' then townchoose()
    else displayToPlayer "Thank you for playing, #{user.name}!"
  forest: ->
    switch question.toUpperCase()
      when 'ARENA'
        displayToPlayer 'You head to the arena....'
        setTimeout (-> arenachoose()), 2200
      when 'SHOP'
        displayToPlayer 'You are greeted by a cartoonish goblin named floop-flop'
        setTimeout (-> displayToPlayer 'floop-flop: BUY SOMESTUFF yeS? OOWeeE ITS TOPNPOTCH FOREST WEAPONS AND ARMOR YEs'), 2000
        setTimeout (->
          floop()
          setTimeout (-> current()), 10
        ), 3200
      when 'HUNT'
        displayToPlayer 'You head to the hunting grounds...'
        setTimeout (-> huntchoose()), 1500
      when 'LEAVE'
        displayToPlayer 'You head to the town'
        setTimeout (-> townchoose()), 1600
  floop: ->
    displayToPlayer 'Upgrade Armor for 20 money, Upgrade Weapon for 15, or leave.'
    switch question.toUpperCase()
      when 'ARMOR'
        if user.money >= 20
          displayToPlayer 'Your armor goes up by 1 point! You lose 20. Armor, weapon or leave?'
          user.armor += 1
          user.money -= 20
          check()
          console.log "Money: #{user.money}. Armor: #{user.armor}"
          current = currents.floop
        else
          displayToPlayer 'Not enough money! Armor, weapon or leave?'
          current = currents.floop
      when 'WEAPON'
        if user.money >= 15
          displayToPlayer 'Your weapon goes up by 1 point! You lose 15 money. Armor, weapon or leave?'
          user.weapon += 1
          user.money -= 15
          check()
          console.log "Money: #{user.money}. Weapon: #{user.weapon}"
          current = currents.floop
        else
          displayToPlayer 'Not enough money! Armor, weapon or leave?'
          current = currents.floop
      when 'LEAVE'
        displayToPlayer 'Floop: floop ya\' lateR PARTNR\''
        setTimeout (-> forestchoose()), 2000
  arena: ->
    switch question.toUpperCase()
      when 'YES'
        random = Math.random() * 100 + 1
        switch
          when random <= 5
            confirm 'THE MUTANT has entered the match!'
            if user.armor >= 13 and user.weapon >= 11
              confirm 'You SLAYED THE MUTANT! +15xp, +50money'
              if key is 1
                confirm 'The cave trembles and echoes are heard...'
                key = 0
              user.xp += 15
              user.money += 50
              key = 0
              console.log "money: #{user.money}+15xp"
              check()
              forestchoose()
            else
              confirm 'You were PWNED by the mutant and sent to the hospital! Get better equipment!'
              user.money -= 10
              check()
              console.log "Money: #{user.money}"
              townchoose()
          when random <= 20
            confirm 'SKELETRON has entered the match!'
            if user.armor >= 10 and user.weapon >= 7
              confirm 'You PWNED SKELETRON and from his aqcuired +20money and +5xp'
              user.xp += 5
              user.money += 20
              check()
              forestchoose()
            else
              confirm 'SKELETRON SENT YOU RUNNING BACK HOME!Get better equipment!'
              user.xp -= 1
              user.money -= 5
              check()
              console.log "Money: #{user.money} #{user.xp}xp"
              townchoose()
          when random <= 40
              confirm 'INFECTED GLOB has entered the match!'
              if user.armor >= 6 and user.weapon >= 7
                confirm 'You killed the INFECTED GLOB! Gained +10money and +4xp'
                user.money += 10
                user.xp += 4
                check()
                forestchoose()
              else
                confirm 'The Glob jaZZED you UP BACK to the hospital! -5money - Get better equipment!'
                user.money -= 5
                check()
                console.log "Money: #{user.money}"
                townchoose()
          when random <= 60
            confirm 'An imp joined the fight'
            if user.armor >= 4 and user.weapon >= 4
              confirm 'You SMACKED the imp! +15 money +2xp'
              user.money += 15
              user.xp += 2
              forestchoose()
            else
              confirm 'Daaaang that imp frigged you UP! Go back home!  -3money - Get better equipment!'
              user.money -= 3
              check()
              townchoose()
          when random <= 70
            confirm 'Goblins joined the battle-!'
            if user.armor >= 2 and user.weapon >= 2
              confirm 'You FLOOPED those goblins UP +15money +2xp'
              user.money += 15
              user.xp += 2
              check()
              forestchoose()
            else
              confirm('Snap! Those goblins diddled you! Go back home! Get better equipment!')
              user.money -= 3
              check()
              townchoose()
          when random <= 100
            confirm 'You fought a boot and won.. +5money'
            user.money += 5
            forestchoose()
      when 'NO'
        displayToPlayer 'You head back...'
        setTimeout (-> forestchoose()), 1600
  cave: ->
    switch question.toUpperCase()
      when 'YES'
        displayToPlayer 'You go throught the doors, as they close behind you, you find yourself in a massive chamber with a large world-devourer infront of you!'
        if user.armor >= 30 and user.weapon >= 30
          setTimeout (->
            displayToPlayer 'You slice the devourer in two. killing it instantly because of your massive strength. YOU WIN!'
            key += 1
            win()
          ), 1500
        else
          displayToPlayer 'The devourer expands his long putrid body out of the a massive hole in the wall, charging at you'
          setTimeout (->
            displayToPlayer 'Attack or defend?'
            current = currents.devourer
          ), 1500
      when 'NO'
        displayToPlayer 'You run out of the cave and back to the town'
        setTimeout townchoose, 1500
      else
        confirm 'not an option. You are pushed out of the cave'
        setTimeout townchoose, 1500
  devourer: ->
    if user.armor >= 19 and user.weapon >= 10
      if question is 'ATTACK' and user.weapon >= 12
        displayToPlayer 'You destroy the devourer with one massive plasma blast. YOU WIN'
        setTimeout (->
          displayToPlayer "Thank you for playing #{user.name}!"
          win()
        ), 1500
      else
        displayToPlayer 'You defend against the mighty creature - but as you do, it begins circling around you. As a final resort you unleash all of your power, killing you and the creature, curing the world of the the devourer. You win the ULTIMATE HERO ENDING'
        $ '#mainh'
          .html "#{user.name} the hero"
        reset()
    else
      displayToPlayer 'You were too weak to defend yourself. The devourer eats you up in one large gulp. Game Over. Try getting better gear'
      user.money -= 30
      check()
      console.log user.money
      setTimeout townchoose, 1500
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
    user.money += props.money if 'money' of props
    check()
    user.armor += props.armor if 'armor' of props
    user.inventory.push props.inventory if 'inventory' of props
  switch question
    when 'YES' then huntchoose()
    when 'NO'
      displayToPlayer 'Heading back...'
      setTimeout (-> forestchoose()), 1600
    else
      displayToPlayer 'Not an option'
      setTimeout (-> forestchoose()), 1600
cavechoose = ->
    if key is 0
      if Math.random() * 100 + 1 <= 20
        displayToPlayer 'You are attacked by a spider-skeleton-dungeon-keeper at the entrance!'
        if user.armor >= 16 and user.weapon >= 12
          setTimeout (->
            displayToPlayer 'You kill the spider-skeleton. Let\'s enter.'
            cavechoose()
          ), 1500
        else
          setTimeout (->
            displayToPlayer 'You were too weak to fight the spider-skeleton-dungeon-keeper. Get better equipment'
            townchoose()
          ), 1500
      else
        displayToPlayer 'we have entered the cave.'
        setTimeout (->
          displayToPlayer 'it\'s dark, you cant see anything'
          setTimeout (->
            displayToPlayer 'Flames ignite besides you down a long corridor that lead towards two large doors. Enter?'
            current = currents.cave
          ), 1500
        ), 1500
    else
      confirm 'there is nothing here for you'
      townchoose()
beachchoose = ->
  displayToPlayer 'We are at the beach. Fish, swim, or leave?'
  current = currents.beach
fishing = ->
    if user.rod <= 15
      random = Math.floor(Math.random() * fishes.length + 1)
      if random >= fishes.length
        displayToPlayer 'You were attacked by a sea glob fish! You lost 10 money and now have +3 rod damage. Try again?'
        user.rod += 3
        user.money -= 10
        check()
        current = currents.fishing
      else
        displayToPlayer "#{user.name} caught a #{fishes[random]}! It\'s going in your inventory. Try again?"
        user.inventory.push(fishes[random])
        current = currents.fishing
    else
      displayToPlayer "Your rod has #{user.rod} damage! Go fix it at the town!"
      setTimeout (-> beachchoose()), 1500
swimming = ->
  random = Math.floor Math.random() * swimmingOutcomes.length + 1
  if random >= swimmingOutcomes.length
    displayToPlayer "#{user.name} was stung by a deadly jelly fish! You lost half of your money at the town hospital"
    user.money /= 2
    setTimeout (-> townchoose()), 3000
  else
    displayToPlayer "#{swimmingOutcomes[random][0]}. Dive in again?"
    user.money += swimmingOutcomes[random][1]
    check()
    if swimmingOutcomes[random][2]
      setTimeout (->
        user.inventory.push(swimmingOutcomes[random][2])
        displayToPlayer "Added #{swimmingOutcomes[random][2]} to inventory"
      ), 1500
    setTimeout (->
      current = currents.swimming
    ), 3200
townchoose = ->
  switch
    when user.lvl >= 3 then displayToPlayer '=TOWN= Work, fix, sell, safe, beach, forest, cave =TOWN='
    when user.lvl == 2 then displayToPlayer '=TOWN= Work, fix, sell, safe, beach, forest =TOWN='
    else displayToPlayer '=TOWN= Work, fix, sell, safe, beach =TOWN='
  current = currents.town
choosework = ->
  random = Math.random() * 10 + 1
  switch
    when random <= 2
      displayToPlayer "You go to the library and help out with storing while you've gained experience from reading. Also you get paid"
      user.money += 25
      user.xp += 1
      console.log "You have #{user.xp}xp! Money: #{user.money}"
      check()
      setTimeout (-> townchoose()), 2500
    when random >= 8
      displayToPlayer 'While looking for a job you get robbed. You lose 10 money!'
      user.money -= 10
      check()
      console.log "Money: #{user.money}"
      setTimeout (-> townchoose()), 2500
    when random <= 4
      displayToPlayer 'You work at the pub and get paid 15 money!'
      user.money += 15
      console.log "Money:  #{user.money}"
      setTimeout (-> townchoose()), 2500
    when random <= 7
      displayToPlayer 'You go to the local car wash and gain some experience!'
      user.xp += 1
      console.log "You have #{user.xp}xp!"
      check()
      setTimeout (-> townchoose()), 2500
    else
      displayToPlayer 'No one wants to hire you! Tough luck.'
      setTimeout (-> townchoose()), 2500
