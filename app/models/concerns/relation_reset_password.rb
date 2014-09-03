module RelationResetPassword
  extend ActiveSupport::Concern

  included do
    has_many :users
  end
end
