class AddShowCartToProducts < ActiveRecord::Migration
  def self.up
    add_column :products, :show_cart, :boolean
  end

  def self.down
    remove_clumn :products, :show_cart
  end
end