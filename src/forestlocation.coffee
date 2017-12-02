current = ->
forestchoose = ->
  displayToPlayer 'There are three paths, one leads you to a shop, the other to an arena, and the last to hunting grounds. Which way to do you pick?'
  current = currents.forest
floop = ->
  current = currents.floop
arenachoose = ->
  displayToPlayer 'You arrive at the \'Dome of Death\'. Fight?'
  current = currents.arena
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
