class CreateMenuComments < ActiveRecord::Migration
  def self.up
    create_table :menu_comments do |t|
      t.references :parent
      t.string :title
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :menu_comments
  end
end
