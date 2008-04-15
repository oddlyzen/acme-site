class AddShortDescAndDimensionsAndQtyPerPkgToProducts < ActiveRecord::Migration
  def self.up
  	add_column :products, :short_desc, :string, :limit => 255
  	add_column :products, :dimensions, :string, :limit => 50
  	add_column :products, :qty_per_pkg, :string, :limit => 50
  end

  def self.down
  	remove_column :products, :short_desc
  	remove_column :products, :dimensions
  	remove_column :products, :qty_per_pkg
  end
end