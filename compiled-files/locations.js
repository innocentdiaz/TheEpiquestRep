var arenachoose, beachchoose, cavechoose, choosework, cur, current, display, fishing, floop, forestchoose, huntchoose, hunts, question, swimming, townchoose, yesno;

question = '';

current = function() {};

display = function(msg) {
  var f;
  if (typeof msg === 'string') {
    return function(n) {
      displayToPlayer(msg);
      return n();
    };
  } else {
    return f = function(n) {
      displayToPlayer(msg.shift());
      if (msg.length) {
        return setTimeout(f, game.delay, n);
      } else {
        return n();
      }
    };
  }
};

cur = function(c) {
  return function(n) {
    var butts, i, j, len, len1, text;
    if (typeof currents[c] === 'function') {
      current = currents[c];
      $('.buttons').html('');
      butts = currents[c]._buttons;
      if (butts) {
        $('#input').hide();
        if (typeof butts === 'function') {
          butts = butts();
        }
        for (i = 0, len = butts.length; i < len; i++) {
          text = butts[i];
          text = text.split('->');
          $('.buttons').append($("<button>" + text[0] + "</button>").click((function(t) {
            return function() {
              question = t;
              return current(t);
            };
          })(text[1] || text[0])));
        }
      } else {
        $('#input').show();
      }
    } else {
      current = function() {};
      $('#input').hide();
      $('.buttons').text('');
      butts = currents[c]._buttons;
      if (typeof butts === 'function') {
        butts = butts();
      }
      for (j = 0, len1 = butts.length; j < len1; j++) {
        text = butts[j];
        text = text.split('->');
        $('.buttons').append($("<button>" + text[0] + "</button>").click((function(f) {
          return function() {
            return f();
          };
        })(currents[c][(text[1] || text[0]).toLowerCase()])));
      }
    }
    return n();
  };
};

yesno = ['Yes', 'No'];

window.currents = {
  name: function() {
    window.user.name = window.question;
    return game.action(display("Let us begin, " + user.name + "!")).action(delay(3000)).action(townchoose);
  },
  town: {
    _buttons: function() {
      var res;
      res = ['Work->work', 'Safe->safe', 'Fix your rod->fix', 'Sell things->sell', 'Go to beach->beach'];
      if (user.lvl >= 2) {
        res = res.concat(['Go to forest->forest']);
      }
      if (user.lvl >= 3) {
        res = res.concat(['Go to cave->cave']);
      }
      return res;
    },
    safe: function() {
      return game.action(display('Store your money or recover it?')).action(cur('safe'));
    },
    cave: function() {
      return game.action(display('We are on our way to the cave.......')).action(cavechoose);
    },
    forest: function() {
      return forestchoose();
    },
    sell: function() {
      if (user.inventory.length >= 1) {
        return game.action(display("Your items are: " + (user.inventory.join(', ')) + ". Sell?")).action(cur('sell'));
      } else {
        return game.action(display('You have no items in your inventory..')).action(delay(3000)).action(townchoose);
      }
    },
    stats: function() {
      return showme();
    },
    beach: function() {
      return beachchoose();
    },
    fix: function() {
      return game.action(display("Fixing your rod will cost you " + user.rod + " money. Are you sure?")).action(cur('fix'));
    },
    work: function() {
      return choosework();
    }
  },
  fix: {
    _buttons: yesno,
    yes: function() {
      if (user.money >= user.rod) {
        user.money -= user.rod;
        user.rod = 0;
        return game.action(display("You have " + user.money + " money and " + user.rod + " dmg!")).action(delay(3000)).action(townchoose);
      } else {
        return game.action(display('Not enough money')).action(delay(3000)).action(townchoose);
      }
    },
    no: function() {
      return townchoose();
    }
  },
  sell: {
    _buttons: yesno,
    yes: function() {
      user.money += user.inventory.length * 2.5;
      user.inventory.length = 0;
      return game.action(display("You have sold all your items. Your money is " + user.money + ".")).action(delay(3000)).action(townchoose);
    },
    no: function() {
      return game.action(townchoose);
    }
  },
  safe: {
    _buttons: ['Store money to safe->store', 'Recover all moneys from safe->recover'],
    store: function() {
      if (user.money >= 1) {
        user.safe += user.money;
        user.money = 0;
        return game.action(display('You stored all your money in the safe')).action(delay(3000)).action(townchoose);
      } else {
        return game.action(display('You have no money!')).action(delay(3000)).action(townchoose);
      }
    },
    recover: function() {
      if (user.safe >= 1) {
        user.money += user.safe;
        user.safe = 0;
        return game.action(display('You recovered all your money from the safe')).action(delay(3000)).action(townchoose);
      } else {
        return game.action(display('There is nothing in the safe!')).action(delay(3000)).action(townchoose);
      }
    }
  },
  beach: {
    _buttons: ['Fishing->fish', 'Go swimming->swim', 'Go back to town->leave'],
    fish: function() {
      if (user.rod <= 15) {
        return game.action(display('You go to fish!')).action(delay(3000)).action(fishing);
      } else {
        return game.action(display(user.rod + "dmg")).action(delay(3000)).action(beachchoose);
      }
    },
    swim: function() {
      return game.action(display('You go swimming')).action(delay(3000)).action(swimming);
    },
    leave: function() {
      return game.action(display('Going to town')).action(delay(3000)).action(townchoose);
    }
  },
  fishing: {
    _buttons: yesno,
    yes: function() {
      return fishing();
    },
    no: function() {
      return beachchoose();
    }
  },
  swimming: {
    _buttons: yesno,
    yes: function() {
      return swimming();
    },
    no: function() {
      return beachchoose();
    }
  },
  win: {
    _buttons: yesno,
    yes: function() {
      return townchoose();
    },
    no: function() {
      return game.action(display("Thank you for playing, " + user.name + "!"));
    }
  },
  forest: {
    _buttons: ['Go fight to arena->arena', 'Go to shop->shop', 'Go hunting->hunt', 'Leave back to town->leave'],
    arena: function() {
      return game.action(display('You head to the arena....')).action(delay(3000)).action(arenachoose);
    },
    shop: function() {
      return game.action(display(['You are greeted by a cartoonish goblin named floop-flop', 'floop-flop: BUY SOMESTUFF yeS? OOWeeE ITS TOPNPOTCH FOREST WEAPONS AND ARMOR YEs', 'Upgrade Armor for 20 money, Upgrade Weapon for 15, or leave.'])).action(cur('floop'));
    },
    hunt: function() {
      return game.action(display('You head to the hunting grounds...')).action(delay(3000)).action(huntchoose);
    },
    leave: function() {
      return game.action(display('You head to the town')).action(delay(3000)).action(townchoose);
    }
  },
  floop: {
    _buttons: ['Upgrade armor->armor', 'Upgrade weapon->weapon', 'Leave shop->leave'],
    armor: function() {
      if (user.money >= 20) {
        user.armor += 1;
        user.money -= 20;
        check();
        return game.action(display('Your armor goes up by 1 point! You lose 20. Armor, weapon or leave?')).action(cur('floop'));
      } else {
        return game.action(display('Not enough money! Armor, weapon or leave?')).action(cur('floop'));
      }
    },
    weapon: function() {
      if (user.money >= 15) {
        user.weapon += 1;
        user.money -= 15;
        check();
        return game.action(display('Your weapon goes up by 1 point! You lose 15 money. Armor, weapon or leave?')).action(cur('floop'));
      } else {
        return game.action(display('Not enough money! Armor, weapon or leave?')).action(cur('floop'));
      }
    },
    leave: function() {
      return game.action(display('Floop: floop ya\' lateR PARTNR\'')).action(delay(3000)).action(forestchoose);
    }
  },
  arena: {
    _buttons: yesno,
    yes: function() {
      var key, random;
      random = Math.random() * 100 + 1;
      switch (false) {
        case !(random <= 5):
          game.action(display('THE MUTANT has entered the match!')).action(delay(3000));
          if (user.armor >= 13 && user.weapon >= 11) {
            game.action(display('You SLAYED THE MUTANT! +15xp, +50money')).action(delay(3000));
            if (user.key === 1) {
              game.action(display('The cave trembles and echoes are heard...')).action(delay(3000));
              user.key = 0;
            }
            user.xp += 15;
            user.money += 50;
            moneygainFX.play();
            key = 0;
            check();
            return game.action(arenachoose);
          } else {
            user.money -= 10;
            check();
            return game.action(display('You were PWNED by the mutant and sent to the hospital! Get better equipment!')).action(delay(3000)).action(townchoose);
          }
          break;
        case !(random <= 20):
          game.action(display('SKELETRON has entered the match!')).action(delay(3000));
          if (user.armor >= 10 && user.weapon >= 7) {
            user.xp += 5;
            user.money += 20;
            moneygainFX.play();
            check();
            return game.action(display('You PWNED SKELETRON and from his aqcuired +20money and +5xp')).action(delay(3000)).action(arenachoose);
          } else {
            user.xp -= 1;
            user.money -= 5;
            check();
            return game.action(display('SKELETRON SENT YOU RUNNING BACK HOME!Get better equipment!')).action(delay(3000)).action(townchoose);
          }
          break;
        case !(random <= 40):
          game.action(display('INFECTED GLOB has entered the match!'));
          if (user.armor >= 6 && user.weapon >= 7) {
            user.money += 10;
            user.xp += 4;
            check();
            return game.action(display('You killed the INFECTED GLOB! Gained +10money and +4xp')).action(delay(3000)).action(arenachoose);
          } else {
            user.money -= 5;
            check();
            return game.action(display('The Glob jaZZED you UP BACK to the hospital! -5money - Get better equipment!')).action(delay(3000)).action(townchoose);
          }
          break;
        case !(random <= 60):
          game.action(display('An imp joined the fight')).action(delay(3000));
          if (user.armor >= 4 && user.weapon >= 4) {
            user.money += 15;
            moneygainFX.play();
            user.xp += 2;
            check();
            return game.action(display('You SMACKED the imp! +15 money +2xp')).action(delay(3000)).action(arenachoose);
          } else {
            user.money -= 3;
            check();
            return game.action(display('Daaaang that imp frigged you UP! Go back home!  -3money - Get better equipment!')).action(delay(3000)).action(townchoose);
          }
          break;
        case !(random <= 70):
          game.action(display('Goblins joined the battle-!')).action(delay(3000));
          if (user.armor >= 2 && user.weapon >= 2) {
            user.money += 15;
            user.xp += 2;
            check();
            return game.action(display('You FLOOPED those goblins UP +15money +2xp')).action(delay(3000)).action(arenachoose);
          } else {
            user.money -= 3;
            check();
            return game.action(display('Snap! Those goblins diddled you! Go back home! Get better equipment!')).action(delay(3000)).action(townchoose);
          }
          break;
        case !(random <= 100):
          user.money += 5;
          return game.action(display('You fought a boot and won.. +5money')).action(delay(3000)).action(arenachoose);
      }
    },
    no: function() {
      return game.action(display('You head back...')).action(delay(3000)).action(forestchoose);
    }
  },
  cave: {
    _buttons: yesno,
    yes: function() {
      game.action(display('You go throught the doors, as they close behind you, you find yourself in a massive chamber with a large world-devourer infront of you!')).action(delay(3000));
      if (user.armor >= 30 && user.weapon >= 30) {
        return game.action(display('You slice the devourer in two. killing it instantly because of your massive strength. YOU WIN!')).action(delay(3000)).action(function(n) {
          key += 1;
          win();
          return n();
        });
      } else {
        return game.action(display(['The devourer expands his long putrid body out of the a massive hole in the wall, charging at you', 'Attack or defend?'])).action(cur('devourer'));
      }
    },
    no: function() {
      return game.action(display('You run out of the cave and back to the town')).action(delay(3000)).action(townchoose);
    }
  },
  devourer: {
    _buttons: ['Attack', 'Defend'],
    attack: function() {
      if (user.armor >= 19 && user.weapon >= 10) {
        if (user.weapon >= 12) {
          return game.action(display(['You destroy the devourer with one massive plasma blast. YOU WIN', "Thank you for playing " + user.name + "!"])).action(function(n) {
            win();
            return n();
          });
        } else {
          game.action(display('You defend against the mighty creature - but as you do, it begins circling around you. As a final resort you unleash all of your power, killing you and the creature, curing the world of the the devourer. You win the ULTIMATE HERO ENDING'));
          $('#mainh').html(user.name + " the hero");
          return reset();
        }
      } else {
        user.money -= 30;
        check();
        return game.action(display('You were too weak to defend yourself. The devourer eats you up in one large gulp. Game Over. Try getting better gear')).action(delay(3000)).action(townchoose);
      }
    },
    defend: function() {
      if (user.armor >= 19 && user.weapon >= 10) {
        game.action(display('You defend against the mighty creature - but as you do, it begins circling around you. As a final resort you unleash all of your power, killing you and the creature, curing the world of the the devourer. You win the ULTIMATE HERO ENDING'));
        $('#mainh').html(user.name + " the hero");
        return reset();
      } else {
        user.money -= 30;
        check();
        return game.action(display('You were too weak to defend yourself. The devourer eats you up in one large gulp. Game Over. Try getting better gear')).action(delay(3000)).action(townchoose);
      }
    }
  },
  hunt: {
    _buttons: yesno,
    yes: function() {
      return huntchoose();
    },
    no: function() {
      return game.action(display('Heading back...')).action(delay(3000)).action(forestchoose);
    }
  }
};

forestchoose = function(n) {
  game.action(display('There are three paths, one leads you to a shop, the other to an arena, and the last to hunting grounds. Which way to do you pick?')).action(cur('forest'));
  if (n) {
    return n();
  }
};

floop = function() {
  return game.action(cur('floop'));
};

arenachoose = function(n) {
  game.action(display('You arrive at the \'Dome of Death\'. Fight?')).action(cur('arena'));
  if (n) {
    return n();
  }
};

hunts = [
  {
    num: 10,
    msg: 'You hunted a unichord! It\'s going in your inventory.. Hunt again?',
    props: {
      inventory: 'Unichord'
    }
  }, {
    num: 20,
    msg: 'You hunted a goblin! He pays you to let him go. Hunt again?',
    props: {
      money: 10
    }
  }, {
    num: 30,
    msg: 'You hunted a shell-snake! It\'s going in your inventory.. Hunt again?',
    props: {
      inventory: 'shell-snake'
    }
  }, {
    num: 40,
    msg: 'You hunted a grizzlor bear! It\'s going into your inventory! Hunt again?',
    props: {
      inventory: 'Grizzlor mama'
    }
  }, {
    num: 42,
    msg: 'You hunted a.. Kairy?! Kairy shines up your armor and runs back into the bushes. +1armor - Hunt again?',
    props: {
      armor: 1
    }
  }, {
    num: 50,
    msg: 'You hunted a... boot? You throw it away. Hunt again?'
  }, {
    num: 55,
    msg: 'You hunted a flying-butt! It\'s going in your inventory.. Hunt again?',
    props: {
      inventory: 'flying ass'
    }
  }, {
    num: 65,
    msg: 'You hunted an ordinary rabbit. It\'s going in your inventory.. Hunt again?',
    props: {
      inventory: 'wabbit'
    }
  }, {
    num: 75,
    msg: 'You hunted a pegavis! It\'s going in your inventory.. Hunt again?',
    props: {
      inventory: 'Pegavis'
    }
  }, {
    num: 76,
    msg: 'You hunted a bug... but it is not a bug, it is feature. Hunt again?',
    props: {
      inventory: 'feature'
    }
  }, {
    num: 100,
    msg: 'You\'ve been raided by imps! -50 money. Try again?',
    props: {
      money: -50
    }
  }
];

huntchoose = function(n) {
  var curr, hunt, i, len, props, random;
  random = Math.random() * hunts.slice(-1)[0].num;
  for (i = 0, len = hunts.length; i < len; i++) {
    hunt = hunts[i];
    if (random <= hunt.num) {
      curr = hunt;
      break;
    }
  }
  game.action(display(curr.msg)).action(cur('hunt'));
  if ('props' in curr) {
    props = curr.props;
    if ('money' in props) {
      user.money += props.money;
    }
    check();
    if ('armor' in props) {
      user.armor += props.armor;
    }
    if ('inventory' in props) {
      user.inventory.push(props.inventory);
    }
  }
  if (n) {
    return n();
  }
};

cavechoose = function(n) {
  if (user.key === 0) {
    if (Math.random() * 100 + 1 <= 20) {
      game.action(display('You are attacked by a spider-skeleton-dungeon-keeper at the entrance!')).action(delay(3000));
      if (user.armor >= 16 && user.weapon >= 12) {
        game.action(display('You kill the spider-skeleton. Let\'s enter.')).action(delay(3000)).action(cavechoose);
      } else {
        game.action(display('You were too weak to fight the spider-skeleton-dungeon-keeper. Get better equipment')).action(delay(3000)).action(townchoose);
      }
    } else {
      game.action(display(['We have entered the cave.', 'It\'s dark, you cant see anything', 'Flames ignite besides you down a long corridor that lead towards two large doors. Enter?'])).action(cur('cave'));
    }
  } else {
    game.action(display('There is nothing here for you')).action(delay(3000)).action(townchoose);
  }
  if (n) {
    return n();
  }
};

beachchoose = function(n) {
  game.action(display('We are at the beach. Fish, swim, or leave?')).action(cur('beach'));
  if (n) {
    return n();
  }
};

fishing = function(n) {
  var random;
  if (user.rod <= 15) {
    random = Math.floor(Math.random() * fishes.length + 1);
    if (random >= fishes.length) {
      user.rod += 3;
      user.money -= 10;
      check();
      game.action(display('You were attacked by a sea glob fish! You lost 10 money and now have +3 rod damage. Try again?')).action(cur('fishing'));
    } else {
      user.inventory.push(fishes[random]);
      game.action(display(user.name + " caught a " + fishes[random] + "! It\'s going in your inventory. Try again?")).action(cur('fishing'));
    }
  } else {
    game.action(display("Your rod has " + user.rod + " damage! Go fix it at the town!")).action(delay(3000)).action(beachchoose);
  }
  if (n) {
    return n();
  }
};

swimming = function(n) {
  var random;
  random = Math.floor(Math.random() * swimmingOutcomes.length + 1);
  if (random >= swimmingOutcomes.length) {
    user.money /= 2;
    return game.action(display(user.name + " was stung by a deadly jelly fish! You lost half of your money at the town hospital")).action(delay(3000)).action(townchoose);
  } else {
    user.money += swimmingOutcomes[random][1];
    check();
    game.action(display(swimmingOutcomes[random][0] + ". Dive in again?"));
    if (swimmingOutcomes[random][2]) {
      user.inventory.push(swimmingOutcomes[random][2]);
      game.action(delay(3000)).action(display("Added " + swimmingOutcomes[random][2] + " to inventory"));
    }
    game.action(cur('swimming'));
    if (n) {
      return n();
    }
  }
};

townchoose = function(n) {
  switch (false) {
    case !(user.lvl >= 3):
      game.action(display('=TOWN= Work, fix, sell, safe, beach, forest, cave =TOWN='));
      break;
    case user.lvl !== 2:
      game.action(display('=TOWN= Work, fix, sell, safe, beach, forest =TOWN='));
      break;
    default:
      game.action(display('=TOWN= Work, fix, sell, safe, beach =TOWN='));
  }
  game.action(cur('town'));
  if (n) {
    return n();
  }
};

choosework = function(n) {
  var random;
  random = Math.random() * 10 + 1;
  switch (false) {
    case !(random <= 2):
      user.money += 25;
      moneygainFX.play();
      user.xp += 1;
      check();
      game.action(display("You go to the library and help out with storing while you've gained experience from reading. Also you get paid")).action(delay(3000)).action(townchoose);
      break;
    case !(random >= 8):
      user.money -= 10;
      check();
      game.action(display('While looking for a job you get robbed. You lose 10 money!')).action(delay(3000)).action(townchoose);
      break;
    case !(random <= 4):
      user.money += 15;
      moneygainFX.play();
      game.action(display('You work at the pub and get paid 15 money!')).action(delay(3000)).action(townchoose);
      break;
    case !(random <= 7):
      user.xp += 1;
      check();
      game.action(display('You go to the local car wash and gain some experience!')).action(delay(3000)).action(townchoose);
      break;
    default:
      game.action(display('No one wants to hire you! Tough luck.')).action(delay(3000)).action(townchoose);
  }
  if (n) {
    return n();
  }
};
