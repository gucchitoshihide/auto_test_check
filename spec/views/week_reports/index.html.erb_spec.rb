require 'rails_helper'

RSpec.describe "week_reports/index", :type => :view do
  before(:each) do
    assign(:week_reports, [
      WeekReport.create!(
        :user => nil,
        :report => nil
      ),
      WeekReport.create!(
        :user => nil,
        :report => nil
      )
    ])
  end

  it "renders a list of week_reports" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
