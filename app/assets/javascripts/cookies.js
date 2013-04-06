NFR.cookies = {
  get: function(name) {
    var cookie = " " + document.cookie;
    var search = " " + name + "=";
    var setStr = null;
    var offset = 0;
    var end = 0;
    if (cookie.length > 0) {
      offset = cookie.indexOf(search);
      if (offset != -1) {
        offset += search.length;
        end = cookie.indexOf(";", offset);
        if (end == -1) {
          end = cookie.length;
        }
        setStr = cookie.substr(offset, end);
      }
    }
    return(setStr || "");
  },
  set: function (name, value, expires, path, domain, secure) {
    document.cookie = name + "=" + value +
      ((expires) ? "; expires=" + expires : "") +
      ((path) ? "; path=" + path : "") +
      ((domain) ? "; domain=" + domain : "") +
      ((secure) ? "; secure" : "");
  }
};