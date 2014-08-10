module RelationArticleComment
  extend ActiveSupport::Concern

  included do
    belongs_to :article
    belongs_to :comment
  end
end
