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
    appendToPendingDeal(data);

    var amount =  data.deal.amount;
    var verb = data.long_description.split(' ')[1];
    updateTotalBalance(amount, verb, 'add');  
  }).fail(function(data){
    console.log('failure new deal');
  })
}

function appendToPendingDeal(data) {
  var new_item = "<ul class='indiv_deal_box'>";
  new_item += "<li class='indiv_deal_details'> <span>"+ data.time +"- </span> <a href='#'>"+ data.long_description +"</a> </li>"
  if (data.long_description.includes('Receive')) {
    new_item += "<li class='indiv_deal_pay'><button class='pay_button' data-id='"+ data.deal.id+ "'>Pay</button></li>";
  }
  new_item +=  "</ul>";
  $('#pending_deals').append(new_item);
}

function updateTotalBalance(amount, verb, action) {
  // If the action is to add a deal, then we add the amount to the balance
  // if action is to settle a deal, that means amount is paid and therefore we remove it from the balance

  if (action === 'settle') {
    amount = amount * (-1);
  }

  if (verb === 'Give'){
    var balance = parseFloat($('#recap_to_receive').text());
    balance += amount;
    $('#recap_to_receive').text(balance);
  } else if (verb === 'Receive') {
    var balance = parseFloat($('#recap_to_pay').text());
    balance += amount;
    $('#recap_to_pay').text(balance);
  }
}

function settleDeal() {
  // mark as settled, remove from the balances, append to the history, remove from the pending list

  console.log('settle deal');
  var id = $(this).attr("data-id");

  $.ajax({
    type: 'PUT',
    url: '/deals/'+id,
    dataType: 'json',
    data: {id: id}  
  }).done(function(data){
    debugger;
    console.log('succes settle it');
    appendToHistory(data);
    
    // remove the <ul> form the pending list - if i had $(this) i would go $(this).parent().parent()
    var thiss = $("#pending_deals button[data-id='" +data.deal.id+ "']");
    thiss.parent().parent().remove();

    var amount =  data.deal.amount;
    var verb = data.long_description.split(' ')[1];
    updateTotalBalance(amount, verb, 'settle') ;
  })
}

function appendToHistory(data) {
  var new_item = "<ul class='indiv_deal_box'>";
  new_item += "<li class='indiv_deal_details'> <span>"+ data.time +"- </span> <a href='#'>"+ data.long_description +"</a> </li>"
  new_item +=  "</ul>";
  $('#history').append(new_item);
}

function showHideSubZones(event) {
  console.log('shw hide');
  event.preventDefault
  var show = $(this).attr('data-go');
  $('.sub_zone').hide();
  $(show).show();
}

$(document).ready(function() {
  $('#new_friend').on('submit', createUser);
  $('#new_deal').on('submit', createDeal);
  $('.pay_button').on('click', settleDeal);

  $('#quick_menu a').on('click', showHideSubZones); 
})