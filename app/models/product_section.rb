class ProductSection < ActiveRecord::Base
  
  belongs_to :product_subcategory
  
  has_many :section_products
  has_many :products, :through => :section_products
  
  def image_size
    [width, height].compact.join('x')
  end
  
end