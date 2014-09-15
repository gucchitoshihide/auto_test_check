require 'rails_helper'

RSpec.describe AdminController, :type => :controller do
  describe '#login' do
    subject do
      get(:login)
      response
    end

    context 'without basic authentication' do
      it_behaves_like 'a prohibited request and return 401'
    end

    context 'with basic authentication' do
      before { basic_login_controller }
      context 'passed basic authentication' do
        it { expect(subject.status).to eq 200 }
        it { expect(response).to be_success }
      end
    end
  end

  describe '#index' do
    pending
  end

  describe '#create' do
    before do
      FactoryGirl.create(:admin)
    end
    let(:params) { USER_POST_ADMIN_PARAMS }

    subject do
      post(:create, params)
      response
    end

    context 'with valid params' do
      it_behaves_like 'a successfully response redirection (302) to', "/admin"
    end

    context 'with invalid params' do
      let(:params) do
        {
          admin: {
            email:    'a' * 244 + '@example.com',
            password: 'a' * 256
          }
        }
      end

      it_behaves_like 'a successfully rendered', 'login'
    end
  end

end
