
User.delete_all
Deal.delete_all

gui = User.create(name: 'Gui', email: 'Gui')
bob = User.create(name: 'Bob', email: 'Bob')
jack = User.create(name: 'Jack', email: 'Jack')

d1 = Deal.create amount: 10, description: 'first deal', payer: gui, receiver: bob
d2 = Deal.create amount: 23, description: 'dinner deal', payer: bob, receiver: gui
d3 = Deal.create amount: 73, description: 'cinema night', payer: jack, receiver: gui
d4 = Deal.create amount: 45, description: 'tickets to bon jovi', payer: gui, receiver: jack
d5 = Deal.create amount: 5, description: 'quick change', payer: gui, receiver: jack
d6 = Deal.create amount: 155, description: 'gift mum', payer: bob, receiver: gui