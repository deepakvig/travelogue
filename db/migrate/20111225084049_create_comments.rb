class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :article
      t.text :content
      t.string :screen_name
      t.string :email

      t.timestamps
    end
    add_index :comments, :article_id
  end
end
