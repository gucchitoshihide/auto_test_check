# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    name  Settings[:admin][:fixture][:name]
    email Settings[:admin][:fixture][:email]
    password Settings[:admin][:fixture][:password]
  end
end
