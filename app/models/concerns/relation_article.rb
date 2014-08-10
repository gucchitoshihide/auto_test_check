module RelationArticle
  extend ActiveSupport::Concern

  included do
    has_many   :article_week_reports
    has_many   :week_reports, dependent: :destroy, through: :article_week_reports
    belongs_to :skill_profile
    has_many   :article_comments
    has_many   :comments, through: :article_comments
  end
end
