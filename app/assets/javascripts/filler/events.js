FIL.events = {
  onLoad: function() {
    // create divs
    FIL.view.createDivs();
  },

  onReset: function() {
    FIL.core.start(FIL.core.width, FIL.core.height, FIL.core.colorCount, FIL.core.unityLevel);
    FIL.view.updateField();
    FIL.view.updateControl();
  },

  onConfig: function() {
    FIL.view.showConfig();
  },

  onMakeTurn: function(color) {
    if(FIL.turn.isEnd()) return;

    if(!FIL.players.canColor(color)) {
      FIL.view.showWarning();
      return;
    }
    FIL.view.hideWarning();

    FIL.turn.do(color);
    FIL.view.updateControl();

    while(!FIL.turn.isEnd() && FIL.players.list[FIL.players.currentPlayerId].type == 1) { // make turn for all AI
      FIL.turn.do(-1);
      FIL.view.updateControl();
    }
  },

  onStartGame: function() {
    var players = [0,0,0,0],
        div = $('div#' + FIL.view.playerConfigClass),
        width, height, colorCount, unityLevel,
        i=0;

    for(; i<4; i++) {
      players[i] = $('input[name=' + FIL.view.playerRadioItemPrefix + i + ']:checked').val();
    }
    width = $('input#' + FIL.view.fieldWidthInputId).val();
    height = $('input#' + FIL.view.fieldHeightInputId).val();
    colorCount = $('input#' + FIL.view.colorCountInputId).val();
    unityLevel = $('input#' + FIL.view.unityLevelInputId).val();
    FIL.players.setup(players);
    FIL.core.fieldSetup(width, height, colorCount, unityLevel);
    this.onReset();
    FIL.view.hideConfig();
  },

  onCloseConfig: function() {
    FIL.view.hideConfig();
  }
}

$(function() {
  FIL.events.onLoad();

  // Click on "Start new game"
  $('a.filler_start').on("click", function(e) {
    FIL.events.onConfig();
    e.preventDefault();
  });

  // Click on "Reset"
  $('a.filler_reset').on("click", function(e) {
    FIL.events.onReset();
    e.preventDefault();
  });

  // Click on Cell (player makes his turn)
  $('div#filler').on("click", 'a.' + FIL.view.fieldCellClass, function(e) {
    FIL.events.onMakeTurn( $(this).data('color') );
    e.preventDefault();
  });

  // Click on Save on Config panel
  $('a.' + FIL.view.saveConfigLinkClass).on("click", function(e) {
    FIL.events.onStartGame();
    e.preventDefault();
  });

  //Click on Close on Config panel
  $('a.' + FIL.view.cancelConfigLinkClass).on("click", function(e) {
    FIL.events.onCloseConfig();
    e.preventDefault();
  });
});
