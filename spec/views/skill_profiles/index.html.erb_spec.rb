require 'rails_helper'

RSpec.describe "skill_profiles/index", :type => :view do
  before(:each) do
    assign(:skill_profiles, [
      SkillProfile.create!(
        :profile => nil,
        :user => nil
      ),
      SkillProfile.create!(
        :profile => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of skill_profiles" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
