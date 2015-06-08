class User < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}
  
  has_many :deals
  has_many :payers, class_name: "User" 
  has_many :receivers, class_name: "User" 


  def to_pay
    self.deals.unsettled_deals.where(payer: self.id).map {|deal| deal.amount}.inject(&:+) || 0
  end
  def to_receive
    self.deals.unsettled_deals.where(receiver: self).map {|deal| deal.amount}.inject(&:+) || 0
  end

  def recap_balance(other_user)
    pay = self.deals.unsettled_deals.where(payer: self, receiver: other_user).map {|deal| deal.amount}.inject(&:+) || 0
    receive = self.deals.unsettled_dealtions.where(payer: other_user, receiver: self).map {|deal| deal.amount}.inject(&:+) || 0
    receive - pay
    # negative number means self owes ££ to other user (because means he is more payer than receiver)
  end 

end
