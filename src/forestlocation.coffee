current = ->
forestchoose = ->
    displayToPlayer 'There are three paths, one leads you to a shop, the other to an arena, and the last to hunting grounds. Which way to do you pick?'
    current = ->
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

      floop = ->
        current = ->
          displayToPlayer 'Upgrade Armor for 20 money, Upgrade Weapon for 15, or leave.'
          switch question.toUpperCase()
            when 'ARMOR'
              if money >= 20
                displayToPlayer 'Your armor goes up by 1 point! You lose 20. Armor, weapon or leave?'
                armor += 1
                money -= 20
                check()
                console.log "Money: #{money}. Armor: #{armor}"
                current = -> floop()
              else
                displayToPlayer 'Not enough money! Armor, weapon or leave?'
                current = -> floop()
            when 'WEAPON'
              if money >= 15
                displayToPlayer 'Your weapon goes up by 1 point! You lose 15 money. Armor, weapon or leave?'
                weapon += 1
                money -= 15
                check()
                console.log "Money: #{money}. Weapon: #{weapon}"
                current = -> floop()
              else
                displayToPlayer 'Not enough money! Armor, weapon or leave?'
                current = -> floop()
            when 'LEAVE'
              displayToPlayer 'Floop: floop ya\' lateR PARTNR\''
              setTimeout (-> forestchoose()), 2000
      arenachoose = ->
        displayToPlayer 'You arrive at the \'Dome of Death\'. Fight?'
        current = ->
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

      huntchoose = ->
        random = Math.random() * 100 + 1
        switch
          when random <= 10
            question = prompt 'You hunted a unichord! It\'s going in your inventory.. Hunt again?'
              .toUpperCase()
            inventory.push('Unichord')
            switch question
              when 'YES' then huntchoose()
              when 'NO'
                displayToPlayer 'Heading back...'
                setTimeout (-> forestchoose()), 1600
              else
                displayToPlayer 'Not an option'
                setTimeout (-> forestchoose()), 1600
          when random <= 20
            question = prompt 'You hunted a goblin! He pays you to let him go. Hunt again?'
              .toUpperCase()
            money += 10
            console.log "Money: #{money}"
            switch question
              when 'YES' then huntchoose()
              when 'NO'
                confirm('Heading back...')
                forestchoose()
              else
                confirm('Not an option')
                forestchoose()
          when random <= 30
            question = prompt('You hunted a shell-snake! It\'s going in your inventory.. Hunt again?').toUpperCase()
            inventory.push('shell-snake')
            money += 3
            switch question
              when 'YES' then huntchoose()
              when 'NO'
                confirm('Heading back...')
                forestchoose()
              else
                confirm 'Not an option'
                forestchoose()
          when random <= 40
            question = prompt 'You hunted a grizzlor bear! It\'s going into your inventory! Hunt again?'
              .toUpperCase()
            inventory.push('Grizzlor mama')
            switch
              when 'YES' then huntchoose()
              when 'NO'
                confirm('Heading back...')
                forestchoose()
              else
                confirm('Not an option')
                forestchoose()
          when random <= 42
            question = prompt 'You hunted a.. Kairy?! Kairy shines up your armor and runs back into the bushes. +1armor - Hunt again?'
              .toUpperCase()
            armor += 1
            switch
              when 'YES' then huntchoose()
              when 'NO'
                confirm 'Heading back...'
                forestchoose()
              else
                confirm 'Not an option'
                forestchoose()
          when random <= 50
            question = prompt 'You hunted a... boot? You throw it away. Hunt again?'
              .toUpperCase()
            switch question
              when 'YES' then huntchoose()
              when 'NO'
                confirm 'Heading back...'
                forestchoose()
              else
                confirm 'Not an option'
                forestchoose()
          when random <= 55
            question = prompt 'You hunted a flying-butt! It\'s going in your inventory.. Hunt again?'
              .toUpperCase()
            inventory.push 'flying ass'
            switch question
              when 'YES' then huntchoose()
              when 'NO'
                confirm 'Heading back...'
                forestchoose()
              else
                confirm 'Not an option'
                forestchoose()
          when random <= 65
            question = prompt 'You hunted an ordinary rabbit. It\'s going in your inventory.. Hunt again?'
              .toUpperCase()
            inventory.push 'wabbit'
            switch
              when 'YES' then huntchoose()
              when 'NO'
                confirm 'Heading back...'
                forestchoose()
              else
                confirm 'Not an option'
                forestchoose()
          when random <= 75
            question = prompt 'You hunted a pegavis! It\'s going in your inventory.. Hunt again?'
              .toUpperCase()
            inventory.push 'Pegavis'
            switch question
              when 'YES' then huntchoose()
              when 'NO'
                confirm 'Heading back...'
                forestchoose()
              else
                confirm 'Not an option'
                forestchoose()
          when random is 76
            question = prompt 'You hunted a bug... but it is not a bug, it is feature. Hunt again?'
              .toUpperCase()
            inventory.push 'Feature'
            switch question
              when 'YES' then huntchoose()
              when 'NO'
                confirm 'Heading back...'
                forestchoose()
              else
                confirm 'Not an option'
                forestchoose()
          else
            question = prompt 'You\'ve been raided by imps! -50 money. Try again?'
              .toUpperCase()
            money -= 50
            check()
            console.log "Money: #{money}"
            switch question
              when 'YES' then huntchoose()
              when 'NO'
                confirm 'You head back'
                forestchoose()
              else
                confirm 'not an option'
                forestchoose()
