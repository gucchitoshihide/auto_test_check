class Setting
  class << self
    # Refactorable?
    # def update_setting(column, user_id, params)
    #   user = User.find_by_id(user_id)
    #   user.send(#{column}) = params
    #   user.save!
    # end
    def password_update(user_id, password, password_confirmation)
      user = User.find_by_id(user_id)
      user.update({password: password, password_confirmation: password_confirmation})
    end

    def avatar_update(user_id, avatar)
      user        = User.find_by_id(user_id)
      user.avatar = avatar
      user.save!
    end

    def write_style_update(user_id, write_style)
      user             = User.find_by_id(user_id)
      user.write_style = write_style
      user.save!
    end
  end
end
