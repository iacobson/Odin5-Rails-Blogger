module CommentsHelper
	def comment_params		#do not understand why not working as for articles_helper??? have to put this inside comment controller
  	params.require(:comment).permit(:author_name, :body)
	end
end
