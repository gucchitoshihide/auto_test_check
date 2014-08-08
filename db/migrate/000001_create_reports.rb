class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :week_report
      t.string     :title, null: false, unique: true
      t.text       :content

      t.timestamps
    end
  end
end
