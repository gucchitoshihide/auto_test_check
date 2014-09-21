FactoryGirl.define do
  factory :user, class: User do
    name     Settings.user.name
    email    Settings.user.email
    password Settings.user.password
    skill_profile
  end

  factory :skill_profile, class: SkillProfile  do
    title   Settings.skill_profile.title.description
    article
  end

  factory :article, class: Article do
    title   Settings.article.title.description
    content Settings.article.content.description
  end
end
