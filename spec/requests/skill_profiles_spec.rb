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
      get(skill_profile_path(params))
      response
    end

    context 'when the user send request' do
      context 'with valid params' do
        its(:status) { should eq 200 }
        it "rendered the show template" do
          expect(subject).to render_template(:show)
        end
      end

      context 'with invalid params' do
        let(:params) { USER_GET_SKILL_PROFILE_PARAMS.merge(id: 'invalid') }
        it_behaves_like 'a failure response status with', 404
      end
    end
  end

  describe 'GET /skill_profiles/:id/edit' do
    before do
      @params = USER_GET_SKILL_PROFILE_EDIT_PARAMS
      FactoryGirl.create(:user)
      login
    end
    let(:params) { @params }

    subject do
      get(edit_skill_profiles(params))
      response
    end

    context 'with valid params' do
      it_behaves_like 'a successful response', 'skill_profile.edit'
    end

    context 'with invalid params' do
      let(:params) { @params.merge(id: 'invalid') }
      it_behaves_like 'a failure response with', 403
    end
  end

  describe 'PUT /skill_profiles/:id/edit' do
    before do
      @params = USER_PUT_SKILL_PROFILE_EDIT_PARAMS
      FactoryGirl.create(:user)
      login
    end
    let(:params) { @params }

    subject do
      put(skill_profiles(params))
      response
    end

    context 'with valid params' do
      it_behaves_like 'a successful response', 'skill_profile.show'
    end
  end

  describe 'POST /skill_profiles/comment' do
    before do
      @params = USER_POST_COMMENT_PARAMS
      FactoryGirl.create(:user)
      login
    end
    let(:params) { @params }

    subject do
      post(comment_skill_profiles_path, params)
      response
    end

    context 'with valid params' do
      it_behaves_like 'a successful rendered', 'show'
      it { expect(request.flash[:alert]).to be_nil }
    end
  end

  describe 'PUT /skill_profiles/search' do
    before do
      FactoryGirl.create(:user)
      login
    end

    subject do
      put(search_skill_profiles_path, USER_PUT_SEARCH_PARAMS)
      response
    end

    context 'with params' do
      it_behaves_like 'a successful rendered', 'index'
    end
  end
end
