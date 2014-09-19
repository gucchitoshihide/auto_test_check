FactoryGirl.define do
  factory :user do
    name     Settings[:user][:name]
    email    Settings[:user][:email]
    password Settings[:user][:password]
  end
end
