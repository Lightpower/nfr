NFR.bonus_actions = {
  start: function(link_tag) {
    var bonus_id = $(link_tag).data('id');

    $('div#team_actions').append('<div class=\'start_action\' data-id=\'' + bonus_id + '\'>Кликните на выбранный код</div>');
  },

  select: function(code_tag) {
    var div_start = $('div.start_action'),
        bonus_id = $(div_start).data('id'),
        code_id = $(code_tag).data('id'),
        action_url = '/codes/bonus_action',
        data_string = { bonus_action: {bonus_id: bonus_id, code_id: code_id}};

    //alert("Bonus ID = " + bonus_id + "\nCode ID = " + code_id);


    $.ajax({
      type: 'PUT',
      url: action_url,
      dataType: 'json',
      data: data_string
    }).done(function(message){
      if(message.result == "ok") {
        $(div_start).remove();
        alert("Атака прошла успешно!");
      }else{
        $(div_start).remove();
        alert("Неудача!");
      }
      location.reload();
    });
    $(div_start).text('Ожидание...');
  }
};

$(function() {
  $("a.action_bonus").on("click", function(e) {

    if($('div.start_action').length == 0) {
      NFR.bonus_actions.start(this);
    }else{
      $('div.start_action').remove();
    }

    e.preventDefault();
  });
  $("span.ko").on("click", function(e) {

    if($('div.start_action').length > 0) {
      NFR.bonus_actions.select(this);
    }

    //$('div.start_action').remove();
    e.preventDefault();
  });

});