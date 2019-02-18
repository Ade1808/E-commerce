class WelcomeMailer < ApplicationMailer
	def welcome_send(user)
		@user=user
		mail to: user.email,subject: "Welcome to my site" ,from: "umer.farooq.azam.dhillon@gmail.com"
	end

end
