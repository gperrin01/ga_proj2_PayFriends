require 'rails_helper'
require_relative 'transaction'

RSpec.describe User, type: :model do

  let(:payer){User.new name: 'Gui'}
  let(:receiver){User.new name: 'Joe'}
  let(:transac){Transaction.new amount: '10', description: 'test case', payer: payer.id, receiver: receiver.id}
  let(:transac2){Transaction.new amount: '20', description: 'test case', payer: payer.id, receiver: receiver.id}


  Context 'validation' do 
    it 'must have a name' do 
      user = User.new
      expect(user.valid?).to eq false
    end
    it 'is created with 0 to pay' do 
      user = User.new
      expect(user.to_pay).to eq 0
    end
    it 'is created with 0 to receive' do 
      user = User.new
      expect(user.to_receive).to eq 0
    end
  end

  # Context 'updating balances after a transaction' do
  #   # REFACTOR THIS !!
  #   it 'after a transaction, payer knows the total amount to pay' do 
  #     payer.transactions << transac
  #     expect(payer.to_pay).to eq 10
  #   end
  #   it 'after a transaction, receiver knows the total amount to receive' do 
  #     payer.transactions << transac << transac2
  #     expect(receiver.to_receive).to eq 30
  #   end
  #   it 'after a transaction, knows how much he owes another user' do 
  #     payer.transactions << transac
  #     expect(payer.recap_balance(receiver)).to eq -10
  #   end

  #   # see note on how to build model and only pass trhough settled_transactions
  #   it 'after a transaction is settled, it is removed from the payer total amount to_pay' do 
  #     payer.transactions << transac << transac2
  #     transac.settle_now
  #     expect(payer.to_pay).to eq 20
  #   end
  #   it 'after a transaction is settled, it is removed from the receiver total amount to_receive' do 
  #     payer.transactions << transac << transac2
  #     transac.settle_now
  #     expect(receiver.to_receive).to eq 20
  #   end
  #   it 'after a transaction is settled, it is removed from the balance between two users' do 
  #     payer.transactions << transac << transac2
  #     transac.settle_now
  #     expect(payer.recap_balance(receiver)).to eq -20
  #   end
  # end

  # Context 'updating balances after editing or deleting transactions' do 
  #  # is all the below FEATURE testing??
  #   it 'after editing transaction amount, payer knows new total amount to pay' do 
  #     payer.transactions << transac << transac2
  #     # transac.update(amount: 35)
  #     transac.edit_transaction({amount: 35})
  #     # might need to pass ALL params
  #     # could i just do transac.edit and use the "built-in" edit method?
  #     # remember to build it with options transac.edit_transaction(options = {}), triggering transac.update
  #     expect(payer.to_pay).to eq 55
  #   end
  #   it 'after editing transaction amount, receiver knows new total amount to receive' do 
  #     payer.transactions << transac << transac2
  #     # transac.update(amount: 35)
  #     transac.edit_transaction({amount: 35})
  #     # might need to pass ALL params
  #     # could i just do transac.edit and use the "built-in" edit method?
  #     # remember to build it with options transac.edit_transaction(options = {})
  #     expect(receiver.to_receive).to eq 55
  #   end
  #   it 'after editing transaction amount, knows the new balance with the other user ' do 
  #     payer.transactions << transac << transac2
  #     transac.edit_transaction({amount: 35})
  #     expect(payer.recap_balance(receiver)).to eq -55
  #   end

  #   it 'after editing transaction users, payer knows new total amount to pay' do 
  #     payer.transactions << transac << transac2
  #     transac.edit_transaction({payer: receiver.id, receiver: payer.id})
  #     expect(payer.to_pay). to eq 20
  #     #  Payer owes 10+20, then Payer owes 20 and will receive 10  
  #   end
  #   it 'after editing transaction users, payer knows new total amount to receive' do 
  #     payer.transactions << transac << transac2
  #     transac.edit_transaction({payer: receiver.id, receiver: payer.id})
  #     expect(payer.to_receive). to eq 10
  #     #  Payer owes 10+20, then Payer owes 20 and will receive 10 
  #   end
  #   it 'after editing transaction users, knows the new balance with the other user' do 
  #     payer.transactions << transac << transac2
  #     transac.edit_transaction({payer: receiver.id, receiver: payer.id})
  #     expect(receiver.recap_balance(payer)).to eq 10
  #     #  Payer owes 10+20, then Payer owes 20 and will receive 10 -> payer owes 10 to receiver
  #   end

  #   it 'after deleting transaction, payer knows new total amount to_pay' do 
  #     payer.transactions << transac << transac2
  #     transac.destroy
  #     expect(receiver.to_receive).to eq 20
  #   end
  #   it 'after deleting transaction, receiver knows new total amount to_receive' do 
  #     payer.transactions << transac << transac2
  #     transac.destroy
  #     expect(receiver.to_receive).to eq 20
  #   end
  #   it 'after deleting transaction, knows the new balance with the other user ' do 
  #     payer.transactions << transac << transac2
  #     transac.destroy
  #     expect(payer.recap_balance(receiver)).to eq -20
  #   end
  # end


end