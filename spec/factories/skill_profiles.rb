FactoryGirl.define do
  factory :skill_profile, class: SkillProfile  do
    title   Settings.skill_profile.title.description
    article
  end
end
