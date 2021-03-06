class Deal < ActiveRecord::Base
  validates :amount, presence: true
  validates :payer, presence: true
  validates :receiver, presence: true

  belongs_to :payer, class_name: "User", foreign_key: "payer_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  # after_initialize :defaults
  # def defaults
  #   self.description = 'no description yet'
  #   self.settled = 'false'
  # end

  # has_many :settled_deals -> {where settled: true}, class_name: "Deal"
  def self.settled_deals
    self.where(settled: true)
  end
  def self.unsettled_deals
    self.where(settled: false)
  end
  def settle_now
    self.update(settled: true)
  end

  def counterpart(current_user)
    # return the user in the deal who is not current_user
    self.payer == current_user ? self.receiver.name : self.payer.name
  end
  def verb_to_describe(current_user)
    self.payer == current_user ? 'Give' : 'Owe'
  end
  def time_create_readable
    self.created_at.strftime("%d-%b-%Y")
  end
  def long_description(current_user)
    "you #{self.verb_to_describe(current_user)} #{self.counterpart(current_user)}  #{self.amount} - #{self.description}"
  end



end
