class WeekReport < ActiveRecord::Base
  belongs_to :user
  has_many :reports, dependent: :destroy

  scope :recent, ->(record=10) { order('created_at DESC').limit(record) }
end
