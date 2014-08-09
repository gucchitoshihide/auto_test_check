require "rails_helper"

RSpec.describe SkillProfilesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/skill_profiles").to route_to("skill_profiles#index")
    end

    it "routes to #new" do
      expect(:get => "/skill_profiles/new").to route_to("skill_profiles#new")
    end

    it "routes to #show" do
      expect(:get => "/skill_profiles/1").to route_to("skill_profiles#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/skill_profiles/1/edit").to route_to("skill_profiles#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/skill_profiles").to route_to("skill_profiles#create")
    end

    it "routes to #update" do
      expect(:put => "/skill_profiles/1").to route_to("skill_profiles#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/skill_profiles/1").to route_to("skill_profiles#destroy", :id => "1")
    end

  end
end
