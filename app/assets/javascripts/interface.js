$(function() {
  $("a.openable").bind("click", function(e) {
    var submenu = $(this).parents('.openable_holder').first().children("div.openable"),
      this_text = $(this).text();
    if(submenu.hasClass("hidden")) {
      submenu.removeClass("hidden");
      this_text = "- " + this_text.split("+")[1];
    } else {
      submenu.addClass("hidden");
      this_text = "+" + this_text.split("- ")[1];
    }
    $(this).text(this_text);

    e.preventDefault();
  });
});
