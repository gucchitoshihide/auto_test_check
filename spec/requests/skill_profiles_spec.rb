require 'rails_helper'

RSpec.describe "SkillProfiles", :type => :request do
  describe "GET /skill_profiles" do
    it "works! (now write some real specs)" do
      get skill_profiles_path
      expect(response.status).to be(200)
    end
  end
end
