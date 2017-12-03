question = ''
current = ->
money = 0
safe = 0
rod = 0
key = 0
currents =
  name: ->
    name = question
    displayToPlayer("Let us begin, #{name}!")
    townchoose()
  town: ->
    switch question.toUpperCase()
      when 'WORK' then choosework()
      when 'FIX'
        displayToPlayer "Fixing your rod will cost you #{rod} money. Are you sure?"
        current = currents.fix
      when inventory.length >= 1 and 'SELL'
        displayToPlayer "your items are: #{inventory.join(', ')}. Sell?"
        current = currents.sell
      when inventory.length < 1 and 'SELL'
        displayToPlayer 'You have no items in your inventory..'
        setTimeout (-> townchoose()), 1800
      when 'STATS' then showme()
      when 'BEACH' then beachchoose()
      when  lvl >= 2 and 'FOREST'
        displayToPlayer 'We are on our way to the enchanted forest.......'
        setTimeout (-> forestchoose()), 1500
      when lvl >= 3 and 'CAVE'
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
        if money >= rod
          money -= rod
          rod = 0
          displayToPlayer "You have #{money} money and #{rod} dmg!"
          setTimeout (-> townchoose()), 2000
        else
          displayToPlayer 'Not enough money'
          setTimeout (-> townchoose()), 2000
      when 'NO' then townchoose()
  sell: ->
    switch
      when 'YES'
        money += inventory.length * 2.5
        inventory.length = 0
        displayToPlayer "You have sold all your items. Your money is #{money}."
        setTimeout (-> townchoose()), 2000
      when 'NO'
        setTimeout (-> townchoose()), 2000
  safe: ->
    switch question.toUpperCase()
      when 'STORE'
        if money >= 1
          safe += money
          money = 0
          displayToPlayer 'You stored all your money in the safe'
          setTimeout (-> townchoose()), 1500
        else
          displayToPlayer 'You have no money!'
          setTimeout (-> townchoose()), 1500
      when 'RECOVER'
        if safe >= 1
          money += safe
          safe = 0
          displayToPlayer 'You recovered all your money from the safe'
          setTimeout (-> townchoose()), 1500
        else
          displayToPlayer 'There is nothing in the safe!'
          setTimeout (-> townchoose()), 1500
  beach: ->
    switch question.toUpperCase()
      when 'FISH'
        if rod <= 15
          displayToPlayer('You go to fish!')
          setTimeout (-> fishing()), 1500
        else
          displayToPlayer "#{rod}dmg"
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
    else displayToPlayer "Thank you for playing, #{name}!"
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
        if money >= 20
          displayToPlayer 'Your armor goes up by 1 point! You lose 20. Armor, weapon or leave?'
          armor += 1
          money -= 20
          check()
          console.log "Money: #{money}. Armor: #{armor}"
          current = currents.floop
        else
          displayToPlayer 'Not enough money! Armor, weapon or leave?'
          current = currents.floop
      when 'WEAPON'
        if money >= 15
          displayToPlayer 'Your weapon goes up by 1 point! You lose 15 money. Armor, weapon or leave?'
          weapon += 1
          money -= 15
          check()
          console.log "Money: #{money}. Weapon: #{weapon}"
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
            if armor >= 13 and weapon >= 11
              confirm 'You SLAYED THE MUTANT! +15xp, +50money'
              if key is 1
                confirm 'The cave trembles and echoes are heard...'
                key = 0
              xp += 15
              money += 50
              key = 0
              console.log "money: #{money}+15xp"
              check()
              forestchoose()
            else
              confirm 'You were PWNED by the mutant and sent to the hospital! Get better equipment!'
              money -= 10
              check()
              console.log "Money: #{money}"
              townchoose()
          when random <= 20
            confirm 'SKELETRON has entered the match!'
            if armor >= 10 and weapon >= 7
              confirm 'You PWNED SKELETRON and from his aqcuired +20money and +5xp'
              xp += 5
              money += 20
              check()
              forestchoose()
            else
              confirm 'SKELETRON SENT YOU RUNNING BACK HOME!Get better equipment!'
              xp -= 1
              money -= 5
              check()
              console.log "Money: #{money} #{xp}xp"
              townchoose()
          when random <= 40
              confirm 'INFECTED GLOB has entered the match!'
              if armor >= 6 and weapon >= 7
                confirm 'You killed the INFECTED GLOB! Gained +10money and +4xp'
                money += 10
                xp += 4
                check()
                forestchoose()
              else
                confirm 'The Glob jaZZED you UP BACK to the hospital! -5money - Get better equipment!'
                money -= 5
                check()
                console.log "Money: #{money}"
                townchoose()
          when random <= 60
            confirm 'An imp joined the fight'
            if armor >= 4 and weapon >= 4
              confirm 'You SMACKED the imp! +15 money +2xp'
              money += 15
              xp += 2
              forestchoose()
            else
              confirm 'Daaaang that imp frigged you UP! Go back home!  -3money - Get better equipment!'
              money -= 3
              check()
              townchoose()
          when random <= 70
            confirm 'Goblins joined the battle-!'
            if armor >= 2 and weapon >= 2
              confirm 'You FLOOPED those goblins UP +15money +2xp'
              money += 15
              xp += 2
              check()
              forestchoose()
            else
              confirm('Snap! Those goblins diddled you! Go back home! Get better equipment!')
              money -= 3
              check()
              townchoose()
          when random <= 100
            confirm 'You fought a boot and won.. +5money'
            money += 5
            forestchoose()
      when 'NO'
        displayToPlayer 'You head back...'
        setTimeout (-> forestchoose()), 1600
  cave: ->
    switch question.toUpperCase()
      when 'YES'
        displayToPlayer 'You go throught the doors, as they close behind you, you find yourself in a massive chamber with a large world-devourer infront of you!'
        if armor >= 30 and weapon >= 30
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
    if armor >= 19 and weapon >= 10
      if question is 'ATTACK' and weapon >= 12
        displayToPlayer 'You destroy the devourer with one massive plasma blast. YOU WIN'
        setTimeout (->
          displayToPlayer "Thank you for playing #{name}!"
          win()
        ), 1500
      else
        displayToPlayer 'You defend against the mighty creature - but as you do, it begins circling around you. As a final resort you unleash all of your power, killing you and the creature, curing the world of the the devourer. You win the ULTIMATE HERO ENDING'
        $ '#mainh'
          .html "#{name} the hero"
        reset()
    else
      displayToPlayer 'You were too weak to defend yourself. The devourer eats you up in one large gulp. Game Over. Try getting better gear'
      money -= 30
      check()
      console.log money
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
cavechoose = ->
    if key is 0
      if Math.random() * 100 + 1 <= 20
        displayToPlayer 'You are attacked by a spider-skeleton-dungeon-keeper at the entrance!'
        if armor >= 16 and weapon >= 12
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
    if rod <= 15
      random = Math.floor(Math.random() * fishes.length + 1)
      if random >= fishes.length
        displayToPlayer 'You were attacked by a sea glob fish! You lost 10 money and now have +3 rod damage. Try again?'
        rod += 3
        money -= 10
        check()
        current = currents.fishing
      else
        displayToPlayer "#{name} caught a #{fishes[random]}! It\'s going in your inventory. Try again?"
        inventory.push(fishes[random])
        current = currents.fishing
    else
      displayToPlayer "Your rod has #{rod} damage! Go fix it at the town!"
      setTimeout (-> beachchoose()), 1500
swimming = ->
  random = Math.floor Math.random() * swimmingOutcomes.length + 1
  if random >= swimmingOutcomes.length
    displayToPlayer "#{name} was stung by a deadly jelly fish! You lost half of your money at the town hospital"
    money /= 2
    setTimeout (-> townchoose()), 3000
  else
    displayToPlayer "#{swimmingOutcomes[random][0]}. Dive in again?"
    money += swimmingOutcomes[random][1]
    check()
    if swimmingOutcomes[random][2]
      setTimeout (->
        inventory.push(swimmingOutcomes[random][2])
        displayToPlayer "Added #{swimmingOutcomes[random][2]} to inventory"
      ), 1500
    setTimeout (->
      current = currents.swimming
    ), 3200
townchoose = ->
  switch
    when lvl >= 3 then displayToPlayer '=TOWN= Work, fix, sell, safe, beach, forest, cave =TOWN='
    when lvl == 2 then displayToPlayer '=TOWN= Work, fix, sell, safe, beach, forest =TOWN='
    else displayToPlayer '=TOWN= Work, fix, sell, safe, beach =TOWN='
  current = currents.town
choosework = ->
  random = Math.random() * 10 + 1
  switch
    when random <= 2
      displayToPlayer "You go to the library and help out with storing while you've gained experience from reading. Also you get paid"
      money += 25
      xp += 1
      console.log "You have #{xp}xp! Money: #{money}"
      check()
      setTimeout (-> townchoose()), 2500
    when random >= 8
      displayToPlayer 'While looking for a job you get robbed. You lose 10 money!'
      money -= 10
      check()
      console.log "Money: #{money}"
      setTimeout (-> townchoose()), 2500
    when random <= 4
      displayToPlayer 'You work at the pub and get paid 15 money!'
      money += 15
      console.log "Money:  #{money}"
      setTimeout (-> townchoose()), 2500
    when random <= 7
      displayToPlayer 'You go to the local car wash and gain some experience!'
      xp += 1
      console.log "You have #{xp}xp!"
      check()
      setTimeout (-> townchoose()), 2500
    else
      displayToPlayer 'No one wants to hire you! Tough luck.'
      setTimeout (-> townchoose()), 2500
