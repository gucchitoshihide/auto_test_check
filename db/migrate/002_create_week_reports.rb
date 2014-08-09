class CreateWeekReports < ActiveRecord::Migration
  def change
    create_table :week_reports do |t|
      t.references :user,    index: true
      t.references :article, index: true

      t.timestamps
    end
  end
end
