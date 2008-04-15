class Product < ActiveRecord::Base
	
	has_many :subcategory_accessories
	has_many :accessories, :through => :subcategory_accessories
	
	has_many :subcategory_products
	has_many :product_subcategories, :through => :subcategory_products
  
  has_many :section_products
  has_many :product_sections, :through => :section_products
	
	def list_image_size
		[list_image_width, list_image_height].compact.join('x')
	end
	
	def large_image_size
		[large_image_width, large_image_height].compact.join('x')
	end
	
end