function Player(_on, _human, _points) {
  this.on = _on;
  this.human = _human;
  this.points = _points;
}

FIL.players = {
  list: [new Player(), new Player(), new Player(), new Player()],
  count: 0,
  currentPlayerTurn: 0
}