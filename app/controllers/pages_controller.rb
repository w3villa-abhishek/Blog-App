class PagesController < ApplicationController
	def home
		if logged_in?
			flash[:notice] = "you're logged in"
		end
	end
end
