module RelationArticle
  extend ActiveSupport::Concern

  included do
    belongs_to :week_report
    belongs_to :skill_profile
    has_many   :article_comments
    has_many   :comments, through: :article_comments
  end
end
