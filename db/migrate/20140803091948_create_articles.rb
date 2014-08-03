class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title, null: false, unique: true
      t.text :content

      t.timestamps
    end
  end
end
