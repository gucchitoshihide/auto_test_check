require 'rails_helper'

RSpec.describe 'SkillProfiles', :type => :request do
  before { FactoryGirl.create(:user) }

  describe 'GET /skill_profiles' do
    context 'when the user send request' do
      subject do
        get(skill_profiles_path)
        response
      end

      context 'with session' do
        before { login }
        it_behaves_like 'a successful response', 'skill_profile.index'
      end

      context 'without session' do
        it_behaves_like 'a successful redirection to', '/login/new'
      end
    end
  end
end
