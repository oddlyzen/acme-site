class CreateAccessories < ActiveRecord::Migration
  def self.up
    create_table :accessories do |t|
    	t.column :position, :integer, :null => false
    	t.column :accessory, :string, :null => false
    	t.column :price, :decimal, :precision => 8, :sacle => 2
    end
  end

  def self.down
    drop_table :accessories
  end
end