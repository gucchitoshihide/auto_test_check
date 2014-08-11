module RelationArticleWeekReport
  extend ActiveSupport::Concern

  included do
    belongs_to :article
    belongs_to :week_report
  end
end
