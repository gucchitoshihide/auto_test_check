module RelationResetPassword
  extend ActiveSupport::Concern

  included do
    has_one  :user
  end
end
