class PagesController < ApplicationController
	def home
		flash[:notice] = "you're logged in"
		redirect_to articles_path
	end
end
