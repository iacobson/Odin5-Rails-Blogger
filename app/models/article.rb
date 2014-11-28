class Article < ActiveRecord::Base
	has_many :comments	#relation one to many : article has many comments. Comment belongs to one article
	has_many :taggings
	has_many :tags, through: :taggings
	# Many-to-many relationships are tricky because we’re using an SQL database. 
	# If an Article "has many" tags, then we would put the foreign key article_id inside the tags table - so then a Tag would "belong to" an Article. 
	# But a tag can connect to many articles, not just one. 
	# We can’t model this relationship with just the articles and tags tables.
	
	# Most of the time this isn’t the best way to really model the relationship. 
	# The connection between the two models usually has value of its own, so we should promote it to a real model. 
	# For our purposes, we’ll introduce a model named "Tagging" which is the connection between Articles and Tags. 
	# The relationships will setup like this:
	# 	An Article has_many Taggings
	# 	A Tag has_many Taggings
	# 	A Tagging belongs_to an Article and belongs_to a Tag

	# Now if we have an object like article we can just ask for article.tags or, 
	# conversely, if we have an object named tag we can ask for tag.articles.

	has_attached_file :image	
	# This has_attached_file method is part of the paperclip library. 
	# With that declaration, paperclip will understand that this model should accept a file attachment 
	# and that there are fields to store information about that file 
	# which start with image_ in this model’s database table.
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]


	def tag_list		#why we define the tag list here???
  		self.tags.collect do |tag|
    		tag.name
  		end.join(", ")		#end.join ?!?! WOW !!!
	end

	def tag_list=(tags_string)
		tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
  	new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
  		# go through each of those tag_names and find or create a tag with that name. Rails has a built in method to do just that (find_or_create_by)
  	self.tags = new_or_found_tags
	end

end
