// Show status panel and game field
FIL.view = {
  fillerDivId:        'filler',
  fieldDivId:         'filler_field',
  fieldCellClass:     'fcell',
  statusDivId:        'filler_status',

  showStatus: function() {
    var i = 0,
      div = $('div#' + this.fillerDivId),
      table;
    // Create status panel
    if(div.children("div#" + this.statusDivId).length == 0)
      div.append('<div id="' + this.statusDivId + '" name="' + this.statusDivId + '"></div>');
    div = div.children("div#" + this.statusDivId);

    // Info about each player
    table = div.html('<table></table>');
    for(; i<FIL.players.count; i++) {
      if(FIL.players.list[i].on) {
        div.append('<tr>');
        div.append('<td><b>Player ' + i+1 + ':</b> ' + (FIL.players.list[i].human ? 'HUMAN' : 'AI') + ' </td>');
        div.append('<td><b> &nbsp; Points:</b> ' + FIL.players.list[i].points + '</td>');
        div.append('</tr>');
      }
    }

    // Info about player's turn
    if(FIL.players.count > 0)
      div.append('<div id="player_turn" name="player_turn">PLAYER ' + (FIL.players.currentPlayerTurn + 1) + ' TURNS</div>');

    // Control panel
    div.append('<div id="filler_control" name="filler_control"><a href="#" class="filler_start">Start new game</a> <a href="#" class="filler_reset">Reset</a></div>');
  },

  showField: function() {
    // show FIL.core.field on <div id="field">
    var i=0,
        j= 0,
        div = $('div#' + this.fillerDivId),
        cellWidth = Math.floor(div.clientWidth / FIL.core.width),
        cellHeight = Math.floor(div.clientHeight / FIL.core.height),
        newCell,
        cellColor;
    // Create field
    if(div.children("div#" + this.fieldDivId).length == 0)
      div.append('<div id="' + this.fieldDivId + '" name="' + this.fieldDivId + '" style="width: ' + (cellWidth+2) * FIL.core.width + '"></div>');
    div = div.children("div#" + this.fieldDivId);

    // Place cells on the field
    for(; j<FIL.core.height; j++) {
      div.append('<div></div>');
      for(; i<FIL.core.width; j++) {
        cellColor = this.getColor(i, j);
        newCell = '<div class="' + this.fieldCellClass
          + '" style="display: inline-block; width: ' + cellWidth + 'px; height: ' + cellHeight + 'px; background-color: ' + cellColor + '" '
          + 'data-color="' + FIL.core.field[i][j][0] + '">';
        div.children().last().append(newCell);
      }
    }
  },







  getColor: function(x, y) {
    return ['white', 'black', 'red', 'orange', 'yellow', 'green', 'cyan', 'blue', 'magenta'][ FIL.core.field[x][y][0] ];
  }
}