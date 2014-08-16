module RelationWeekReport
  extend ActiveSupport::Concern

  included do
    has_many :users
    has_many :article_week_reports
    has_many :articles, dependent: :destroy, through: :article_week_reports
  end
end
