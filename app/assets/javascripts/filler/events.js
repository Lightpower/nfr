FIL.events = {
  onLoad: function() {
    // create divs
    FIL.view.createDivs();
  },

  onReset: function() {

  },

  onConfig: function() {
    $('div#' + FIL.view.configDivId).fadeIn();
  },

  onMakeTurn: function(color) {

  },

  onStartGame: function() {

    this.onReset();
    $('div#' + FIL.view.configDivId).fadeOut();
  },

  onCloseConfig: function() {
    $('div#' + FIL.view.configDivId).fadeOut();
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
  $('div.' + FIL.view.fieldCellClass).on("click", function(e) {
    FIL.events.onMakeTurn( $(this).data('color') );
    e.preventDefault();
  });

  // Click on Save on Config panel
  $('a.' + FIL.view.saveConfigLinkClass).on("click", function(e) {
    FIL.events.onStartGame();
    e.preventDefault();
  });

//  $(document).on("click", "a." + FIL.view.cancelConfigLinkClass, function(e) {
//    FIL.events.onCloseConfig();
//    e.preventDefault();
//  });

  //Click on Close on Config panel
  $('a.' + FIL.view.cancelConfigLinkClass).on("click", function(e) {
    FIL.events.onCloseConfig();
    e.preventDefault();
  });

});
