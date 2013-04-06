NFR.openable = {
  array: function() {
    var closed_list = NFR.cookies.get('openable');
    return closed_list ? closed_list.substr(1, closed_list.length-3).split(',') : [];
  },
  open: function(name) {
    var closed_list = NFR.cookies.get('openable');
    if( NFR.openable.is_closed(name)) {
      closed_list = closed_list.replace(name + ',', '');
      NFR.cookies.set('openable', closed_list);
    }
  },
  close: function(name) {
    var closed_list = NFR.cookies.get('openable');
    if( ! NFR.openable.is_closed(name)) {
      closed_list = '[' + closed_list.substr(1, closed_list.length-2) + name + ',' + ']';
      NFR.cookies.set('openable', closed_list);
    }
  },
  is_closed: function (name) {
    return NFR.cookies.get('openable').indexOf(name + ',') >= 0;
  }
};