FactoryGirl.define do
  factory :user do
    name     Settings[:user][:name]
    email    Settings[:user][:email]
    password Settings[:user][:password]
  end

  factory :user_a do
    name     'matsu'
    email    'matsu@matsu.jp'
    password 'foo'
    password_confirmation 'foo'
  end

  factory :user_b do
    name     'take'
    email    'take@take.jp'
    password 'foo'
    password_confirmation 'foo'
  end

  factory :user_c do
    name     'ume'
    email    'ume@ume.jp'
    password 'foo'
    password_confirmation 'foo'
  end
end
