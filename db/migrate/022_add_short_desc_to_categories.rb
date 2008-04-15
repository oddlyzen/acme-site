class AddShortDescToCategories < ActiveRecord::Migration
  def self.up
    add_column :product_categories, :short_desc, :string
  end

  def self.down
    remove_column :produt_caegories, :short_desc
  end
end