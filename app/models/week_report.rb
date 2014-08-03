class WeekReport < ActiveRecord::Base
  belongs_to :user
  has_many :reports, dependent: :destroy
end
