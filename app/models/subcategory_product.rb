class SubcategoryProduct < ActiveRecord::Base
	
	belongs_to :product_subcategory
	belongs_to :product
	
end