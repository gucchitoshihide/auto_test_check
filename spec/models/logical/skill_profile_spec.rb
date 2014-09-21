require 'rails_helper'

RSpec.describe SkillProfile, :type => :model do
  before { FactoryGirl.create(:skill_profile) }

  describe '.latest' do
    # if over number limit of show list, create test flow
    before do
      @latest_check  = []
      @skill_profile = SkillProfile.order('created_at DESC').limit(Settings.skill_profile.show_list.max_num)
    end

    subject { SkillProfile.latest }
    it { expect(subject[0]).to be_a SkillProfile }
    it do
      subject.each_with_index do |record, index|
        @latest_check << @skill_profile[index] == record
      end
      expect(@latest_check).not_to include(false)
    end
  end
end
