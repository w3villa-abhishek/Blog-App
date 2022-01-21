	class SessionsController < ApplicationController

	before_action :require_logged_in, only: [:destroy]

	def new
	end

	def create
		user = User.find_by(email: params[:ssn][:email].downcase)
		if user && user.authenticate(params[:ssn][:password])
			session[:user_id] = user.id  #session obj. by rails
 			flash[:notice] = "Successfully logged in"
			redirect_to user
		else
			flash.now[:notice] = "Wrong entries, please retry"			
			render 'new'

		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "logged out Successfully"
		redirect_to root_path
 	end

end