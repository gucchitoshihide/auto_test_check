module RelationWeekReport
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    has_many :reports, dependent: :destroy
  end
end
