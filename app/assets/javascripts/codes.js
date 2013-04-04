NFR.codes = {
  update: function(link_tag) {
    var action_url = $(link_tag).data("url"),
      tr = $('table.free_code tr'),
      i = 0, row, select,
      data_string,
      data_array = [];


    for(i; i<tr.length; ++i) {
      row = tr[i];
      select = $(row).find('select')[0];
      if(select && select.selectedIndex > 0) {
        data_array.push('"' + $(row).data("id") + '":"' + select[select.selectedIndex].value +'"');
      }
    }

    data_string = jQuery.parseJSON('{"attach":{' + data_array.join() + '}}');

    $.ajax({
      type: 'PUT',
      url: action_url,
      dataType: 'json',
      data: data_string
    }).done(function(message){
      if(message.result == "ok") {
        alert("Средства успешно распределены!");
        location.reload();
      }else{
        alert("Ошибка распределения средств!");
      }
    });

  }
};

$(function() {
  $("a#attach_free_code").on("click", function(e) {
    NFR.codes.update(this);
    e.preventDefault();
  });
});