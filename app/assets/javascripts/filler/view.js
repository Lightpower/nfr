// Show status panel and game field
FIL.view = {
  fillerDivId:           'filler',
  fieldDivId:            'filler_field',
  fieldCellClass:        'fcell',
  statusDivId:           'filler_status',
  controlDivId:          'filler_control',
  startLinkClass:        'filler_start',
  resetLinkClass:        'filler_reset',
  saveConfigLinkClass:   'filler_save_config',
  cancelConfigLinkClass: 'filler_cancel_config',
  configDivId:           'filler_config',
  playerDivId:           'filler_players',
  playerTunDivId:        'player_turn',
  playerTurnSpanId:      'filler_player_turn',

  mainDiv: function() { return $('div#' + this.fillerDivId) },

  createDivs: function() {
    this.createControl();
    if(FIL.core.field) this.createField();
    this.createConfig();
  },

  updateControl: function() {
    var i = 0,
      div = this.mainDiv(),
      row, subDiv;
    
    if(FIL.players.count() == 0) return false;
    
    // Create status panel
    div = div.children("div#" + this.statusDivId);

    subDiv = div.children("div#" + this.playerDivId);
    subDiv.html('');
    // Info about each player
    for(; i<FIL.players.count(); i++) {
      if(FIL.players.list[i].on) {
        row  = '<div style="position: inline-block; margin-right: 10px;">';
        row += '<b>Player ' + i+1 + '</b><br>';
        row += (FIL.players.list[i].human ? 'HUMAN' : 'AI') + '<br>';
        row += '<b>Points:</b> ' + FIL.players.list[i].points;
        row += '</div>';
        subDiv.append(row);
      }
    }

    // Info about player's turn
    subDiv = div.children('div#' + this.playerDivId);
    subDiv.fadeIn();
    subDiv.children('span#' + this.playerTurnSpanId).text = FIL.players.currentPlayerTurn;
    
    // Control panel
    div.append('<div id="filler_control" name="filler_control"><a href="#" class="' + this.startLinkClass + '">Start new game</a> <a href="#" class="' + this.resetLinkClass + '">Reset</a></div>');
  },

  showField: function() {
    // show FIL.core.field on <div id="field">
    var i=0,
        j= 0,
        div = this.mainDiv(),
        cellWidth = Math.floor(div.clientWidth / FIL.core.width),
        cellHeight = Math.floor(div.clientHeight / FIL.core.height),
        newCell,
        cellColor;
    // Delete field
    div.children("div#" + this.fieldDivId).remove();
    // Create field
    div.append('<div id="' + this.fieldDivId + '" name="' + this.fieldDivId + '" style="width: ' + (cellWidth+2) * FIL.core.width + '"></div>');
    div = div.children("div#" + this.fieldDivId);

    if(FIL.core.field) {
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
    }
  },

  showConfig: function() {
    var div = this.mainDiv();

    // Create status panel
    if(div.children("div#" + this.configDivId).length > 0)
      div.children("div#" + this.configDivId).html('');
    else
      div.append('<div id="' + this.configDivId + '" name="' + this.configDivId + '"></div>');
    div = div.children("div#" + this.configDivId);


  },





  getColor: function(x, y) {
    return ['white', 'black', 'red', 'orange', 'yellow', 'green', 'cyan', 'blue', 'magenta'][ FIL.core.field[x][y][0] ];
  },

  createControl: function() {
    var div = this.mainDiv();
    // Remove status panel
    div.children("div#" + this.statusDivId).remove();
    // Create status panel
    div.prepend('<div id="' + this.statusDivId + '" name="' + this.statusDivId + '"></div>');
    div = div.children("div#" + this.statusDivId);

    // Info about each player
    div.append('<div id="' + this.playerDivId + '" name="' + this.playerDivId + '"></table>');

    div.append('<div id="'+this.playerTunDivId+'" name="'+this.playerTunDivId+'" style="display: none;">PLAYER <span id="'+this.playerTurnSpanId+'" name="'+this.playerTurnSpanId+'">' + 0 + '</span> TURNS</div>');

    // Control panel
    div.append('<div id="' + this.controlDivId + '" name="' + this.controlDivId + '"><a href="#" class="' + this.startLinkClass + '">Start new game</a> <a href="#" class="' + this.resetLinkClass + '">Reset</a></div>');
  },

  createField: function() {
    // show FIL.core.field on <div id="field">
    var i=0,
      j= 0,
      div = this.mainDiv(),
      cellWidth = Math.floor(div.clientWidth / FIL.core.width),
      cellHeight = Math.floor(div.clientHeight / FIL.core.height),
      newCell,
      cellColor,
      rowDiv;
    // Delete field
    div.children('div#' + this.fieldDivId).remove();
    // Create field
    div.append('<div id="' + this.fieldDivId + '" name="' + this.fieldDivId + '" style="width: ' + (cellWidth+2) * FIL.core.width + '"></div>');
    div = div.children("div#" + this.fieldDivId);

    // Place cells on the field
    for(; j<FIL.core.height; j++) {
      div.append('<div></div>');
      rowDiv = div.children().last();
      for(; i<FIL.core.width; j++) {
        cellColor = this.getColor(i, j);
        newCell = '<div class="' + this.fieldCellClass
          + '" style="display: inline-block; width: ' + cellWidth + 'px; height: ' + cellHeight + 'px;'
          + ' background-color: ' + cellColor + '"'
          + ' data-color="' + FIL.core.field[i][j][0] + '"'
          + ' data-coord="' + i + '_' + j + '">';
        rowDiv.append(newCell);
      }
    }
  },

  createConfig: function() {
    var div = this.mainDiv(),
        playerDiv, subDiv,
        i, row,
        radio,
        selectedIndex;

    // Delete config panel
    div.children('div#' + this.configDivId).remove();
    // Create config panel
    div.append('<div id="' + this.configDivId + '" name="' + this.configDivId + '" style="display: inline;"></div>');
    div = div.children("div#" + this.configDivId);

    // Place
    div.append("<div></div>");
    playerDiv = div.children('div').first();

    for(i=0; i<4; i++) {
      playerDiv.append('<div class="config_player" style="display: inline-block;"></div>')
      subDiv = playerDiv.children('div.config_player').last();
      subDiv.append('Player ' + (i+1) + '<br><br>');
      subDiv.append('<input type="radio" name="radio_player_' + i + '" value="off" checked>OFF<br>');
      subDiv.append('<input type="radio" name="radio_player_' + i + '" value="AI"'    + (FIL.players.list[i].type==1 ? "checked":"" ) + '>AI<br>');
      subDiv.append('<input type="radio" name="radio_player_' + i + '" value="Human"' + (FIL.players.list[i].type==2 ? "checked":"" ) + '>Human');
    }

    div.append('<div><a href="#" class="' + this.saveConfigLinkClass + '">Save and Start</a>' +
      ' <a href="#" class="' + this.cancelConfigLinkClass + '">Cancel</a></div>');

  },

  styleForConfig: function() {
    return 'left:  '
  }
}