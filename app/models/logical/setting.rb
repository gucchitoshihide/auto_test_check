class Setting
  class << self
    def password_update(user_id, password, password_confirmation)
      user = User.find_by_id(user_id)
      user.update({password: password, password_confirmation: password_confirmation})
    end

    def avatar_update(user_id, avatar)
      user        = User.find_by_id(user_id)
      user.avatar = avatar
      user.save!
    end
  end
end
