class AddMigrationsToCatsSubcatsProducts < ActiveRecord::Migration
  def self.up
  	add_column :product_categories, :permalink, :string, :limit => 50
  	add_column :product_subcategories, :permalink, :string, :limit => 50
  	add_column :products, :permalink, :string, :limit => 50
  end

  def self.down
  	remove_column :product_categories, :permalink
  	remove_column :product_subcategories, :permalink
  	remove_column :products, :permalink
  end
end