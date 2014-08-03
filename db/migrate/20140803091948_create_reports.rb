class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :title, null: false, unique: true
      t.text :content

      t.timestamps
    end
  end
end
