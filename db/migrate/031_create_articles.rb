class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.text :description
      t.string :keywords
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
