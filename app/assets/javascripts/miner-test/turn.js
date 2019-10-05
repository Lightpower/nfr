MINT.turn = {
  do: function(point) {
    if(this.isEnd()) return;

    var result = MINT.core.move(point);
    MINT.view.updateCell(point, result);

  },

  isEnd: function() {
    return MINT.core.dead || (MINT.core.openCellLeft == 0);
  }

  ////////////////
  // PRIVATE
  ///////////////
}