module RelationComment
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    belongs_to :article, dependent: :destroy
  end
end
