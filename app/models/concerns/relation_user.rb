module RelationUser
  extend ActiveSupport::Concern

  included do
    has_one  :skill_profile
    has_many :comment_users
    has_many :comments, through: :comment_users
  end
end
