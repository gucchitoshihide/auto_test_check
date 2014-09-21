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

  # below, session is gien
  describe 'GET /skill_profiles/:id' do
    before do
      @params = USER_GET_SKILL_PROFILE_PARAMS
      FactoryGirl.create(:user)
      login
    end
    let(:params) { USER_GET_SKILL_PROFILE_PARAMS }

    subject do
      get(skill_profile_path, params)
      response
    end

    context 'when the user send request' do
      context 'with valid params' do
        it_behaves_like 'a successful response', 'skill_profile.show'
      end

      context 'with invalid id' do
        let(:params) { USER_GET_SKILL_PROFILE_PARAMS.merge(id: 'invalid') }
        it_behaves_like 'a failure response status with', 404
      end
    end
  end
end
