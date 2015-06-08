class User < ActiveRecord::Base
  validates: name, presence:true, length: {minimum: 2}

  has_and_belongs_to_many :cross_balances
  has_many :transactions

  has_many :payers, class_name: "User" 
  has_many :receivers, class_name: "User" 

  # user = User.find(3)
  # user.balance
  def outstanding_balances
    self.transactions.where(payer: self).map do |t|
      add balance
    end
  end
end
