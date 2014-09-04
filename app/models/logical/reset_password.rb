class ResetPassword < ActiveRecord::Base
  include RelationResetPassword

  class << self
    def reset_token(token)
      reset_password = find_by_token(token)
      reset_password.token = nil
      reset_password.save!
    end
  end
end
