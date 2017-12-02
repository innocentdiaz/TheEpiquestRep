current = ->
rod = 0
money = 0
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
