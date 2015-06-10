function createUser(event) {
  event.preventDefault();
  console.log('create user');
  var userName = $('#user_name').val();

  $.ajax({
    type: 'POST',
    url: '/users/create_friend',
    dataType: 'json',
    data: {name: userName}  
  }).done(function(data){
    appendNewUser(data);
    console.log('succes new user');
  })
}

function appendNewUser(data){
  new_item = "<option value=" +data.id+ ">"+data.name+"</option>";
  $('#deal_payer').append(new_item);
  $('#deal_receiver').append(new_item);
}

function createDeal(event) {
  event.preventDefault();
  console.log('create deal');
  var amount = $('#deal_amount').val();
  var payer = $('#deal_payer').val();
  var receiver = $('#deal_receiver').val();
  var description = $('#deal_description').val();

  $.ajax({
    type: 'POST',
    url: '/deals',
    dataType: 'json',
    data: {amount: amount, payer: payer, receiver: receiver, amount: amount, description: description }  
  }).done(function(data){
    console.log('success new deal');
    console.log(data);
    appendNewDeal(data);

    var amount =  data.deal.amount;
    var verb = data.long_description.split(' ')[1]
    updateTotalBalance(amount, verb)  
  }).fail(function(data){
    console.log('failure new deal');
  })
}

function appendNewDeal(data) {
  var new_item = "<ul class='indiv_deal_box'>";
  new_item += "<li class='indiv_deal_details'> <span>"+ data.time +"- </span> <a href='#'>"+ data.long_description +"</a> </li>"
  if (data.long_description.includes('Receive')) {
    new_item += "<li class='indiv_deal_pay'><button class='pay_button' data-id='"+ data.deal.id+ "'>Pay</button></li>";
  }
  new_item +=  "</ul>";
  $('#pending_deals').append(new_item);
}

function updateTotalBalance(amount, verb) {
  if (verb === 'Give'){
    var balance = parseFloat($('#recap_to_receive').text())
    balance += amount
    $('#recap_to_receive').text(balance)
  } else if (verb === 'Receive') {
    var balance = parseFloat($('#recap_to_pay').text())
    balance += amount
    $('#recap_to_pay').text(balance)
  }
}


$(document).ready(function() {
  $('#new_friend').on('submit', createUser);
  $('#new_deal').on('submit', createDeal);
})