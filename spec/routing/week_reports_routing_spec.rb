require "rails_helper"

RSpec.describe WeekReportsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/week_reports").to route_to("week_reports#index")
    end

    it "routes to #new" do
      expect(:get => "/week_reports/new").to route_to("week_reports#new")
    end

    it "routes to #show" do
      expect(:get => "/week_reports/1").to route_to("week_reports#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/week_reports/1/edit").to route_to("week_reports#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/week_reports").to route_to("week_reports#create")
    end

    it "routes to #update" do
      expect(:put => "/week_reports/1").to route_to("week_reports#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/week_reports/1").to route_to("week_reports#destroy", :id => "1")
    end

  end
end
