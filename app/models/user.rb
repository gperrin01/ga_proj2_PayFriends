class User < ActiveRecord::Base
  validates :name, presence:true, length: {minimum: 2}
  
  has_many :transactions
  has_many :payers, class_name: "User" 
  has_many :receivers, class_name: "User" 


  def to_pay
    list = self.transactions.unsettled_transactions.where(payer: self.id).map {|transac| transac.amount}.inject(&:+)
    list == nil ? 0 : list
  end
  def to_receive
    list = self.transactions.unsettled_transactions.where(receiver: self).map {|transac| transac.amount}.inject(&:+)
    list == nil ? 0 : list
  end

end
