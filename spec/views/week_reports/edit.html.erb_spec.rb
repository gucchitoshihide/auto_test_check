require 'rails_helper'

RSpec.describe "week_reports/edit", :type => :view do
  before(:each) do
    @week_report = assign(:week_report, WeekReport.create!(
      :user => nil,
      :report => nil
    ))
  end

  it "renders the edit week_report form" do
    render

    assert_select "form[action=?][method=?]", week_report_path(@week_report), "post" do

      assert_select "input#week_report_user_id[name=?]", "week_report[user_id]"

      assert_select "input#week_report_report_id[name=?]", "week_report[report_id]"
    end
  end
end
