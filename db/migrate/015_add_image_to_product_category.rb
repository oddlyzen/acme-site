class AddImageToProductCategory < ActiveRecord::Migration
  def self.up
  	add_column :product_categories, :image, :string, :limit => 255
  	add_column :product_categories, :image_width, :integer
  	add_column :product_categories, :image_height, :integer
  	add_column :product_categories, :image_alt, :string, :limit => 50
  end

  def self.down
  	remove_column :product_categories, :image
  	remove_column :product_categories, :image_width
  	remove_column :product_categories, :image_height
  	remove_column :product_categories, :image_alt
  end
end