class ApplicationController < ActionController::Base

	
	helper_method :current_user, :logged_in?   
	#if not mentioned, available to controllers only not views
	

	def current_user
		@current_user ||= User.find(session[:user_id]) if session[:user_id] 
		#memoization 
		#||= prevents hiting db everytime instead return @current user, if exist.
	end


	def logged_in?
		!!current_user  #!!converts anything into boolean in rails
	end

	def require_logged_in
		flash[:notice]= "You're not authorized before login" if !logged_in?
		redirect_to login_path if !logged_in?
	end


end
