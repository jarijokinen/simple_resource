class Post < ActiveRecord::Base
  belongs_to :category
  belongs_to :language
  attr_accessible :content, :title
end
