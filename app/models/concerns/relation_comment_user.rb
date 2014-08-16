module RelationCommentUser
  extend ActiveSupport::Concern

  included do
    belongs_to :comment
    belongs_to :user
  end
end
