// var hello = 'Hello';

$(document).ready(function() {



  $('.opponent').on('click', function() {
    // $(this).css('background', 'purple');

    var fired_position = this.id;
    fired_position = fired_position.replace('grid-','');
    fired_position = fired_position.replace('-',',');

    // console.log(fired_position);

    var params = {'position': fired_position};

    $.ajax({
    url: '/test',
    type: 'POST',
    contentType: "application/json",
    data:JSON.stringify(params),
    success: function(data){
      // console.log(data);
      // console.log("success");
      // window.location.replace("/test1");
      // window.location.replace("/game/new");
      location.reload();
    },
    error: function(data) {
      // console.log(data)
      console.log("error happened");
    }
    });

  });



});
