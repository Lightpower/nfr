$(function() {
  $("a.openable").bind("click", function(e) {
    var id = this.id,
      submenu = $(this).parents('.openable_holder').first().children("div.openable"),
      this_text = $(this).text();
    if(submenu.hasClass("hidden")) {
      submenu.removeClass("hidden");
      this_text = "- " + this_text.split("+")[1];
      if(id != '') NFR.openable.open(id);
    } else {
      submenu.addClass("hidden");
      if(this_text[0] == '-') {
        this_text = "+" + this_text.split("- ")[1];
      }
      if(id != '') NFR.openable.close(id);
    }
    $(this).text(this_text);

    e.preventDefault();
  });

  var openable_list = NFR.openable.array(),
      i = 0;

  for(; i<openable_list.length; ++i) {
    $("a#" + openable_list[i]).click();
  }
});
