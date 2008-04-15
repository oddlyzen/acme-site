class ProductCategory < ActiveRecord::Base
	
	has_many :product_subcategories
	
	def image_size
		[image_width, image_height].compact.join('x')
	end
end