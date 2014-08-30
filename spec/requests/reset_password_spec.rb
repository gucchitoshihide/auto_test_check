require 'rails_helper'

# http://blog.lucascaton.com.br/index.php/2010/10/25/how-to-test-mailers-in-rails-3-with-rspec/

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
          get(edit_reset_password, RESET_TOKEN)
          response
        end
        it_behaves_like 'a successfully response', 'resend_password'
      end

      context 'with invalid token or expired' do
        with(:token, :spent_date_from_send_mail) do
          [
            [RESET_TOKEN,   FOUR_DATES_SPENT],
            [UNMATCH_TOKEN, THREE_DATES_SPENT],
            [UNMATCH_TOKEN, FOUR_DATES_SPENT]
          ]
        end

        with_them do
          before do
            allow_any_instance(User).to receive_message_chain(:reset_password, :rensend_at).and_return(spent_date_from_send_mail)
          end
          subject do
            get(edit_reset_password, RESET_TOKEN)
            response
          end
          it_behaves_like 'a successfully rendered', 'announce'
        end
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
