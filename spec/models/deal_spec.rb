require 'rails_helper'


RSpec.describe Deal, type: :model do
  
  let(:payer){User.new name: 'Gui'}
  let(:receiver){User.new name: 'Joe'}
  let(:deal){Deal.new amount: 10, description: 'test case', payer: payer, receiver: receiver}
  let(:deal2){Deal.new amount: 20, description: 'test case', payer: payer, receiver: receiver}

  context 'default and validation' do
    it 'must have an amount' do 
      deal = Deal.new description: 'test case', payer: payer.id, receiver: receiver.id
      expect(deal.valid?).to eq false
    end
    it 'has a default description' do 
      deal = Deal.new amount: 10, payer: payer.id, receiver: receiver.id
      expect(deal.description).to eq 'no description yet'
    end
    it 'must have a payer' do 
      deal = Deal.new amount: 10, description: 'test case', receiver: receiver.id
      expect(deal.valid?).to eq false
    end
    it 'must have a receiver' do 
      deal = Deal.new amount: 10, description: 'test case', payer: payer.id
      expect(deal.valid?).to eq false
    end
    it 'is by default unsettled' do
      deal = Deal.new
      expect(deal.settled).to eq false
    end
  end

  context 'usual behavior'  do 
    it 'can be settled' do
      payer.deals_as_payer << deal << deal2
      deal.settle_now
      expect(deal.settled).to eq true
    end
  end

  context 'editing deals' do 
    # REFACTOR !!
    # actually make it a capybara one: no edit-delete button if you are settled!
    # it 'cannot be edited if already settled' do 
    #   payer.deals << deal
    #   deal.settle_now
    #   expect{deal.edit_deal}.to raise_error
    # end
    # it 'cannot be deleted if already settled' do 
    #   payer.deals << deal
    #   deal.settle_now
    #   expect{deal.delete_deal}.to raise_error
    # end
  end

end
