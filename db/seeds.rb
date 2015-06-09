
User.delete_all
Deal.delete_all

gui = User.create(name: 'Gui')
bob = User.create(name: 'Bob')

d1 = Deal.create amount: 10, description: 'first deal', payer: gui, receiver: bob
d2 = Deal.create amount: 23, description: 'first deal', payer: bob, receiver: gui