require 'rails_helper'

RSpec.describe 'Admin', :type => :request do
  describe 'GET /admin/login' do context 'with user request' do context 'with basic authentication' do
      before { basic_login_request }
        subject do
          get(login_admin_index_path, BLANK_PARAMETERS, @env)
          response
        end

        it_behaves_like 'a successfully response MOD', 'admin.login'
      end
      context 'without basic authentication' do
        subject do
          get(login_admin_index_path)
          response
        end

        it_behaves_like 'a prohibited request and return 401'
      end
    end
  end

  describe 'POST /admin' do
    before do
      FactoryGirl.create(:admin)
    end
    subject do
      post(admin_index_path, USER_POST_ADMIN_PARAMS)
      response
    end
    context 'with user request' do
      context 'with valid params' do
        it_behaves_like 'a successfully response redirection (302)'
      end
    end
  end

  describe' GET /admin' do
    subject do
      pending
      #get(admin_index_path)
      #response
    end
    context 'with user request' do
      context 'with session' do
      pending
      # it_behaves_like 'a successfully response MOD', 'admin.index'
      end
    end

    context 'without session' do
      pending
      # it_behaves_like 'a successfully response MOD', 'admin.index'
    end
  end

end
