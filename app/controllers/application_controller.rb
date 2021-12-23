class ApplicationController < ActionController::Base

	
	helper_method :current_user, :logged_in?   #if not mentioned, available to controllers only not views
	

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id] # ||= prevents hiting db everytime instead return @current user, if exist.
	end


		def logged_in?
		!!current_user  #!!converts anything into boolean in rails
	end


end
