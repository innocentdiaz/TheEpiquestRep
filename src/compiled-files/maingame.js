(function() {
  var check, createUser, delay, fishes, game, mario, question, start, swimmingOutcomes, u, win;

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
    }
  };

  delay = function(c) {
    return (function(_this) {
      return function(n) {
        return setTimeout(n, c);
      };
    })(this);
  };

  $(function() {
    $('#submit').click(function() {
      var question;
      question = window.question = $('#inputBox').val();
      $('#inputBox').val('');
      return window.current(question);
    }).parent().submit(function() {
      return false;
    });
    $('.sound').click(function() {
      var el;
      el = $(this);
      if (el.hasClass('off')) {
        mario.play();
      } else {
        mario.pause();
      }
      return el.toggleClass('off');
    });
    return start();
  });

  u = {
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

  window.user = null;

  start = function() {
    $('#controls,#commies,#display').show();
    $('.button').hide();
    if ('player' in localStorage) {
      u = JSON.parse(localStorage.player);
      createUser();
      townchoose();
      return updatestats();
    } else {
      createUser();
      displayToPlayer('What is your name?');
      return window.current = currents.name;
    }
  };

  createUser = function() {
    return window.user = new Proxy(u, {
      set: function(t, p, v) {
        t[p] = v;
        return updatestats();
      }
    });
  };

  question = '';

  window.current = function() {};

  mario = new Audio('../static/dire.mp3');

  mario.looped = true;

  fishes = ['Guppy', 'SnakeFish', 'DragonFish', 'Boot', 'Tuna', 'GoldFish', 'Guaba', 'Man-eating snail', 'Goblin shark'];

  swimmingOutcomes = [['Dived and came out with sand..', 0], ['Dived in and found a sack of coins!', 30], ['Dived in and found a gold ring! It\'s going in your inventory', 0, 'Gold ring'], ['Dived in and found a boot, It\'s useless', 0], ['Dived in and found a small sack of coins!', 10], ['Dived in and came out with nothing', 0], ['Dived in and came out with a large sack of coins!', 45], ['Dived in and came out with a book.', 0, 'Book']];

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
      confirm("You have leveled up to level " + user.lvl + "!");
      user.xp -= 10;
      switch (user.lvl) {
        case 2:
          confirm('You can now go to the forest');
          break;
        case 3:
          confirm('You can now venture into the cave... At your own risk...');
      }
    }
    if (user.money < 0) {
      return user.money = 0;
    }
  };

}).call(this);
