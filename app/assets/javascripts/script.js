
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
    debugger;
    appendNewUser(data);
  })
}


$(document).ready(function() {
  // getItems();
  $('#new_user :submit').on('click', createUser);
})