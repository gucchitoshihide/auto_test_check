require 'rails_helper'
require 'search'

RSpec.describe SkillProfile, :type => :model do
  before { FactoryGirl.create(:user) }

  describe '.rewrite' do
    before do
      @params = MODEL_PUT_SKILL_PROFILE_EDIT_PARAMS
      @current_user = User.find_by(id: USER_ID)
    end
    let(:params) { @params }

    subject { SkillProfile.rewrite(params, @current_user) }

    context 'with valid params' do
      it { expect { subject }.not_to raise_error }
    end
  end

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

  describe '.search' do
    before do
      @params = MODEL_PUT_SEARCH_PARAMS
      found_records     = Search::Word.reg_exp(Article.where.not(skill_profile_id: nil), :content, @params[SEARCH_KEY])
      @expected_profile = found_records.map { |record| record.skill_profile }
      FactoryGirl.create(:article)
    end
    let(:params) { @params }

    subject { SkillProfile.search(params) }

    context 'with match word' do
      it { expect(subject).to eq @expected_profile }
    end

    context 'with not match word' do
      let(:params) { @params.merge(SEARCH_KEY => 'not match word') }
      it { expect(subject).to be_empty }
    end
  end
end
