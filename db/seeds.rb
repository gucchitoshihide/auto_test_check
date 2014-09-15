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

Admin.create! do |admin|
  admin.name     = 'blah'
  admin.password = 'blah'
  admin.email    = 'dummy@example.com'
end
