current = ->
beachchoose = ->
    displayToPlayer('We are at the beach. Fish, swim, or leave?')
    current = ->
      switch question.toUpperCase()
        when 'FISH'
          if rod <= 15
            displayToPlayer('You go to fish!')
            fishing = ->
                if rod <= 15
                  random = Math.floor(Math.random() * fishes.length + 1)
                  if random >= fishes.length
                    displayToPlayer('You were attacked by a sea glob fish! You lost 10 money and now have +3 rod damage. Try again?')
                    rod += 3
                    money -= 10
                    check()
                    current = ->
                      switch question.toUpperCase()
                        when 'YES' then fishing()
                        when 'NO' then beachchoose()
                  else
                    displayToPlayer("#{name} caught a #{fishes[random]}! It\'s going in your inventory. Try again?")
                    inventory.push(fishes[random])
                    current = ->
                      switch question.toUpperCase()
                        when 'YES' then fishing()
                        when 'NO' then beachchoose()
                else
                  displayToPlayer("Your rod has #{rod} damage! Go fix it at the town!")
                  setTimeout (-> beachchoose()), 1500
            setTimeout (-> fishing()), 1500
          else
            displayToPlayer(rod + 'dmg')
            beachchoose()
        when 'SWIM'
          displayToPlayer('You go swimming..')
          swimming = ->
            random = Math.floor Math.random() * swimmingOutcomes.length + 1
            if random >= swimmingOutcomes.length
              displayToPlayer("#{name} was stung by a deadly jelly fish! You lost half of your money at the town hospital")
              money /= 2
              setTimeout (-> townchoose()), 3000
            else
              displayToPlayer("#{swimmingOutcomes[random][0]}. Dive in again?")
              money += swimmingOutcomes[random][1]
              check()
              if swimmingOutcomes[random][2]
                setTimeout (->
                  inventory.push(swimmingOutcomes[random][2])
                  displayToPlayer("Added #{swimmingOutcomes[random][2]} to inventory")
                ), 1500
              setTimeout (->
                current = ->
                  switch question.toUpperCase()
                    when 'YES' then swimming()
                    when 'NO' then beachchoose()
              ), 3200
          setTimeout swimming(), 1500
        when 'LEAVE'
          displayToPlayer('going to town')
          setTimeout (-> townchoose()), 1600
