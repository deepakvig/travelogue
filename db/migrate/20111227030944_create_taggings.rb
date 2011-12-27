class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :article
      t.references :tag

      t.timestamps
    end
    add_index :taggings, :article_id
    add_index :taggings, :tag_id
  end
end
