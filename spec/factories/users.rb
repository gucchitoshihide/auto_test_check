FactoryGirl.define do
  factory :user, class: User do
    name     Settings[:user][:name]
    email    Settings[:user][:email]
    password Settings[:user][:password]
    skill_profile
  end

  factory :skill_profile, class: SkillProfile  do
    title   "Yusuke Matsukawa's skill"
    article
  end

  factory :article, class: Article do
    title   "Yusuke Matsukawa's skill"
    content '# I know\n* Ruby\n* Java\n* Python'
  end
end
