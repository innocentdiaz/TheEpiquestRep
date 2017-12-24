var playtheme, push, question, updatestats;

window.displayToPlayer = function(message) {
  return $('#display').html(message);
};

question = '';

push = function(item) {
  return user.inventory.push(item);
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
