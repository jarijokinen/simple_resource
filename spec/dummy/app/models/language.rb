class Language < ActiveRecord::Base
  attr_accessible :name
  has_many :posts

  validates_presence_of :name
end
