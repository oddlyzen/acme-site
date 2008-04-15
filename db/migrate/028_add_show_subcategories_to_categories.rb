class AddShowSubcategoriesToCategories < ActiveRecord::Migration
  def self.up
    add_column :product_categories, :show_subcategories, :boolean
  end

  def self.down
    remove_column :product_categories, :show_subcategories
  end
end