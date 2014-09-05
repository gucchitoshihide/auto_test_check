require 'rails_helper'

# http://blog.lucascaton.com.br/index.php/2010/10/25/how-to-test-mailers-in-rails-3-with-rspec/

RSpec.describe 'Settings', :type => :request do
  before do
    FactoryGirl.create(:user)
    login
  end
  describe 'GET /settings/:id/edit' do

    context 'user send request to transition' do
      context 'for his edit' do
        subject do
          get(edit_setting_path(USER_ID))
          response
        end
        it_behaves_like 'a successfully response', 'settings'
      end

      context 'for other edit' do
        subject do
          get(edit_setting_path(OTHER_USER_ID))
          response
        end
        it_behaves_like 'a successfully rendered', 'edit'
      end

    end
  end

  describe 'PUT /settings/:id' do
    context 'user send request' do
      context 'udpate password' do
        context 'with password combinations' do
          where(:current_password, :password, :password_confirmation) do
            [
              [CURRENT_PASSWORD, CHANGE_PASSWORD, CHANGE_PASSWORD_CONFIRMATION],
              [CURRENT_PASSWORD, CHANGE_PASSWORD, UNMATCH_CHANGE_PASSWORD_CONFIRMATION],
              [CURRENT_PASSWORD, UNMATCH_CHANGE_PASSWORD, UNMATCH_CHANGE_PASSWORD_CONFIRMATION],
              [MISSED_CURRENT_PASSWORD, CHANGE_PASSWORD, CHANGE_PASSWORD_CONFIRMATION],
              [MISSED_CURRENT_PASSWORD, CHANGE_PASSWORD, UNMATCH_CHANGE_PASSWORD_CONFIRMATION],
              [MISSED_CURRENT_PASSWORD, UNMATCH_CHANGE_PASSWORD, UNMATCH_CHANGE_PASSWORD_CONFIRMATION],
            ]
          end
          with_them do
            subject do
              put(setting_path(USER_ID), user: {current_password:      current_password,
                                                password:              password,
                                                password_confirmation: password_confirmation}
                 )
              response
            end
            it_behaves_like 'a successfully rendered', 'edit'
          end
        end

      end
    end
  end
end
