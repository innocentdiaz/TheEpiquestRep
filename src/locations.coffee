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
