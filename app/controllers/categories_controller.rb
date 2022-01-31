class CategoriesController < ApplicationController
	before_action :category_assign, only: [:show, :edit, :update]
	before_action :require_logged_in, only: [:new, :create, :edit, :update]
	before_action :only_admin_can_perform, only: [:new, :create, :edit, :update]

def index
	@categories = Category.all
end


def show
	@articles = @category.articles
end

def new
	@category = Category.new
end


def create
	@category = Category.new(permit_params)
		if @category.save
			flash[:notice] = "category succesfully created"
			redirect_to categories_path
		else
			flash.now[:notice] = "Unsuccessful creating category"
			render 'new'

		end
end

def edit
end

def update
		if @category.update(permit_params)
			flash[:notice] = "Category updated successfully"
			redirect_to categories_path
		else
			flash.now[:notice] = "Couldn't update the article"
			render 'edit'
		end
end	


private
	def category_assign
		@category = Category.find(params[:id])
	end

	def permit_params
		params.require(:category).permit(:name)
	end

	def only_admin_can_perform
		if  logged_in? && !current_user.admin?
		flash.notice = "Only admins can perform this action"
		redirect_to categories_path
		end	
	end

end
