FIL.events = {
  onLoad: function() {
    // create divs
    FIL.view.showStatus();
    if(FIL.core.field) FIL.view.showField();
  },

  onReset: function() {

  },

  onConfig: function() {

  },

  onMakeTurn: function(color) {

  }



}

$(function() {
  FIL.events.onLoad();

  // Click on "Start new game"
  $('a.filler_start').on("click", function(e) {

    e.preventDefault();
  });

  // Click on "Reset"
  $('a.filler_reset').on("click", function(e) {

    e.preventDefault();
  });

  // Click on Cell (player makes his turn)
  $('div.' + FIL.view.fieldCellClass).on("click", function(e) {

    e.preventDefault();
  });
});
