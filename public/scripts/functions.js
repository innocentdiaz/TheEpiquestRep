var playtheme, push, question, reset, updatestats;

window.displayToPlayer = function(message) {
  var index, interval;
  if (window.typingInterval) {
    clearInterval(window.typingInterval);
  }
  $('#display').html("");
  $(".buttons").each(function(i, element) {
    return $(element).addClass('disabled');
  });
  interval = 50;
  index = 0;
  window.typingInterval = setInterval(function() {
    $("#display").append(message.charAt(index));
    index++;
    if (index === message.length) {
      clearInterval(window.typingInterval);
      return $(".buttons").removeClass('disabled');
    }
  }, interval);
  return interval += 30;
};

question = '';

push = function(items) {
  return items.forEach(item(function() {
    return userData.inventory.push(item);
  }));
};

updatestats = function() {
  // $ '#stats'
  // .html "Name: #{userData.name} Money: #{userData.money} Safe: #{userData.safe} Rod: #{userData.rod} Level: #{userData.lvl} XP: #{userData.xp} Armor: #{userData.armor} Weapon: #{userData.weapon}"
  $('#name').text(userData.name);
  $('#money').text(userData.money);
  $('#safe').text(userData.safe);
  $('#rod').text(userData.rod);
  $('#level').text(userData.lvl);
  $('#xp').text(userData.xp);
  $('#armor').text(userData.armor);
  $('#weapon').text(userData.weapon);
  return localStorage.setItem('EQuserData', JSON.stringify(userData));
};

playtheme = function(selected) {
  switch (selected) {
    case 'bgmain':
      bgmain.loop = true;
      return bgmain.play();
  }
};

reset = function() {
  var userData;
  delete localStorage.EQuserData;
  userData = {
    name: '',
    lvl: 1,
    xp: 0,
    inventory: [],
    money: 0,
    safe: 0,
    rod: 0,
    armor: 0,
    weapon: 0,
    key: 1
  };
  return start();
};

// submit = (event) ->
// keycode = event.keyCode

// if keycode == 13
// question = $('#inputBox').val()
// $('#inputBox').val('')
// current()
