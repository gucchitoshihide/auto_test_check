class WeekReport < ActiveRecord::Base
  belongs_to :user
  has_many :reports, dependent: :destroy

  scope :recent, ->(record = Settings[:front][:week_reports][:index][:table][:list_num]) {
    order('created_at DESC').limit(record)
  }
end
