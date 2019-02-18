class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
   enum role: [:user, :admin]
   devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
    after_create :welcome_send     
  	def welcome_send
		WelcomeMailer.welcome_send(self).deliver
	end 
       
end
