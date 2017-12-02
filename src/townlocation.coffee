money = 0
safe = 0
current = ->
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
