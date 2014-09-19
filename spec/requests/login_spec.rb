require 'rails_helper'

RSpec.describe 'Login', :type => :request do
  before do
    FactoryGirl.create(:user)
  end

  describe 'the response of GET /' do
    context 'when the user send request' do
      subject do
        get(new_login_path)
        response
      end

      context 'without session' do
        it_behaves_like 'a successful response', 'login.new'
        it { expect(subject.body).not_to include(t('las.errors.login_session.not_loggedin')) }
      end

      context 'with session' do
        before { login }
        it_behaves_like 'a successful redirection to', '/welcome'
      end
    end
  end

  describe 'the response of POST /login' do
    before do
      @params = USER_POST_LOGIN_PARAMS
      allow_any_instance_of(User).to receive(:authenticate).and_return(ASSIGNED_USER_MOCK)
    end
    let(:params) { @params }

    subject do
      post(login_path, params)
      response
    end

    context 'with valid params' do
      it_behaves_like 'a successful redirection to', '/welcome'
    end
  end

  describe 'the response of DELETE /login' do
    subject do
      delete(login_path)
      response
    end

    context 'with session' do
      before { login }
      it_behaves_like 'a successful redirection to', '/login/new'
    end

    context 'without session' do
      it_behaves_like 'a failure response status with', 403
    end
  end
end
