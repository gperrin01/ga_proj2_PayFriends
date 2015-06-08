class User < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 2}
  
  has_many :deals_as_payer, class_name: "Deal", foreign_key: "payer_id"
  has_many :deals_as_receiver, class_name: "Deal", foreign_key: "receiver_id"
  # SELECT "deals".* FROM "deals" WHERE "deals"."payer_id" = $1  [["payer_id", 1]]
  # SELECT "deals".* FROM "deals" WHERE "deals"."receiver_id" = $1  [["receiver_id", 1]]

  def deals
    # Deal.where => SELECT "deals".* FROM "deals" WHERE
    # deals.receiver_id = :id OR deals.payer_id = :id", id: id
    @deals = Deal.where("deals.receiver_id = :id OR deals.payer_id = :id", id: id)
    #  would be the same as self.deals_as_payer + self.deals_as_receiver
  end

  def to_pay
    self.deals.unsettled_deals.where(payer: self.id).map {|deal| deal.amount}.inject(&:+) || 0
  end
  def to_receive
    self.deals.unsettled_deals.where(receiver: self).map {|deal| deal.amount}.inject(&:+) || 0
  end

  def recap_balance(other_user)
    pay = self.deals.unsettled_deals.where(payer: self, receiver: other_user).map {|deal| deal.amount}.inject(&:+) || 0
    receive = self.deals.unsettled_deals.where(payer: other_user, receiver: self).map {|deal| deal.amount}.inject(&:+) || 0
    receive - pay
    # negative number means self owes ££ to other user (because means he is more payer than receiver)
  end 

end
