require 'rails_helper'

# http://blog.lucascaton.com.br/index.php/2010/10/25/how-to-test-mailers-in-rails-3-with-rspec/

RSpec.describe 'ResetPasswords', :type => :request do
  describe 'GET /reset_password/new' do
    let(:mock_session) { double('session') }
    before do
      allow(mock_session).to receive(:[]).and_return(SESSION_ID)
    end

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
    before do
      FactoryGirl.create(:user)
    end
    context 'user input his email-address' do
      context 'when the input email-address is correct' do
        subject do
          post(reset_password_path, EMAIL)
          response
        end
        it { expect.to change { ActionMailer::Base.delivers.count }.by(1) } 
        it_behaves_like 'a successfully response', 'resend_password'
      end

      context 'when the email-address is not correct' do
        subject do
          poset(reset_password_path , NO_EXISTS_EMAIL)
          response
        end
      end
      it { expect.to change { ActionMailer::Base.delivers.count }.by(0) } 
      it_behaves_like 'a successfully response', 'resend_password'
    end
  end

  describe 'GET /reset_password/edit' do
    before do
      FactoryGirl.create(:user)
    end
    context 'user send request' do
      context 'with valid token and not expired' do
        before do
          allow_any_instance(User).to receive_message_chain(:reset_password, :rensend_at).and_return(SEND_DATE)
        end
        subject do
          get(edit_reset_password_path, RESET_TOKEN)
          response
        end
        it_behaves_like 'a successfully response', 'resend_password'
      end

      context 'with invalid token or expired' do
        where(:token, :spent_date_from_send_mail) do
          [
            [RESET_TOKEN,         FOUR_DATES_SPENT],
            [UNMATCH_RESET_TOKEN, THREE_DATES_SPENT],
            [UNMATCH_RESET_TOKEN, FOUR_DATES_SPENT]
          ]
        end
        with_them do
          before do
            allow_any_instance(User).to receive_message_chain(:reset_password, :rensend_at).and_return(spent_date_from_send_mail)
          end
          subject do
            get(edit_reset_password_path, RESET_TOKEN)
            response
          end
          it_behaves_like 'a successfully rendered', 'announce'
        end
      end
    end
  end

  describe 'PUT /edit_reset_password' do
    context 'user send request' do
      context 'when params are valid' do
        subject do
          put(edit_reset_password_path, user: {password: CHANGE_PASSWORD, password_confirmation: CHANGE_PASSWORD_CONFIRMATION})
          response
        end
        it_behaves_like 'a successfully rendered', 'finish'
      end

      context 'when params are invalid' do
        where(:password, :password_confirmation) do
          [
            [CHANGE_PASSWORD,         UNMATCH_CHANGE_PASSWORD_CONFIRMATION],
            [UNMATCH_CHANGE_PASSWORD, CHANGE_PASSWORD_CONFIRMATION],
            [UNMATCH_CHANGE_PASSWORD, UNMATCH_CHANGE_PASSWORD_CONFIRMATION]
          ]
        end
        with_them do
          subject do
            put(edit_reset_password_path, user: {password: password, password_confirmation: password_confirmation})
            response
          end
          it_behaves_like 'a successfully rendered', 'announce'
        end
      end
    end
  end

  describe 'GET request' do
    context 'from unexpected referer' do
      where(:path) do
        [
          [edit_reset_password_path],
          [announce_reset_password_path],
          [finish_reset_password_path]
        ]
      end
      with_them do
        subject do
          get(LOCAL_HOST_ROUTE)
          get(path)
          response
        end
      end
      it_behaves_like 'a prohibited request and return 403'
    end
  end
end
