class ArticlesController < ApplicationController
	include ArticlesHelper	
		# params.require(:article).permit(:title, :body) is defined in app/helpers/articles_helper.rb

	def index
	  @articles = Article.all
	end

	def show
		@article = Article.find(params[:id])

		@comment = Comment.new	#adding new comment in show Article (different than Rails officila tutorial)
		@comment.article_id = @article.id
		#why we aren’t using @article.comments.new?
		#if we do so, there is an extra empty comment at the end of the list of comments. 
		#That is due to the fact that @article.comments.new has added the new Comment to the in-memory collection for the Article
	end

	def new
		@article = Article.new
	end

	def create
		@article = Article.new(article_params)

		#replaced with the above, after defining article_params method in the articles_helper.rb
		#@article = Article.new(params[:article])
			# this is the equivalent of
			#		@article = Article.new(
    	#			title: params[:article][:title],
    	#			body: params[:article][:body])

		@article.save

		flash.notice = "Article '#{@article.title}' Created!"
  	# <p class="flash"><%= flash.notice %></p> added in the app/views/layouts/application.html.erb in order to apply to all views

		redirect_to article_path(@article)
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy

		flash.notice = "Article '#{@article.title}' Deleted!"
  	# <p class="flash"><%= flash.notice %></p> added in the app/views/layouts/application.html.erb in order to apply to all views

		redirect_to articles_path
	end

	def edit
  	@article = Article.find(params[:id])
	end

	def update
	  @article = Article.find(params[:id])
  	@article.update(article_params)

  	flash.notice = "Article '#{@article.title}' Updated!"
  	# <p class="flash"><%= flash.notice %></p> added in the app/views/layouts/application.html.erb in order to apply to all views

  	redirect_to article_path(@article)
	end

	

end
