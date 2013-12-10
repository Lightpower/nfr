// Show status panel and game field
FIL.view = {
  fillerDivId:           'filler',
  // Field
  fieldDivId:            'filler_field',
  fieldCellClass:        'fcell',
  fieldRowClass:         'field_row',
  // Control panel
  statusDivId:           'filler_status',
  controlDivId:          'filler_control',
  colorDivId:            'filler_colors',
  startLinkClass:        'filler_start',
  resetLinkClass:        'filler_reset',
  headDivId:           'filler_players',
  playerTunDivId:        'player_turn',
  playerTurnSpanId:      'filler_player_turn',
  // Config panel
  saveConfigLinkClass:   'filler_save_config',
  cancelConfigLinkClass: 'filler_cancel_config',
  configDivId:           'filler_config',
  configBlockDivId:      'filler_config_block',
  playerConfigClass:     'player_config',
  playerRadioItemPrefix: 'radio_player_',
  fieldWidthInputId:     'field_width',
  fieldHeightInputId:    'field_height',
  colorCountInputId:     'color_count',
  unityLevelInputId:     'unity_level',

  mainDiv: function() { return $('div#' + this.fillerDivId) },

  isFieldBuilt: function() {
    return this.mainDiv().children('div.' + this.fieldCellClass).length > 0
  },

  createDivs: function() {
    this.createControl();
    if(FIL.core.field) this.createField();
    this.createConfig();
  },

  //################
  // Control panel
  //################

  updateControl: function() {
    var i = 0,
      div = this.mainDiv(),
      row, subDiv;
    
    if(FIL.players.count() == 0) return false;

    // Get status panel
    div = div.children("div#" + this.statusDivId);

    subDiv = div.children("div#" + this.headDivId);
    subDiv.html('');
    // Info about each player
    for(; i<4; i++) {
      if(FIL.players.list[i].type > 0) {
        row  = '<div style="display: inline-block; margin-right: 10px;">';
        row += '<b>Player ' + (i+1) + '</b><br>';
        switch(FIL.players.list[i].type) {
          case 1: // AI
            row += 'AI';
            break;
          case 2:
            row += 'HUMAN';
            break;
        }
        row += '<br>';
        row += '<b>Points:</b> ' + FIL.players.list[i].points;
        row += '</div>';
        subDiv.append(row);
      }
    }

    // Info about player's turn
    subDiv = div.children('div#' + this.headDivId);
    subDiv.fadeIn();
    subDiv.children('span#' + this.playerTurnSpanId).text = FIL.players.currentPlayerId;

    this.createColorPanel();
  },

  //#########
  // Field
  //#########

  createField: function() {
    // show FIL.core.field on <div id="field">
    var i, j,
      div = this.mainDiv(),
      cellWidth, cellHeight,
      newCell,
      cellColor,
      rowDiv;
    // Delete field
    div.children('div#' + this.fieldDivId).remove();
    // Create field
    div.append('<div id="' + this.fieldDivId + '" name="' + this.fieldDivId + '"></div>');
    div = div.children("div#" + this.fieldDivId);

    cellWidth = Math.floor(div.width() / FIL.core.width) - 2;
    cellHeight = Math.floor(div.height() / FIL.core.height) - 2;

    // Place cells on the field
    for(j=0; j<FIL.core.height; j++) {
      div.append('<div class="' + this.fieldRowClass + '" style="height: ' + (cellHeight+2) + 'px;"></div>');
      rowDiv = div.children().last();
      for(i=0; i<FIL.core.width; i++) {
        cellColor = this.getColor(i, j);
        newCell = '<a href="#" class="' + this.fieldCellClass
          + '" style="width: ' + cellWidth + 'px; height: ' + cellHeight + 'px;"'
          + ' data-color="' + FIL.core.field[i][j][0] +'"'
          + ' data-coord="' + i + '_' + j + '">';
        rowDiv.append(newCell);
      }
    }
  },

  updateField: function() {
    // show FIL.core.field on <div id="field">
    var i=0,
        j= 0,
        div = this.mainDiv().children("div#" + this.fieldDivId),
        cell,
        cellColor;

    if(FIL.core.field) {
      if(this.isFieldBuilt()) {
        // Place cells on the field
        for(j=0; j<FIL.core.height; j++) {
          for(i=0; i<FIL.core.width; i++) {
            cellColor = this.getColor(i, j);
            cell = div.children('div[data-coord='+ i + '_' + j +']');
            cell.data('color', cellColor);
          }
        }
      }else {
        this.createField();
      }
    }
  },

  //##########
  // Config
  //##########
  showConfig: function() {
    $('div#' + FIL.view.configDivId).fadeIn();
    $('div#' + FIL.view.configBlockDivId).fadeIn();
  },

  hideConfig: function() {
    $('div#' + FIL.view.configDivId).fadeOut();
    $('div#' + FIL.view.configBlockDivId).fadeOut();
  },



  ///////////
  // PRIVATE
  ///////////

  createControl: function() {
    var div = this.mainDiv(),
        tmpDiv, newCell, i;
    // Remove status panel
    div.children("div#" + this.statusDivId).remove();
    // Create status panel
    div.prepend('<div id="' + this.statusDivId + '" name="' + this.statusDivId + '"></div>');
    div = div.children("div#" + this.statusDivId);

    // Info about each player
    div.append('<div id="' + this.headDivId + '" name="' + this.headDivId + '"></table>');

    div.append('<div id="'+this.playerTunDivId+'" name="'+this.playerTunDivId+'" style="display: none;">PLAYER <span id="'+this.playerTurnSpanId+'" name="'+this.playerTurnSpanId+'">' + 0 + '</span> TURNS</div>');

    // Control panel
    div.append('<div id="' + this.controlDivId + '" name="' + this.controlDivId + '"><a href="#" class="' + this.startLinkClass + ' button">Start new game</a> <a href="#" class="' + this.resetLinkClass + ' button">Reset</a></div>');

    this.createColorPanel();
  },

  createColorPanel: function() {
    var div = $('div#' + this.statusDivId),
        tmpDiv, newCell, i;
    // Delete color panel
    $('div#' + this.colorDivId).remove();

    // Color panel
    div.append('<div id="' + this.colorDivId + '" name="' + this.colorDivId + '"></div>');
    tmpDiv = div.children('div#' + this.colorDivId);
    for(i=0; i<FIL.core.colorCount; i++) {
      newCell = '<a href="#" class="' + this.fieldCellClass
        + '" style="width: 20px; height: 20px;" data-color="' + i +'"></a> &nbsp; ';
      tmpDiv.append(newCell);
    }
  },

  createConfig: function() {
    var div = this.mainDiv(),
        headDiv, subDiv,
        i,
        radio,
        row;

    // Delete config panel
    div.children('div#' + this.configDivId).remove();
    // Create background div
    div.append('<div id="' + this.configBlockDivId + '" name="' + this.configBlockDivId + '"></div>');
    // Create config panel
    div.append('<div id="' + this.configDivId + '" name="' + this.configDivId + '" style="display: inline;"></div>');
    div = div.children("div#" + this.configDivId);

    // Place players config
    div.append("<div></div>");
    headDiv = div.children('div').first();

    for(i=0; i<4; i++) {
      headDiv.append('<div class="' + this.playerConfigClass + '"></div>')
      subDiv = headDiv.children("div." + this.playerConfigClass).last();
      subDiv.append('Player ' + (i+1) + '<br><br>');
      subDiv.append('<input type="radio" name="' + this.playerRadioItemPrefix + i + '" value="0" checked>OFF<br>');
      subDiv.append('<input type="radio" name="' + this.playerRadioItemPrefix + i + '" value="1"'    + (FIL.players.list[i].type==1 ? " checked":"" ) + '>AI<br>');
      subDiv.append('<input type="radio" name="' + this.playerRadioItemPrefix + i + '" value="2"' + (FIL.players.list[i].type==2 ? " checked":"" ) + '>Human');
    }

    // Place field config
    div.append('<table style="margin: 5px 15px;">');
    headDiv = div.children('table').first();
    // Width and color number
    headDiv.append('<tr>');
    subDiv = headDiv.find('tr').last();
    subDiv.append('<td>Field width:</td>');
    subDiv.append('<td><input id="' + this.fieldWidthInputId + '" name="' + this.fieldWidthInputId + '" value="20"></td>');
    subDiv.append('<td>Colors number: </td>');
    subDiv.append('<td><input id="' + this.colorCountInputId + '" name="' + this.colorCountInputId + '" value="7"></td>');
    // Height and unity level
    headDiv.append('<tr>');
    subDiv = headDiv.find('tr').last();
    subDiv.append('<td>Field height:</td>');
    subDiv.append('<td><input id="' + this.fieldHeightInputId + '" name="' + this.fieldHeightInputId + '" value="20"></td>');
    subDiv.append('<td>Unity level: </td>');
    subDiv.append('<td><input id="' + this.unityLevelInputId + '" name="' + this.unityLevelInputId + '" value="2"></td>');

    div.append('<div><a href="#" class="' + this.saveConfigLinkClass + ' button">Save and Start</a>' +
      ' <a href="#" class="' + this.cancelConfigLinkClass + ' button">Cancel</a></div>');

  },

  getColor: function(x, y) {
    return ['white', 'black', 'red', 'orange', 'yellow', 'green', 'cyan', 'blue', 'magenta'][ FIL.core.field[x][y][0] ];
  }
}