class WeekReport < ActiveRecord::Base
  belongs_to :user
  has_many :reports, dependent: :destroy

  scope :latest, ->(list_num = Settings[:front][:week_reports][:index][:table][:list_num]) {
    order('created_at DESC').limit(list_num).map { |recent| Report.find_by(id: recent.report_id) }
  }
end
