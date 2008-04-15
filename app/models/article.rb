class Article < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :body, :description
  validates_uniqueness_of :title
  
end
