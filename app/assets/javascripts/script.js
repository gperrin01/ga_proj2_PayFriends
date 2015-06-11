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

    var amount =  data.deal.amount;
    // check if deal is I GIVE or I PAY
    var verb = data.long_description.split(' ')[1];
    appendDeal(data, verb);
    updateTotalBalance(amount, verb, 'add'); 
  })
}

function appendDeal(data, verb) {
  var new_item = "<ul class='indiv_deal_box'>";
  new_item += "<li class='indiv_deal_details'> <span>"+ data.time +"- </span> <a href='#'>"+ data.long_description +"</a> </li>"

  // if I OWE in the deal: add pay button, add to pending, add to to_pay
  if (verb === 'Owe') {
    new_item += "<li class='indiv_deal_pay'><button class='pay_button' data-id='"+ data.deal.id+ "'>Pay</button></li>";
    new_item +=  "</ul>";
    $('#deals_to_pay h4').after(new_item);
  } else if (verb === 'Give') {
    new_item +=  "</ul>";
    $('#deals_to_receive h4').after(new_item);
  }
  $('#pending_deals h4').after(new_item);
  
// not yet added to the list with your friends
}

function updateTotalBalance(amount, verb, action) {
  // if action is to settle a deal, that means amount is paid and therefore we remove it from the balance
  if (action === 'settle') {
    amount = amount * (-1);
  }

  if (verb === 'Give'){
    var balance = parseFloat($('#recap_to_receive').text());
    balance += amount;
    $('#recap_to_receive').text(balance);
  } else if (verb === 'Owe') {
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

    console.log('succes settle it');
    appendToHistory(data);
    var amount =  data.deal.amount;
    var verb = data.long_description.split(' ')[1];
    updateTotalBalance(amount, verb, 'settle') ;
    removeFromSubZones(data.deal.id, verb);
  })
}

function removeFromSubZones(deal_id, verb) {
  // remove the <ul> form the pending list, and from topay or toreceive, accordingly
    // - if i had $(this) i would go $(this).parent().parent()

  var thiss = $("#pending_deals button[data-id='" +deal_id+ "']");
  thiss.parent().parent().remove();

  if (verb === 'Give') {
    thiss = $("#deals_to_receive button[data-id='" +deal_id+ "']");
    thiss.parent().parent().remove();
  } else if (verb === 'Owe') {
    thiss = $("#deals_to_pay button[data-id='" +deal_id+ "']");
    thiss.parent().parent().remove();
  }
}

function appendToHistory(data) {
  var new_item = "<ul class='indiv_deal_box'>";
  new_item += "<li class='indiv_deal_details'> <span>"+ data.time +"- </span> <a href='#'>"+ data.long_description +"</a> </li>"
  new_item +=  "</ul>";
  $('#history h4').after(new_item);
}

function showHideSubZones(event) {
  event.preventDefault();
  var show = $(this).attr('data-go');
  $('.js_sub_zone').addClass('hidden');
  $(show).removeClass('hidden');

  // highlight the corresponding button
  $('#quick_menu a').removeClass('active_menu');
  $(this).addClass('active_menu');
}

function showDetails () {
  var id = $(this).attr("data-deal-id");
  $.ajax({
    type: 'GET',
    url: '/deals/'+id,
    dataType: 'json',
    data: {id: id}  
  }).done(function(data){
    var verb = data.long_description.split(' ')[1];
    appendToEdit(data, verb);
    fillEditForm(data)
  })
}

function appendToEdit(data, verb) {
  $('#edit_zone .indiv_deal_box').remove();
  $('#edit_zone p').remove();
  $('#edit_zone form').remove();
  var new_item = ""

  if (data.deal.settled === 't') {
      new_item = "<p>You cannot edit a deal already settled</p>";
  } 

  else if (data.deal.settled === 'false') {
    new_item = "<ul class='indiv_deal_box'>";
    new_item += "<li class='indiv_deal_details'> <span>"+ data.time +"- </span> <a href='#'>"+ data.long_description +"</a> </li>";

    if (verb === 'Owe') {
      new_item += "<li class='indiv_deal_pay'><button class='pay_button' data-id='"+ data.deal.id+ "'>Pay</button></li>";
    }
    new_item += "<li class='indiv_deal_delete'><button class='delete_button' data-id='"+ data.deal.id+ "'>Delete</button></li>";
    new_item +=  "</ul>";

    new_item += "<form class='' id='edit_deal' action='/deals/" +data.deal.id +"method='put'>";
    new_item += "<input type='text' name='deal[amount]' id='edit_deal_amount' value=" +data.deal.amount +">";
    new_item += "<input type='text' value="+ data.deal.description +"name='deal[description]' id='edit_deal_description'>";
    new_item += "<input type='submit' name='commit' value='Edit'></form>"
  }

  $('#edit_zone h4').after(new_item);
}

function fillEditForm(data){

}


$(document).ready(function() {
  $('#new_friend').on('submit', createUser);

  $('#new_deal').on('submit', createDeal);
  $('#view_zone').on('click', '.pay_button', settleDeal);

  $('#quick_menu a').on('click', showHideSubZones); 
  $('#view_zone').on('click', '.indiv_deal_box a', showDetails);
})

