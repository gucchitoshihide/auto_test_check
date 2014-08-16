module RelationComment
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    has_many   :article_comments
    has_many   :articles, through: :article_comments
  end
end
