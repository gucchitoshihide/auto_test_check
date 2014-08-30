require 'rails_helper'

RSpec.describe 'ResetPasswords', :type => :request do
  let(:mock_session) { double('session') }
  before do
    allow(mock_session).to receive(:[]).and_return(SESSION_ID)
  end

  describe 'GET /reset_password/new' do
    context 'user send request' do
      context 'when with no session' do
        where(:session, :cookie) do
          [
            [nil, nil]
            # append cookie object when put the function
          ]
        end
        with_them do
          subject do
            get(new_reset_password_path)
            response
          end
          it_behaves_like 'a successfully response', 'reset_password'
        end
      end

      context 'when with session' do
        where(:session, :cookie) do
          [
            [nil, nil]
            # append cookie object when put the function
          ]
        end
        with_them do
          subject do
            get(new_reset_password_path)
            response
          end
          it_behaves_like 'a successfully redirection response(302)', 'home'
        end
      end
    end
  end

  # Given no sessions
  describe 'POST /reset_password' do
    context 'user input his email-address' do
      context 'when the email-address exists' do
      end

      context 'when the email-address not exists' do
      end
    end
  end

  describe 'GET /reset_password/edit' do
    context 'user send request' do
      context 'when token is not expired and enable' do
      end

      context 'when token is expired' do
      end

      context 'when token is unable because of already registered' do
      end
    end
  end

  describe 'PUT /reset_password' do
    context 'user send request' do
      context 'when params are valid' do
      end

      context 'when params are invalid' do
      end
    end
  end

end
