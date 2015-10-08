// $(document).ready(function() {
//
//   $('#div1').on('click', function(){
//
//     $(this).css("background-color",'yellow');
//
//     var params = {"ID1234": this.id};
//
//     $.ajax({
//     url: '/test',
//     type: 'POST',
//     // dataType: 'json',
//     contentType: "application/json",
//     data:JSON.stringify(params),
//     success: function(data){
//       console.log(data);
//       console.log("success");
//     },
//     error: function(data) {
//       console.log(data)
//       console.log("error happened");
//     }
//     });
//
//   });
//
// });






  // var board = new Board;
  //
  // $('.grid').on('click', function() {
  //   var gridColour = board.fire();
  //   $(this).css('background', gridColour);
  //   coOrdinates = ($(this).text()).split('-');
  //   $.ajax({
  //     url: '/test',
  //     type: 'POST',
  //     dataType: 'json',
  //     contentType: 'application/json',
  //     data: JSON.stringify(coOrdinates),
  //     success: function() {
  //     },
  //   });
  // });




// };
// //
// ajax1();
//
// data = 'HELLO'
//
//
// $.post( "/test", { func: "getNameAndTime" }, function( data ) {
  // console.log( data ); // John
  // console.log( data.time ); // 2pm
// }, "json");



//
// $.get( "users/new", function( data ) {
//   $( "#div1" ).html( data );
//   alert( "Load was performed." );
// });


//
//
//   setTimeout(
//     function()
//     {
//     }, 5000);

      // window.location.href = '/test1'

  // $.ajax({
  //   url: '/test1'
  //   type: 'GET'
  //   success: function(url) {
  //
  //     // window.navigate(url);
  //
  //
  //   }
  //
  // });



// setTimeout(
//   function()
//   {
//     console.log('time');
//     $('#div1').html('DONE!!!');
//     location.reload();
//   }, 2000);
//
//   setTimeout(
//     function()
//     {
//       location.reload();
//     }, 3000);


    // $.when(ajax1()).done(function(a1){
    //   console.log('hello');
    //   $('#div1').html('DONE!!!');
    // });


// $(document).ready(function() {
//
//
//
//   $('.opponent').on('click', function() {
//     $(this).css('background', 'purple');
//
//     var fired_position = this.id;
//     fired_position = fired_position.replace('grid-','');
//     fired_position = fired_position.replace('-',',');
//
//     console.log(fired_position);
//
//     var params = {'position': fired_position};
//
//     $.ajax({
//     url: '/test',
//     type: 'POST',
//     contentType: "application/json",
//     data:JSON.stringify(params),
//     success: function(data){
//       console.log(data);
//       console.log("success");
//       window.location.replace("/test1");
//     },
//     error: function(data) {
//       console.log(data)
//       console.log("error happened");
//     }
//     });
//
//   });
//
//
//
// });
