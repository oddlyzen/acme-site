class ProductSubcategory < ActiveRecord::Base
	
	belongs_to :product_category
  has_many :product_sections
	
	has_many :subcategory_products
	has_many :products, :through => :subcategory_products
	
	has_many :subcategory_accessories
	has_many :accessories, :through => :subcategory_accessories
	
	def image_size
		[width, height].compact.join('x')
	end
	
end