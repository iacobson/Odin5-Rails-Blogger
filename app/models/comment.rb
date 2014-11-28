class Comment < ActiveRecord::Base
  belongs_to :article	#relation one to many : article has many comments. Comment belongs to one article
end
