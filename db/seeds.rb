require 'faker'

User.create! do |user|
  user.name                  = 'matsu'
  user.password              = 'foo'
  user.password_confirmation = 'foo'
  user.email                 = 'mat27y@gmail.com'
end

User.create! do |user|
  user.name                  = 'kawa'
  user.password              = 'foo'
  user.password_confirmation = 'foo'
  user.email                 = 'mat27y@gmail.com'
end

