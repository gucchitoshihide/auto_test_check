module RelationArticle
  extend ActiveSupport::Concern

  included do
    belongs_to :skill_profile, dependent: :destroy
    has_many   :article_comments
    has_many   :comments, dependent: :destroy, through: :article_comments
  end
end
