class UserMailer < ActionMailer::Base
  default from: "admin@sampleapp.com"

  def welcome_email(user)
  	@user = user
  	mail(to: @user.email, subject: "Welcome to Sample App!!")
  end
end
