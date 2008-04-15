class AddListImageToProducts < ActiveRecord::Migration
  def self.up
  	add_column :products, :list_image, :string, :limit => 255
  	add_column :products, :list_image_width, :integer
  	add_column :products, :list_image_height, :integer
  end

  def self.down
  	remove_column :products, :list_image
  	remove_column :products, :list_image_width
  	remove_column :products, :list_image_height
  end
end