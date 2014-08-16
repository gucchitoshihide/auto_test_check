class CreateArticleComments < ActiveRecord::Migration
  def change
    create_table :article_comments do |t|
      t.references :article, incex: true
      t.references :comment, index: true

      t.timestamps
    end
  end
end
