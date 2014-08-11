module RelationComment
  extend ActiveSupport::Concern

  included do
    has_many :users
    has_many :article_comments
    has_many :articles, through: :article_comments
  end
end
