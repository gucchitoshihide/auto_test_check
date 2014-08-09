require 'rails_helper'

RSpec.describe "skill_profiles/show", :type => :view do
  before(:each) do
    @skill_profile = assign(:skill_profile, SkillProfile.create!(
      :profile => nil,
      :user => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
