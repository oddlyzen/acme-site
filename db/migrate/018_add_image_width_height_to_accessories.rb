class AddImageWidthHeightToAccessories < ActiveRecord::Migration
  def self.up
  	add_column :accessories, :image, :string, :limit => 255
  	add_column :accessories, :width, :integer
  	add_column :accessories, :height, :integer
  end

  def self.down
  	remove_column :accessories, :image
  	remove_column :accessories, :width
  	remove_column :accessories, :height
  end
end