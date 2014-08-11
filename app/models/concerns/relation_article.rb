module RelationArticle
  extend ActiveSupport::Concern

  included do
    has_many   :article_week_reports
    has_many   :week_reports, dependent: :destroy, through: :article_week_reports
    has_many   :article_skill_profiles
    has_many   :skill_profiles, dependent: :destroy, through: :article_skill_profiles
    has_many   :article_comments
    has_many   :comments, dependent: :destroy, through: :article_comments
  end
end
