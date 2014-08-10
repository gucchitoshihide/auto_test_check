class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.references :week_report,   null: true
      t.references :skill_profile, null: true
      t.references :comment,       null: true
      t.string     :title, null: false, unique: true
      t.text       :content

      t.timestamps
    end
  end
end
