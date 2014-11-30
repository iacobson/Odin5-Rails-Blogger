module ArticlesHelper
	private
		def article_params
	  	params.require(:article).permit(:title, :body, :view_count, :tag_list, :image)
		end
end
