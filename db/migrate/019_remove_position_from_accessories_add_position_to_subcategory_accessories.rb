class RemovePositionFromAccessoriesAddPositionToSubcategoryAccessories < ActiveRecord::Migration
  def self.up
  	remove_column :accessories, :position
  	add_column :subcategory_accessories, :position, :integer
  	add_column :product_accessories, :position, :integer
  end

  def self.down
  	add_column :accessories, :position, :integer
  	remove_column :subcategory_accessories, :position
  	remove_column :product_accessories, :position
  end
end