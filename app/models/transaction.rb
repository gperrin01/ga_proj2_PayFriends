class Transaction < ActiveRecord::Base
  validates :amount, presence:true
  validates :payer, presence:true
  validates :receiver, presence:true

  belongs_to :payer, class_name: "User", foreign_key: "payer_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  after_initialize :defaults
  def defaults
    self.description = 'no description yet'
    self.settled = 'false'
  end

  # has_many :settled_transactions -> {where settled: true}, class_name: "Transaction"
  def self.settled_transactions
    self.where(settled: :true)
  end

  def settle_now
    self.settled = 'true'
  end



end
