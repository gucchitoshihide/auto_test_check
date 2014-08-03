class WeekReport < ActiveRecord::Base
  belongs_to :user
  has_many :report, dependent: :destroy
end
