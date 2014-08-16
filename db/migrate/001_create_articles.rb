class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :skill_profile, index: true
      t.string     :title, null: false, unique: true
      t.text       :content

      t.timestamps
    end
  end
end
