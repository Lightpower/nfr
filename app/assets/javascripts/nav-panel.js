var h_hght = 150;
var h_mrg = 0;

$(function(){
  $(window).scroll(function(){
    var top = $(this).scrollTop();
    var elem = $('#top_nav');

    if (top+h_mrg < h_hght) {
      elem.css({'top': h_hght + 'px', 'position': 'absolute'} );
    } else {
      elem.css({'top': 0 + 'px', 'position': 'fixed'} );
    }
  }).trigger('scroll');
});
