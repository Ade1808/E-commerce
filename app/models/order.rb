class Order < ApplicationRecord
  belongs_to :user
  enum status:[:acceptance_pending,:approved,:not_approved]
  scope :Acceptance_Pending , ->{where(:status=>0)}
  scope :Approved ,			  ->{where(:status=>1)}
  scope :Not_Approved ,       ->{where(:status=>2)}	
end
