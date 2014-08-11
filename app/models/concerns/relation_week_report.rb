module RelationWeekReport
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    has_many   :article_week_reports
    has_many   :articles, dependent: :destroy, through: :article_week_reports
  end
end
