class Deal < ActiveRecord::Base
  validates :amount, presence: true
  validates :payer, presence: true
  validates :receiver, presence: true

  belongs_to :payer, class_name: "User", foreign_key: "payer_id"
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id"

  after_initialize :defaults
  def defaults
    self.description = 'no description yet'
    self.settled = 'false'
  end

  # has_many :settled_deals -> {where settled: true}, class_name: "Deal"
  def self.settled_deals
    self.where(settled: 'true')
    # or maybe :true or maybe 'true'
  end
  def self.unsettled_deals
    self.where(settled: 'false')
  end
  def settle_now
    self.update(settled: 'true')
  end

  def counterpart
    # return the user in the deal who is not Gui
    self.payer.name == 'Gui' ? self.receiver.name : self.payer.name
  end
  def verb_to_describe
    self.payer.name == 'Gui' ? 'borrows' : 'lends'
  end
  def long_description
    "#{self.counterpart} #{self.verb_to_describe} #{self.amount} - #{self.description}"
  end



end
