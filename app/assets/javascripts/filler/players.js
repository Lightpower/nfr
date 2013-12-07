function Player(_type, _points) {
  // Type: { 0: off, 1: AI, 2: HUMAN}
  this.type = _type || 0;
  this.points = _points;
}

FIL.players = {
  list: [new Player(1, 0), new Player(), new Player(), new Player()],
  currentPlayerTurn: 0,

  count: function() {
    var count = 0, i;
    for(i=0; i<4; i++ )
      count += this.list[i].type != 0
  }
}