MIN.events = {
  onLoad: function() {
    var predefine = MIN.view.mainDiv().data('predefine');
    // create divs
    if(predefine)
      MIN.core.predefine(predefine);

    MIN.view.createDivs();
  },

  onReset: function() {
    document.location.reload();
//    MIN.core.start(MIN.core.width, MIN.core.height, MIN.core.mineCount);
//    MIN.view.createField();
//    MIN.view.updateStatus();
  },

  onConfig: function() {
    MIN.view.showConfig();
  },

  onMakeTurn: function(point) {
    if(MIN.turn.isEnd()) return;

    MIN.view.updateCell(point, MIN.turn.do(point));
    MIN.view.updateStatus();
  },

  onStartGame: function() {
    var width, height, mineCount;
    width = $('input#' + MIN.view.fieldWidthInputId).val();
    height = $('input#' + MIN.view.fieldHeightInputId).val();
    mineCount = $('input#' + MIN.view.mineCountInputId).val();
    MIN.core.fieldSetup(width, height, mineCount);
    this.onReset();
    MIN.view.hideConfig();
  },

  onCloseConfig: function() {
    MIN.view.hideConfig();
  }
}

$(function() {
  MIN.events.onLoad();

  // Click on "Config"
  $('a.miner_start').on("click", function(e) {
    MIN.events.onConfig();
    e.preventDefault();
  });

  // Click on "Reset"
  $('a.miner_reset').on("click", function(e) {
    MIN.events.onReset();
    e.preventDefault();
  });

  // Click on Cell (player makes his turn)
  $('div#miner').on("click", 'a.' + MIN.view.fieldCellClass, function(e) {
    // parse coordinates
    var coords = $(this).data('coord').split('_'),
      x = parseInt(coords[0]),
      y = parseInt(coords[1]);

    if(e.altKey)
      MIN.view.markCell([x, y]);
    else {
      if(
        $(this).hasClass('m_open') ||
          ($(this).text() === "#")
        ) {}
      else {
        // Click with Alt button
        MIN.events.onMakeTurn([x, y]);
      }
    }
    e.preventDefault();
  });

  // Click on Save on Config panel
  $('a.' + MIN.view.saveConfigLinkClass).on("click", function(e) {
    MIN.events.onStartGame();
    e.preventDefault();
  });

  //Click on Close on Config panel
  $('a.' + MIN.view.cancelConfigLinkClass).on("click", function(e) {
    MIN.events.onCloseConfig();
    e.preventDefault();
  });
});
