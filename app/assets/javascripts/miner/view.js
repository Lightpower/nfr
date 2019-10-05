// Show status panel and game field
MIN.view = {
  minerDivId:           'miner',
  // Field
  fieldDivId:            'miner_field',
  fieldCellClass:        'mc',
  fieldRowClass:         'fld_row',
  // Control panel
  statusDivId:           'miner_status',
  controlDivId:          'miner_control',
  configLinkClass:       'miner_start',
  resetLinkClass:        'miner_reset',
  stateLabelId:          'miner_state_label',
  stateTextId:           'miner_state_text',
  // Config panel
  saveConfigLinkClass:   'miner_save_config',
  cancelConfigLinkClass: 'miner_cancel_config',
  configDivId:           'miner_config',
  configBlockDivId:      'miner_config_block',
  fieldWidthInputId:     'field_width',
  fieldHeightInputId:    'field_height',
  mineCountInputId:      'mine_count',
  // Cell classes
  cellExplode:           'm_boom',
  cellOpen:              'm_open',
  // Numbers classes
  opened_classes: ['m0', 'm1', 'm2', 'm3', 'm4', 'm5', 'm6', 'm7', 'm8'],

  markerModeClass:       'set_marker',
  // If true then next click will set cell's caption to # (mine marker)
  markerMode: false,

  mainDiv: function() { return $('div#' + this.minerDivId) },

  isFieldBuilt: function() {
    return this.mainDiv().children('div.' + this.fieldCellClass).length > 0
  },

  createDivs: function() {
    this.createControl();
    if(MIN.core.field) this.createField();
    if(!MIN.core.predefined) this.createConfig();
  },

  //################
  // Control panel
  //################

  updateControl: function() {
    this.updateStatus();
  },

  //#########
  // Field
  //#########

  createField: function() {
    // show MIN.core.field on <div id="field">
    var i, j,
      div = this.mainDiv(),
      divSize = this.computeDivWidth(),
      cellWidth, cellHeight,
      newCell,
      rowDiv;
    // Delete field
    div.children('div#' + this.fieldDivId).remove();
    // Create field
    div.append('<div id="' + this.fieldDivId + '" name="' + this.fieldDivId +
      '" style="width: ' + divSize[0] + 'px; height: '+ divSize[1] +'px"></div>');
    div = div.children("div#" + this.fieldDivId);

    cellWidth = Math.floor(div.width() / MIN.core.width) - 2;
    cellHeight = Math.floor(div.height() / MIN.core.height) - 2;

    // Place cells on the field
    for(j=0; j<MIN.core.height; j++) {
      div.append('<div class="' + this.fieldRowClass + '" style="height: ' + (cellHeight+2) + 'px;"></div>');
      rowDiv = div.children().last();
      for(i=0; i<MIN.core.width; i++) {
        newCell = '<a href="#" class="' + this.fieldCellClass
          + '" style="width: ' + cellWidth + 'px; height: ' + cellHeight + 'px;"'
          + ' data-coord="' + i + '_' + j + '">&nbsp;';
        rowDiv.append(newCell);
      }
    }
  },

  computeDivWidth: function() {
    var divWidth = MIN.core.width * 20,
        divHeight,
        maxWidth = $('div#' + this.minerDivId).width() - 10;
    if(divWidth < 400) divWidth = 400;
    if(divWidth > maxWidth) divWidth = maxWidth;
    divWidth = ~~(divWidth / MIN.core.width) * MIN.core.width;
    divHeight = divWidth / MIN.core.width * MIN.core.height;

    return [divWidth, divHeight];
  },

  updateCell: function(point, result) {
    // show MIN.core.field on <div id="field">
    var i=point[0],
        j= point[1],
        cell = this.mainDiv().find('a[data-coord='+ i + '_' + j +']');

    switch(result) {
      case undefined:
      case -1:
        return;
      case 9:
        cell.addClass(this.cellExplode);
        cell.text('@');
        break;
      default:
        cell.addClass(this.cellOpen);
        if(result >= 0 && result <= 8)
          cell.addClass(this.opened_classes[result]);
        cell.text(result);
        break;
    }
  },

  markCell: function(point) {
    var cell = this.mainDiv().find('a[data-coord='+ point[0] + '_' + point[1] +']'),
        mark = cell.text() === "#" ? "&nbsp;" : "#";
    cell.html(mark);
  },

  isCellOpen: function(point) {
    return this.mainDiv().find('a[data-coord='+ point[0] + '_' + point[1] +']').hasClass(this.cellOpen)
  },

  //##########
  // Config
  //##########
  showConfig: function() {
    $('div#' + this.configDivId).fadeIn();
    $('div#' + this.configBlockDivId).fadeIn();
  },

  hideConfig: function() {
    $('div#' + this.configDivId).fadeOut();
    $('div#' + this.configBlockDivId).fadeOut();
  },

  ///////////
  // PRIVATE
  ///////////

  createControl: function() {
    var div = this.mainDiv();
    // Remove status panel
    div.children("div#" + this.statusDivId).remove();
    // Create status panel
    div.prepend('<div id="' + this.statusDivId + '" name="' + this.statusDivId + '"></div>');
    div = div.children("div#" + this.statusDivId);

    // Control panel
    div.append('<div id="' + this.controlDivId + '" name="' + this.controlDivId + '">'
      + (MIN.core.predefined ? '' : '<a href="#" class="' + this.configLinkClass + ' button">Config</a> ')
      + '<a href="#" class="' + this.resetLinkClass + ' button">Reset</a>'
      + '<span id="' + this.stateLabelId + '" name="' + this.stateLabelId + '"></span>'
      + '<span id="' + this.stateTextId + '" name="' + this.stateTextId + '"></span><br>'
      + '<a href="#" class="' + this.markerModeClass + ' button">Set marker</a> <span>(or press and hold ALT button)</span>'
      + '</div>');
  },

  createConfig: function() {
    var div = this.mainDiv(),
        headDiv, subDiv;

    // Delete config panel
    div.children('div#' + this.configDivId).remove();
    // Create background div
    div.append('<div id="' + this.configBlockDivId + '" name="' + this.configBlockDivId + '"'
      + (MIN.core.predefined ? ' style="display: none;"' : '')
      + '></div>');
    // Create config panel
    div.append('<div id="' + this.configDivId + '" name="' + this.configDivId + '" style="display: ' + (MIN.core.predefined ? 'none' : 'inline') + ';"></div>');
    div = div.children("div#" + this.configDivId);

    // Place field config
    div.append('<table style="margin: 5px 15px;">');
    headDiv = div.children('table').first();
    // Width
    headDiv.append('<tr>');
    subDiv = headDiv.find('tr').last();
    subDiv.append('<td>Field width!!!:</td>');
    subDiv.append('<td><input id="' + this.fieldWidthInputId + '" name="' + this.fieldWidthInputId + '" value="20"></td>');
    // Height
    headDiv.append('<tr>');
    subDiv = headDiv.find('tr').last();
    subDiv.append('<td>Field height:</td>');
    subDiv.append('<td><input id="' + this.fieldHeightInputId + '" name="' + this.fieldHeightInputId + '" value="20"></td>');
    // Mine number
    headDiv.append('<tr>');
    subDiv = headDiv.find('tr').last();
    subDiv.append('<td>Mine number: </td>');
    subDiv.append('<td><input id="' + this.mineCountInputId + '" name="' + this.mineCountInputId + '" value="50"></td>');

    div.append('<div><a href="#" class="' + this.saveConfigLinkClass + ' button">Save and Start</a>' +
      ' <a href="#" class="' + this.cancelConfigLinkClass + ' button">Cancel</a></div>');

  },

  updateStatus: function() {
    var label = $('span#' + this.stateLabelId + ''),
        text  = $('span#' + this.stateTextId + '');
    if(MIN.core.dead) {
      label.html('&nbsp;');
      text.html(':(');
    }else if(MIN.core.openCellLeft === 0) {
      label.html('&nbsp;');
      text.html('Victory!');
    }else{
      label.html('Closed cells left: ');
      text.html(MIN.core.openCellLeft);
    }
  }
}