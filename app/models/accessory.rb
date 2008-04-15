class Accessory < ActiveRecord::Base
	
	has_many :subcategory_accessories
	has_many :product_subcategories, :through => :subcategory_accessories
	
	has_many :subcategory_products
	has_many :products, :through => :subcategory_products
	
	def image_size
		[width, height].compact.join('x')
	end
	
end