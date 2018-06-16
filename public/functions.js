var playtheme, push, question, reset, updatestats;

window.displayToPlayer = function(message) {
  return $('#display').html(message);
};

question = '';

// userData.inventory = []
push = function(item) {
  return userData.inventory.push(item);
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
  return localStorage.EQuserData = JSON.stringify(userData);
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
