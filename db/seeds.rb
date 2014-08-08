require 'faker'

WeekReport.new(user_id: 1, report_id: 1).save
week_report = WeekReport.find_by_user_id(1)
4.times do |idx|
  begin
    week_report.reports.create(title: Faker::Name.name, content: Faker::Lorem.sentence)
  rescue => e
    e.message
  end
end
