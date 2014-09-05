FactoryGirl.define do
  factory :profile_a, class: SkillProfile do
    title   'hello'
    user_id 1
  end

  factory :profile_b, class: SkillProfile do
    title   'hello'
    user_id 2
  end

  factory :profile_c, class: SkillProfile do
    title   'hello'
    user_id 3
  end

end
