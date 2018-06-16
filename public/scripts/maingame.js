var bgmain, check, delay, fishes, game, hoverFX, moneygainFX, question, start, swimmingOutcomes, userData, win;

game = {
  queue: [],
  current: 0,
  nextOn: false,
  next: function() {
    game.nextOn = true;
    if (game.current >= game.queue.length) {
      game.nextOn = false;
      game.queue = [];
      return game.current = 0;
    } else {
      return game.queue[game.current++](game.next);
    }
  },
  action: function(act) {
    this.queue.push(act);
    if (!this.nextOn) {
      this.next();
    }
    return this;
  },
  delay: 3000
};

delay = function(c) {
  return (n) => {
    return setTimeout(n, c);
  };
};

// window.__defineSetter__ 'current', (v) -> console.log(v) or console.trace()
$(function() {
  $('#submit').click(function() {
    var question;
    question = window.question = $('#inputBox').val();
    $('#inputBox').val('');
    return window.current(question);
  }).parent().submit(function() {
    return false;
  });
  return $('.sound').click(function() {
    var el;
    el = $(this);
    if (el.hasClass('off')) {
      bgmain.play();
    } else {
      bgmain.pause();
    }
    return el.toggleClass('off');
  });
});

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
  hasDefeatedMutant: false
};

window.typingIntervals = []; // This will store the typing intervals for the message typing animations, so that they can be cleared on command

start = function() {
  if (typeof Storage === "undefined") { // if browser does not support local storage
    displayToPlayer("This browser does not support local storage");
    return;
  }
  $('#controls,#commies,#display').show();
  $('.button').hide();
  if ('EQuserData' in localStorage) {
    userData = JSON.parse(localStorage.EQuserData);
    updatestats();
    return townchoose();
  } else {
    displayToPlayer('Welcome, adventurer. What is your name?');
    return window.current = currents.name;
  }
};

question = '';

window.current = function() {};

hoverFX = new Audio('../../static/button-hover.wav');

bgmain = new Audio('../../static/locust.mp3');

moneygainFX = new Audio('../../static/money-gain.mp3');

bgmain.looped = true;

fishes = ['Guppy', 'SnakeFish', 'DragonFish', 'Boot', 'Tuna', 'GoldFish', 'Guaba', 'Man-eating snail', 'Goblin shark'];

// Array of outcome of swimming. Has description, Money and/or items
swimmingOutcomes = [
  {
    description: 'Dived and came out with sand..',
    money: 0
  },
  {
    description: 'Dived in and found a sack of coins!',
    money: 30
  },
  {
    description: 'Dived in and found a gold ring! It\'s going in your inventory',
    money: 0,
    items: ['Gold ring']
  },
  {
    description: 'Dived in and found a boot, It\'s useless',
    money: 0
  },
  {
    description: 'Dived in and found a small sack of coins!',
    money: 10
  },
  {
    description: 'Dived in and came out with nothing',
    money: 0
  },
  {
    description: 'Dived in and came out with a large sack of coins!',
    money: 45
  },
  {
    description: 'Dived in and came out with a book.',
    money: 0,
    items: ['Book']
  }
];

win = function() {
  var current;
  $('#mainh').html(user.name);
  user.armor = 123;
  user.weapon = 98;
  user.lvl = 50;
  user.xp = 0;
  user.money += 500;
  user.rod = -100;
  showme();
  displayToPlayer('You are the strongest hero go back to town?');
  return current = currents.win;
};

check = function() {
  if (user.xp >= 10) {
    user.lvl += 1;
    confirm(`You have leveled up to level ${user.lvl}!`);
    user.xp -= 10;
    switch (user.lvl) {
      case 2:
        alert('You can now go to the forest');
        break;
      case 3:
        alert('You can now venture into the cave... At your own risk...');
    }
  }
  if (user.money < 0) {
    return user.money = 0;
  }
};

$(document).ready(() => {
  return start();
});
