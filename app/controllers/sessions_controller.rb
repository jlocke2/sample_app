class SessionsController < ApplicationController
	
	def new
	end

	def create
		user = User.find_by(email: params[:session][:email].downcase)
		if user && user.authenticate(params[:session][:password])
			sign_in user
			if current_user.name.blank?# && current_user.has_attribute?(:user_name) && current_user.has_attribute?(:email)
				flash[:danger] = 'Please update your information'
				redirect_to edit_user_path(current_user)
				return false
			end
            redirect_back_or user
            flash[:success] = 'Thanks for having all your information up to date!!'
            
		else
			flash.now[:danger] = 'Invalid email/password combination'
			render 'new'
			
		end
	end

	def destroy
		sign_out
		redirect_to root_url
	end
end
