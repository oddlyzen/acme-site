class CreateUsefulLinks < ActiveRecord::Migration
  def self.up
    create_table :links do |t|
      t.column :position, :integer
      t.column :url, :string
      t.column :title, :string
      t.column :desc, :text
      t.column :logo_image, :string
      t.column :logo_width, :integer
      t.column :logo_height, :integer
    end
  end

  def self.down
    drop_table :links
  end
end