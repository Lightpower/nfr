function Player(_type, _basePoint) {
  // Type: { 0: off, 1: AI, 2: HUMAN}
  this.type = _type || 0;
  this.basePoint = _basePoint
  this.points = 0;

  this.color = function() {
    return FIL.core.field[this.basePoint[0]][this.basePoint[1]] [0];
  }
}

FIL.players = {
  list: [
    new Player(2, [0,0]),
    new Player(0, [FIL.core.width-1][FIL.core.height-1]),
    new Player(0, [FIL.core.width-1][0]),
    new Player(0, [0][FIL.core.height-1])
  ],
  currentPlayerId: 0,

  count: function() {
    var count = 0, i;
    for(i=0; i<4; i++ )
      count += this.list[i].type != 0
    return count;
  },

  setup: function(players) {
    var i=0;
    for(; i<4; i++) {
      this.list[i].type = parseInt(players[i]);
      this.list[i].basePoint = this.basePoints(i);
    }
  },

  canColor: function(color) {
    var can = true,
        i;

    if(color < 0) return true; // if color < 0 ignore this validation

    for(i=0; i<4; i++) {
      can = can && ((this.list[i].type == 0) || (this.list[i].color() != color));
      if(!can) break;
    }

    return can;
  },

  basePoints: function(playerNumber) {
    switch(playerNumber) {
      case 0:
        return [0,0];
      case 1:
        return [FIL.core.width-1, FIL.core.height-1];
      case 2:
        return [FIL.core.width-1, 0];
      case 3:
        return [0, FIL.core.height-1];
      default:
        return undefined;
    }
  },

  showTotalPlaces: function() {
    var players = [],
        flag = true,
        i, tmp,
        str = "";
    for(i=0; i<4; i++){
      players[i] = [i, FIL.players.list[i].points];
    }

    while(flag) {
      flag = false;
      for(i=1; i<4; i++) {
        if(players[i-1][1] < players[i][1]) {
          tmp = players[i-1];
          players[i-1] = players[i]
          players[i] = tmp;
          flag = true;
        }
      }
    }
    for(i=0; i<4; i++){
      if(players[i][1] != 0) {
        str += '\nPlayer ' + (players[i][0]+1) + ' - ' + players[i][1] + ' point(s)';
      }
    }

    alert('Player ' + (players[0][0] + 1) + ' wins!\n\n' + str);
  }
}