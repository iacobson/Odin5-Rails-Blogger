class CommentsController < ApplicationController
	include CommentsHelper
	# params.require(:comment).permit(:author_name, :body) is defined in app/helpers/comments_helper.rb

	before_filter :require_login, except: [:create]	#just in case we want to implement intex and destroy (just for authors)

	def create
		@comment = Comment.new(comment_params)
		@comment.article_id = params[:article_id]
		@comment.save

		#the alternative from Rails tutorial is usign FIND
		#@article = Article.find(params[:article_id])
		#@comment = @article.comments.create(comments_params)		

		redirect_to article_path(@comment.article)		#we need to show the whole article page, not just the comment
	end


end
