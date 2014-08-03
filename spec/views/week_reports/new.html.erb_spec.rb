require 'rails_helper'

RSpec.describe "week_reports/new", :type => :view do
  before(:each) do
    assign(:week_report, WeekReport.new(
      :user => nil,
      :report => nil
    ))
  end

  it "renders new week_report form" do
    render

    assert_select "form[action=?][method=?]", week_reports_path, "post" do

      assert_select "input#week_report_user_id[name=?]", "week_report[user_id]"

      assert_select "input#week_report_report_id[name=?]", "week_report[report_id]"
    end
  end
end
