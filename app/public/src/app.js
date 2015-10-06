$(document).ready(function() {

  var board = new Board;

  $('.grid').on('click', function() {
    var gridColour = board.fire();
    $(this).css('background', gridColour);
    coOrdinates = ($(this).text()).split('-');
    $.ajax({
      url: '/test',
      type: 'POST',
      dataType: 'json',
      contentType: 'application/json',
      data: JSON.stringify(coOrdinates),
      success: function() {
      },
    });
  });
});
