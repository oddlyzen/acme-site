class AddLargeImageToProducts < ActiveRecord::Migration
  def self.up
  	add_column :products, :large_image, :string, :limit => 100
  	add_column :products, :large_image_width, :integer
  	add_column :products, :large_image_height, :integer
  end

  def self.down
  	remove_column :products, :large_image
  end
end