require 'rails_helper'
require_relative 'transaction'

RSpec.describe User, type: :model do

  let(:payer){User.new name: 'Gui'}
  let(:receiver){User.new name: 'Joe'}
  let(:transac){Transaction.new amount: '10', description: 'test case', payer: payer.id, receiver: receiver.id}

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



  it 'can create a transaction with immediate payment' do 
  end


end
