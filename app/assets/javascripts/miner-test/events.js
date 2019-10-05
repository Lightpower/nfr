MINT.events = {
  onLoad: function() {
    var predefine = MINT.view.mainDiv().data('predefine');
    // create divs
    if(predefine)
      MINT.core.predefine(predefine);

    MINT.view.createDivs();
  },

  onReset: function() {
    if(MINT.core.predefined)
      document.location.reload();
    else {
      MINT.core.start(MINT.core.width, MINT.core.height, MINT.core.mineCount);
      MINT.view.createField();
      MINT.view.updateStatus();
    }
  },

  onConfig: function() {
    MINT.view.showConfig();
  },

  onMakeTurn: function(point) {
    if(MINT.turn.isEnd()) return;

    MINT.view.updateCell(point, MINT.turn.do(point));
    MINT.view.updateStatus();
  },

  onStartGame: function() {
    var width, height, mineCount;
    width = $('input#' + MINT.view.fieldWidthInputId).val();
    height = $('input#' + MINT.view.fieldHeightInputId).val();
    mineCount = $('input#' + MINT.view.mineCountInputId).val();
    MINT.core.fieldSetup(width, height, mineCount);
    this.onReset();
    MINT.view.hideConfig();
  },

  onCloseConfig: function() {
    MINT.view.hideConfig();
  }
}

$(function() {
  MINT.events.onLoad();

  // Click on "Config"
  $('a.miner_start').on("click", function(e) {
    MINT.events.onConfig();
    e.preventDefault();
  });

  // Click on "Reset"
  $('a.miner_reset').on("click", function(e) {
    MINT.events.onReset();
    e.preventDefault();
  });

  // Click on Cell (player makes his turn)
  $('div#miner').on("click", 'a.' + MINT.view.fieldCellClass, function(e) {
    // parse coordinates
    var coords = $(this).data('coord').split('_'),
      x = parseInt(coords[0]),
      y = parseInt(coords[1]);

    if(e.altKey || MINT.view.markerMode) {
      MINT.view.markCell([x, y]);
      MINT.view.markerMode = false;
    } else {
      // Click with Alt button
      MINT.events.onMakeTurn([x, y]);
    }
    e.preventDefault();
  });

  // Click on Save on Config panel
  $('a.' + MINT.view.saveConfigLinkClass).on("click", function(e) {
    MINT.events.onStartGame();
    e.preventDefault();
  });

  //Click on Close on Config panel
  $('a.' + MINT.view.cancelConfigLinkClass).on("click", function(e) {
    MINT.events.onCloseConfig();
    e.preventDefault();
  });

  // Click on "Set mine marker"
  $('a.' + MINT.view.markerModeClass).on("click", function(e) {
    MINT.view.markerMode = !MINT.view.markerMode;
    e.preventDefault();
  });
});
