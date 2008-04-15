class SectionProduct < ActiveRecord::Base
  belongs_to :product_section
  belongs_to :product
end