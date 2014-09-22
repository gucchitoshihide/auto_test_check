FactoryGirl.define do
  factory :user, class: User do
    name     Settings.user.name
    email    Settings.user.email
    password Settings.user.password
    skill_profile
  end
end
