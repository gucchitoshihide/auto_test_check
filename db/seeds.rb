require 'faker'

(1..5).each do |idx|
  WeekReport.new(user_id: idx, article_id: idx).save
  Article.new(week_report_id: idx, comment_id: idx, title: Faker::Name.name, content: Faker::Lorem.sentence).save
  Comment.new(article_id: idx, content: Faker::Lorem.sentence[0..5]).save
end
(6..10).each do |idx|
  SkillProfile.new(user_id: idx, article_id: idx).save
  Article.new(skill_profile_id: idx, title: Faker::Name.name, content: Faker::Lorem.sentence).save
end
