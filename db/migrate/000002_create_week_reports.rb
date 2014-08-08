class CreateWeekReports < ActiveRecord::Migration
  def change
    create_table :week_reports do |t|
      t.references :user, index: true
      t.references :report, index: true

      t.timestamps
    end
  end
end
