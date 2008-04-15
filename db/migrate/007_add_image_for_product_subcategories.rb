class AddImageForProductSubcategories < ActiveRecord::Migration
  def self.up
  	add_column :product_subcategories, :image, :string
  	add_column :product_subcategories, :width, :integer
  	add_column :product_subcategories, :height, :integer
  end

  def self.down
  	remove_column :product_subcategories, :image
  	remove_column :product_subcategories, :width
  	remove_column :product_subcategories, :height
  end
end