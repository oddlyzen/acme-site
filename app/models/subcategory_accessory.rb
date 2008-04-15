class SubcategoryAccessory < ActiveRecord::Base
	
	belongs_to :product_subcategory
	belongs_to :accessory
	
end