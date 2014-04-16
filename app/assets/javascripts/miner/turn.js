MIN.turn = {
  do: function(point) {
    if(this.isEnd()) return;
    if(MIN.view.isCellOpen(point)) return;

    var result = MIN.core.move(point);
    MIN.view.updateCell(point, result);

    if (result === 0) {
      for(var i=point[0]-1; i<=point[0]+1; i++) {
        for(var j=point[1]-1; j<=point[1]+1; j++) {
          if(  (i != point[0] || j != point[1])
            && i >= 0 && i < MIN.core.width
            && j >= 0 && j < MIN.core.height)
            this.do([i, j]);
        }

      }
    }

  },

  isEnd: function() {
    return MIN.core.dead || (MIN.core.openCellLeft == 0);
  }

  ////////////////
  // PRIVATE
  ///////////////
}