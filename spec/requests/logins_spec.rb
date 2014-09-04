require 'rails_helper'

RSpec.describe 'Logins', :type => :request do
  let(:mock_session) { double('session') }
  before do
    allow(mock_session).to receive(:[]).with(:id).and_return(SESSION_ID)
    FactoryGirl.create(:user)
  end

  describe 'the response of GET /' do
    context 'when the user send request' do
      where(:session, :cookie) do
        [
          [nil, nil],
          [mock_session, nil]
          # append if add cookie function
        ]
      end

      with_them do
        before do
          login if session
        end
        subject do
          get(logins_path)
          response
        end
        it_behaves_like 'a successfully response', 'logins'
        it { expect(subject.body).not_to include(t('las.logins.message.alert.not_loggedin')) }
      end
    end
  end

  describe 'the response of POST /' do
    context 'when the params is valid' do
      before do
        allow_any_instance_of(User).to receive(:authenticate).and_return(ASSIGNED_USER_MOCK)
      end

      subject do
        post(logins_path, POST_LOGIN_PARAMS)
        response
      end
      it_behaves_like 'a successfully response redirection (302)', 'home'
    end

    context 'when the params is invalid' do
      where(:name, :email) do
        [
          [USER_NAME, EMAIL],
          [USER_NAME, nil],
          [nil      , EMAIL],
          [nil      , nil],
        ]
      end

      with_them do
        subject do
          post(logins_path, user: {name: name, email: email})
          response
        end
        it_behaves_like 'a no redirection response', 'logins', 'home'
      end

    end
  end

  describe 'the response of POST /' do
    context 'when the params is valid' do
      before do
        allow_any_instance_of(User).to receive(:authenticate).and_return(ASSIGNED_USER_MOCK)
      end
      subject do
        post(logins_path, POST_LOGIN_PARAMS)
        response
      end
      it_behaves_like 'a successfully response redirection (302)', 'home'
    end

    context 'when the params is invalid' do
      where(:name, :email) do
        [
          [USER_NAME, EMAIL],
          [USER_NAME, nil],
          [nil , EMAIL],
          [nil , nil],
        ]
      end
      with_them do
        subject do
          post(logins_path, user: {name: name, email: email})
          response
        end
        it_behaves_like 'a no redirection response', 'logins', 'home'
      end
    end

  end
end
