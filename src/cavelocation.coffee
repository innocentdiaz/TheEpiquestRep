current = ->
question = ''
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
