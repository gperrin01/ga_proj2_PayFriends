Pay button only visible if you owe something 
  - individual transaction
  - recap with another user

Pay now quick transaction triggers transac.create AND transac.settle_now

Recap balance between 2 users only shows 'Gui owes Joe 20'
follow function as per user test:  expect(payer.recap_balance(receiver)).to eq -10


    <%= form_for @deal do |form| %>
      
      <%= form.label :rating %>
      <%= form.select :rating, options_for_select(1..5) %>

      <%= form.label :amount %>
      <%= form.text_field :amount %>

      <%= form.label :description %>
      <%= form.text_field :description %>


      <%= form.submit 'Submit' %>

    <% end %>