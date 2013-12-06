$(function() {
  var update = function(data) {
    $('ul li').remove();
    var ul = $('ul');
    $(data.files).each(function(index, item) {
      ul.append('<li><a href="' + item.url + '" target="porthole">' + item.name + '</a></li>');
    });
  };

  var fetch = function() {
    $.get('/files', function(data) {
      update(data);
      setTimeout(fetch, 1000);
    });
  };

  fetch();
});
