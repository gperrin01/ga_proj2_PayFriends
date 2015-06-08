class User < ActiveRecord::Base
  validates :name, presence:true, length: {minimum: 2}
  
  has_many :transactions
  has_many :payers, class_name: "User" 
  has_many :receivers, class_name: "User" 

end
