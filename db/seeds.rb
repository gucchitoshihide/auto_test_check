require 'faker'

User.create! do |user|
  user.name                  = 'matsu'
  user.password              = 'foo'
  user.password_confirmation = 'foo'
  user.email                 = 'matsu@matsu.com'
end
