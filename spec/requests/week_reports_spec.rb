require 'rails_helper'

RSpec.describe "WeekReports", :type => :request do
  describe "GET /week_reports" do
    it "works! (now write some real specs)" do
      get week_reports_path
      expect(response.status).to be(200)
    end
  end
end
