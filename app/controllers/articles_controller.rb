class ArticlesController < ApplicationController
	before_action :article_obj, only: [:show, :edit, :update, :destroy]
	before_action :require_logged_in, except: [:show, :index]
	before_action :require_same_user, only: [:edit,:update, :destroy]

	def index
		@articles = Article.paginate(page: params[:page], per_page: 5)
		
	end


	def show	
	end

	def new
		@article = Article.new

	end

	def create
		@article = Article.new(permit_params)
		# @article = Article.new title: params[:title], description: params[:description]
		if !logged_in?
			flash[:notice] = "First login to add a article"
		end
		@article.user = current_user
		if @article.save #as soon as it saves a ID will be assiciated with it
			redirect_to article_path(@article) #rails will extract id from @article, or you can use @articles.id as well 
			#redirect_to @articles #is a useful shortcut for this
			flash[:notice] = "Blog created successfully"
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @article.update(permit_params)
			redirect_to @article
			flash.notice = "Article updated successfully"
		else
			render 'edit'
		end
	end

	def destroy
		@article.destroy	
		redirect_to articles_path
		flash.notice = "Article successfully deleted"
	end

private

	def require_same_user
		if current_user != @article.user
			flash[:notice] = "you're not the owner of this article" 
			redirect_to @article
		end
	end
	
	def article_obj
		@article = Article.find(params[:id])
	end

	def permit_params
		params.require(:article).permit(:title, :description)
	end

end