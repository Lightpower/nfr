// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.

NFR.team_requests = {
  process: function(team_request) {
    var action_url = $(team_request).data("url");
    $.ajax({
      type: 'PUT',
      url: action_url,
      dataType: 'json'
    }).done(function(message){
      if(message.result == "ok") {
        alert("Операция выполнена успешно!");
        $(team_request).parent().remove();
      }else{
        alert("Ошибка рассмотрения запроса на вступление в команду!");
      }
    });

  }
};

$(document).ready(function() {
  $("div.team_request a").on("click", function(e) {
    NFR.team_requests.process(this);
    e.preventDefault();
  });

});