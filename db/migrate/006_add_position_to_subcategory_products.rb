class AddPositionToSubcategoryProducts < ActiveRecord::Migration
  def self.up
  	add_column :subcategory_products, :position, :integer
  end

  def self.down
  	remove_column :subcategory_products, :position
  end
end