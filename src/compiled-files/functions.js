(function() {
  var daymode, nightmode, playtheme, push, question, reset, showme, updatestats;

  window.displayToPlayer = function(message) {
    return $('#display').html(message);
  };

  question = '';

  push = function(item) {
    return user.inventory.push(item);
  };

  showme = function() {
    return alert("NAME: " + user.name + "\nMONEY, SAFE AND ROD: " + user.money + ", " + user.safe + ", " + user.rod + "\nLVL AND XP: " + user.lvl + ", " + user.xp + "\nARMOR AND WEAPON: " + user.armor + ", " + user.weapon);
  };

  updatestats = function() {
    $('#name').text(user.name);
    $('#money').text(user.money);
    $('#safe').text(user.safe);
    $('#rod').text(user.rod);
    $('#level').text(user.lvl);
    $('#xp').text(user.xp);
    $('#armor').text(user.armor);
    $('#weapon').text(user.weapon);
    return localStorage.player = JSON.stringify(user);
  };

  playtheme = function(selected) {
    switch (selected) {
      case 'mario':
        mario.loop = true;
        return mario.play();
    }
  };

  reset = function() {
    if (confirm('Reset game?').toUpperCase() === 'YES') {
      return location.reload();
    }
  };

  nightmode = function() {
    $('body').css('background-color', 'black');
    $('button').css('background-color', 'grey');
    return $('#display').css('border-color', 'white');
  };

  daymode = function() {
    $('body').css('background-color', 'white');
    $('button').css('background-color', 'green');
    return $('#display').css('border-color', 'black');
  };

}).call(this);
