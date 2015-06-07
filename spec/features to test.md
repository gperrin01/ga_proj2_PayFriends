Pay button only visible if you owe something 
  - individual transaction
  - recap with another user

Pay now quick transaction triggers transac.create AND transac.settle_now

Recap balance between 2 users only shows 'Gui owes Joe 20'
follow function as per user test:  expect(payer.recap_balance(receiver)).to eq -10