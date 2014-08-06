module RelationWeekReport
  extend ActiveSupport::Concern

  included do
    belongs_to :week_report
  end
end
