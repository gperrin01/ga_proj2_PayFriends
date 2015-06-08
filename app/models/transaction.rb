class Transaction < ActiveRecord::Base
  validates :name, presence:true
  validates :description, presence:true

  # has_many :settled_transactions -> {where settled: true}, class_name: "Transaction"

  belongs_to :payer, class_name: "User", foreign_key: "payer_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  def self.settled_transactions
    self.where(settled: :true)
  end

end
