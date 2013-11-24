NFR.games = {
  filter: function(filter_class) {
    if(filter_class === '') {
      $('div.game').fadeIn();
    }else{
      $('div.game').fadeOut(0);
      $('div.game.' + filter_class).fadeIn();
    }
  }
};

$(function() {
  $('a.header_menu_item').on("click", function(e) {
    NFR.games.filter($(this).data('class'));
    $('a.header_menu_item').removeClass('selected');
    $(this).addClass('selected');
    e.preventDefault();
  });
});
