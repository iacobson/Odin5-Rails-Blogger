class TagsController < ApplicationController

	def show
	  @tag = Tag.find(params[:id])
	end

	def index
		@tags = Tag.all
	end

	def destroy
		@tag = Tag.find(params[:id])
		@tag.destroy

		flash.notice = "Tag '#{@tag.name}' Deleted!"
  	# <p class="flash"><%= flash.notice %></p> added in the app/views/layouts/application.html.erb in order to apply to all views

		redirect_to tags_path
	end
	
end
