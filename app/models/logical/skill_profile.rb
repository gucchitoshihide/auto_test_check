class SkillProfile < ActiveRecord::Base
  belongs_to :profile
  belongs_to :user

  scope :latest, ->(list_num = Settings[:front][:skill_profile][:index][:table][:list_num]) {
    Article.order('created_at DESC').limit(list_num)
  }

end
