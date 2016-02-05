class GlobalMailer < ApplicationMailer
	default from: "contact.sherbim@gmail.com"
	def welcome(user)
    	@user = user
    	mail(to: @user.email, subject: 'Bienvenue chez Sherbim')
  	end

  	def confirmservice(user)
  		@user = user
    	mail(to: @user.email, subject: 'Votre nouvelle demande est en ligne !')
    end

    def notifydemand(service)
  		@user = service.user
  		@service = service

    	mail(to: @user.email, subject: 'Quelqu\'un souhaite vous aider')
    end

    def notifyparticipants(users)
    	@users = users

    	@users.each do |user|
    		@user = user
    		mail(to: user.email, subject: 'Vous avez été récompensé !')	
    	end
    end

end
