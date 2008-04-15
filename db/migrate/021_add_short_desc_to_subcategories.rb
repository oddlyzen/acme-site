class AddShortDescToSubcategories < ActiveRecord::Migration
  def self.up
    add_column :product_subcategories, :short_desc, :string
  end

  def self.down
    remove_column :product_categories, :short_desc
  end
end