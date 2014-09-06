class Avatar
  class << self
    def update(user_id, avatar)
      user        = User.find_by_id(user_id)
      user.avatar = avatar
      user.save!
    end
  end
end
