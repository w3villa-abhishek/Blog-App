class PagesController < ApplicationController
	def home
		if logged_in?
			if current_user.admin?
		 		flash[:notice] = "you're logged in as admin"	
			else
				flash[:notice] = "you're logged in"
			end 		
		end
	end
end
