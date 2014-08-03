json.array!(@week_reports) do |week_report|
  json.extract! week_report, :id, :user_id, :report_id
  json.url week_report_url(week_report, format: :json)
end
