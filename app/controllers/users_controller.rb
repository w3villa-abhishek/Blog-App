class UsersController < ApplicationController

	before_action :user_obj, only: [:edit, :update, :show, :destroy]	
	before_action :require_logged_in, only: [:edit, :update, :destroy]
	before_action :require_same_user, only: [:edit, :update, :destroy]



	def index
		@users = User.paginate(page: params[:page], per_page: 5)
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
  		@articles = @user.articles.paginate(page: params[:page], per_page: 5)
		
	end

	def destroy
		@user.destroy
		session[:user_id] = nil
		flash[:notice] = "user and all associated articles destroyed successfully.."
		redirect_to users_path
	end


	private

		def require_same_user
			if current_user != @user
				flash[:notice] = "You're not authorized" 
				redirect_to @user
			end
		end

		def permit_user_params
			params.require(:user).permit(:username, :email, :password, :password_confirmation)
		end

		def user_obj
			@user = User.find(params[:id])
		end
	end
