FIL.turn = {
  do: function(newColor) {
    if(this.isEnd()) return;

    FIL.core.moveArea = undefined;
    if(!FIL.players.canColor(newColor))
      return -1;

    var points;
    switch(FIL.players.list[FIL.players.currentPlayerId].type) {
      case 1:
        points = this.byAi();
        break;
      case 2:
        points = this.byHuman(newColor);
        break;
    }
    FIL.players.list[FIL.players.currentPlayerId].points = points;
    FIL.view.updateField();
    this.switchToNextTurn();
    if(this.isEnd())
      FIL.players.showTotalPlaces();
    return points;
  },

  isEnd: function() {
    var s = FIL.core.width * FIL.core.height,
      sPlayer = 0,
      i;
    for(i=0; i<4; i++) {
      sPlayer += FIL.players.list[i].points;
    }
    return s <= sPlayer;
  },

  ////////////////
  // PRIVATE
  ///////////////

  byHuman: function(newColor) {
    // move: function(playerNumber, point, oldColor, newColor, doPaint)
    var playerNumber = FIL.players.currentPlayerId,
        point = FIL.players.list[playerNumber].basePoint,
        oldColor = FIL.core.field[point[0]][point[1]][0];

    return FIL.core.move(playerNumber, point, oldColor, newColor, true);
  },

  byAi: function() {
    var playerNumber = FIL.players.currentPlayerId,
        point = FIL.players.list[playerNumber].basePoint,
        oldColor = FIL.core.field[point[0]][point[1]][0],
        i, colorPoints,
        maxPoints = 0, maxColor;

    for(i=0; i<FIL.core.colorCount; i++) {
      if(!FIL.players.canColor(i)) continue;
      FIL.core.moveArea = undefined;
      colorPoints = FIL.core.move(playerNumber, point, oldColor, i, false);
      if(maxPoints < colorPoints) {
        maxPoints = colorPoints;
        maxColor = i;
      }
    }

    FIL.core.moveArea = undefined;
    return FIL.core.move(playerNumber, point, oldColor, maxColor, true);
  },

  switchToNextTurn: function() {
    FIL.players.currentPlayerId++;
    if(FIL.players.currentPlayerId > 3) {
      FIL.players.currentPlayerId = 0;
      FIL.core.turns++;
    }

    while(FIL.players.list[FIL.players.currentPlayerId].type == 0) {
      FIL.players.currentPlayerId++;
      if(FIL.players.currentPlayerId > 3) {
        FIL.players.currentPlayerId = 0;
        FIL.core.turns++;
      }
    }
  }
}