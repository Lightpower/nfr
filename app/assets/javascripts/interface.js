$(function() {
  $("a.openable").bind("click", function(e) {
    var id = this.id,
      submenu = $(this).parents('.openable_holder').first().children("div.openable"),
      sign = $(this).children('span.sign').first(),
      sign_text = sign.text();

    if(submenu.hasClass("hidden")) {
      submenu.removeClass("hidden");
      sign_text = '[-]';
      if(id != '') NFR.openable.open(id);
    } else {
      submenu.addClass("hidden");
      sign_text = '[+]';

      if(id != '') NFR.openable.close(id);
    }
    sign.text(sign_text);

    e.preventDefault();
  });

  var openable_list = NFR.openable.array(),
      i = 0;

  for(; i<openable_list.length; ++i) {
    $("a#" + openable_list[i]).click();
  }
});
