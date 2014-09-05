FactoryGirl.define do
  factory :article_prof_a, class: Article do
    title   'hello'
    content 'f' * 100
    skill_profile_id 1
  end

  factory :article_prof_b, class: Article do
    title   'world'
    content 'g' * 100
    skill_profile_id 2
  end

  factory :article_prof_c, class: Article do
    title   'good job'
    content 'h' * 100
    skill_profile_id 3
  end
end
