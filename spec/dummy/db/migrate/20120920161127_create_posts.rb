class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.references :category
      t.references :language
      t.string :title
      t.text :content

      t.timestamps
    end
    add_index :posts, :category_id
    add_index :posts, :language_id
  end
end
