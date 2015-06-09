// function logIn(event) {
//   event.preventDefault();
//   console.log('login');
//   var userName = $('#login').val();

//   $.ajax({
//     type: 'POST',
//     url: '/users',
//     dataType: 'json',
//     data: {name: userName}  
//   })
// }


function createUser(event) {
  event.preventDefault();
  console.log('create user');
  var userName = $('#user_name').val();

  $.ajax({
    type: 'POST',
    url: '/users',
    dataType: 'json',
    data: {name: userName}  
  }).done(function(data){
    // debugger;
    // appendNewUser(data);
    console.log('success');
    console.log(data);
  })
}


$(document).ready(function() {
  $('#new_user').on('submit', createUser);
  // $('#login').on('submit', logIn);
})