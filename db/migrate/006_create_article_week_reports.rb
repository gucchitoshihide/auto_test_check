class CreateArticleWeekReports < ActiveRecord::Migration
  def change
    create_table :article_week_reports do |t|
      t.references :article,     index: true
      t.references :week_report, index: true

      t.timestamps
    end
  end
end
