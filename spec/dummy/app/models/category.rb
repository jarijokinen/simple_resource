class Category < ActiveRecord::Base
  has_many :posts
  attr_accessible :description, :name
end
