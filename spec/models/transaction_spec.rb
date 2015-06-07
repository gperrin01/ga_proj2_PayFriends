require 'rails_helper'
require_relative 'user'

RSpec.describe Transaction, type: :model do
  
  let(:payer){User.new name: 'Gui'}
  let(:receiver){User.new name: 'Joe'}
  let(:transac){Transaction.new amount: '10', description: 'test case', payer: payer.id, receiver: receiver.id}
  let(:transac2){Transaction.new amount: '20', description: 'test case', payer: payer.id, receiver: receiver.id}

  Context 'default and validation' do
    it 'must have an amount' do 
      transaction = Transaction.new
      expect(transaction.valid?).to eq false
    end
    it 'must have a description' do 
      transaction = Transaction.new
      expect(transaction.valid?).to eq false
    end
    it 'must have a payer' do 
      transaction = Transaction.new
      expect(transaction.valid?).to eq false
    end
    it 'must have a receiver' do 
      transaction = Transaction.new
      expect(transaction.valid?).to eq false
    end
    it 'is by default unsettled'
      transaction = Transaction.new
      expect(transaction.settled).to eq 'false'
    end
  end


  Context 'usual behavior'  do 
      it 'can be settled' do 
      payer.transactions << transac
      transac.settle_now
      expect(transac.settled).to eq 'true'
    end
  end

  Context 'editing transactions' do 
    # REFACTOR !!
    # actually make it a capybara one: no edit-delete button if you are settled!
    it 'cannot be edited if already settled' do 
      payer.transactions << transac
      transac.settle_now
      expect(transac.edit).to eq raise_error
    end
    it 'cannot be deleted if already settled' do 
      payer.transactions << transac
      transac.settle_now
      expect(transac.delete).to eq raise_error
    end
  end



end
