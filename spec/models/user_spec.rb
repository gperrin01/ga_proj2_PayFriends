require 'rails_helper'


RSpec.describe User, type: :model do

  let(:payer) {User.create name: 'Gui'}
  let(:receiver){User.create name: 'Joe'}
  let(:deal){Deal.create amount: 10, description: 'test case', payer: payer, receiver: receiver}
  let(:deal2){Deal.create amount: 20, description: 'test case', payer: payer, receiver: receiver}


  context 'validation' do 
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

  context 'updating balances after a deal' do
    # REFACTOR THIS !!
    it 'after a deal, user knows how much he owes another user' do 
      payer.deals_as_payer << deal
      receiver.deals_as_receiver << deal
      expect(payer.recap_balance(receiver)).to eq -10
    end
    it 'after a deal, payer knows the total amount to pay' do 
      payer.deals_as_payer << deal
      expect(payer.to_pay).to eq 10
    end
    it 'after a deal, receiver knows the total amount to receive' do 
      receiver.deals_as_receiver << deal << deal2
      expect(receiver.to_receive).to eq 30
    end

    # see note on how to build model and only pass trhough settled_deals
    it 'after a deal is settled, it is removed from the balance between two users' do 
      payer.deals_as_payer << deal << deal2
      receiver.deals_as_receiver << deal << deal2
      deal.settle_now
      expect(payer.recap_balance(receiver)).to eq -20
    end
    it 'after a deal is settled, it is removed from the payer total amount to_pay' do 
      payer.deals_as_payer << deal << deal2
      receiver.deals_as_receiver << deal << deal2
      deal.settle_now
      expect(payer.to_pay).to eq 20
    end
    it 'after a deal is settled, it is removed from the receiver total amount to_receive' do 
      payer.deals_as_payer << deal << deal2
      receiver.deals_as_receiver << deal << deal2
      deal.settle_now
      expect(receiver.to_receive).to eq 20
    end
  end

  context 'updating balances after editing or deleting deals' do 
   # is all the below FEATURE testing??
    xit 'after editing deal amount, a user knows the new balance with the other user ' do 
      payer.deals << deal << deal2
      deal.edit_deal({amount: 35})
      expect(payer.recap_balance(receiver)).to eq -55
    end
    xit 'after editing deal amount, payer knows new total amount to pay' do 
      payer.deals << deal << deal2
      # deal.update(amount: 35)
      deal.edit_deal({amount: 35})
      # might need to pass ALL params
      # could i just do deal.edit and use the "built-in" edit method?
      # remember to build it with options deal.edit_deal(options = {}), triggering deal.update
      expect(payer.to_pay).to eq 55
    end
    xit 'after editing deal amount, receiver knows new total amount to receive' do 
      payer.deals << deal << deal2
      # deal.update(amount: 35)
      deal.edit_deal({amount: 35})
      # might need to pass ALL params
      # could i just do deal.edit and use the "built-in" edit method?
      # remember to build it with options deal.edit_deal(options = {})
      expect(receiver.to_receive).to eq 55
    end
    xit 'after editing deal users, payer knows new total amount to pay' do 
      payer.deals << deal << deal2
      deal.edit_deal({payer: receiver.id, receiver: payer.id})
      expect(payer.to_pay). to eq 20
      #  Payer owes 10+20, then Payer owes 20 and will receive 10  
    end
    xit 'after editing deal users, payer knows new total amount to receive' do 
      payer.deals << deal << deal2
      deal.edit_deal({payer: receiver.id, receiver: payer.id})
      expect(payer.to_receive). to eq 10
      #  Payer owes 10+20, then Payer owes 20 and will receive 10 
    end

    xit 'after editing deal users, knows the new balance with the other user' do 
      payer.deals << deal << deal2
      deal.edit_deal({payer: receiver.id, receiver: payer.id})
      expect(receiver.recap_balance(payer)).to eq 10
      #  Payer owes 10+20, then Payer owes 20 and will receive 10 -> payer owes 10 to receiver
    end

    xit 'after deleting deal, knows the new balance with the other user ' do 
      payer.deals << deal << deal2
      deal.delete_deal
      expect(payer.recap_balance(receiver)).to eq -20
    end
    xit 'after deleting deal, payer knows new total amount to_pay' do 
      payer.deals << deal << deal2
      deal.delete_deal
      expect(receiver.to_receive).to eq 20
    end
    xit 'after deleting deal, receiver knows new total amount to_receive' do 
      payer.deals << deal << deal2
      deal.delete_deal
      expect(receiver.to_receive).to eq 20
    end
  end



end
