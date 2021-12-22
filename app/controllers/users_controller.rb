class UsersController < ApplicationController

	before_action :user_obj, only: [:edit, :update, :show]	



	def index
		@users = User.all
	end

	def new
		@user = User.new
	end


	def create
		@user = User.new(permit_user_params)
		if @user.save
			flash[:notice] = "User successfully created"
			redirect_to users_path				
		else
			flash[:notice] = "Unsuccessful creating the user"			
			render 'new'
		end
	end

	def edit
	end

	def update
		if @user.update(permit_user_params)
			redirect_to users_path
			flash[:notice] = "User updated successfully"
		else
			flash[:notice] = "User couldn't edit"
			render 'edit'
		end
	end

	def show
		@articles = @user.articles
		
	end


	private

		def permit_user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation)
		end

		def user_obj
			@user = User.find(params[:id])
		end
	end
