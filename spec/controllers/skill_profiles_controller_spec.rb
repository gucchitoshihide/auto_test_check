require 'rails_helper'

RSpec.describe SkillProfilesController, :type => :controller do
  before { FactoryGirl.create(:user) }

  describe '#index' do
    subject do
      get(:index)
      response
    end

    context 'with session' do
      before do
        login_at(:index)
        @size_skill_profile = SkillProfile.all.size
      end
      it { expect(assigns(:profiles)).not_to be_nil }
      it { expect(assigns(:profiles)[0]).to be_a(SkillProfile)}
    end

    context 'without session' do
      it { expect(assigns(:profiles)).to be_nil }
    end
  end

  describe '#show' do
    before do
      @params = USER_GET_SKILL_PROFILE_PARAMS
      FactoryGirl.create(:user)
      login_at(:index)
      get(:show, params)
    end
    let(:params) { @params }

    context 'with valid params' do
      it { expect(assigns(:article)).not_to be_nil }
    end

    context 'with invalid params' do
      let(:params) { USER_GET_SKILL_PROFILE_PARAMS.merge(id: 'invalid') }
      it { expect(assigns(:article)).to be_nil }
    end
  end

  describe '#comment' do
    before do
      @comment_params = USER_POST_COMMENT_PARAMS
      login_at(:index)
    end

    context 'with valid params' do
      before { post(:comment, USER_POST_COMMENT_PARAMS) }
      it { expect(assigns(:article)).not_to be_nil }
      it { expect(flash).to be_empty }
    end

    context 'with invalid params' do
      context 'with blank comment' do
        before do
          params = { article_id: ARTICLE_ID, comment: { content: '' } }
          post(:comment, params)
        end
        it { expect(assigns(:article)).to be_nil }
        it { expect(flash).not_to be_empty }
      end

      context 'with invalid article_id' do
        before do
          params = { article_id: 'invalid', comment: { content: NEW_COMMENT } }
          post(:comment, params)
        end
        it { expect(assigns(:article)).to be_nil }
        it { expect(flash).to be_empty }
      end
    end
  end
end
