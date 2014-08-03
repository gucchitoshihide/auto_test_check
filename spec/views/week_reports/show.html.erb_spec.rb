require 'rails_helper'

RSpec.describe "week_reports/show", :type => :view do
  before(:each) do
    @week_report = assign(:week_report, WeekReport.create!(
      :user => nil,
      :report => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
