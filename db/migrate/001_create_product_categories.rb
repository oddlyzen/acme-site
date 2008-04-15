class CreateProductCategories < ActiveRecord::Migration
  def self.up
    create_table :product_categories do |t|
    	t.column :position, :integer, :null => false
    	t.column :category, :string, :null => false
    	t.column :active, :boolean, :null => false
    end
  end

  def self.down
    drop_table :product_categories
  end
end