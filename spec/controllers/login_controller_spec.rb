require 'rails_helper'

RSpec.describe LoginController, :type => :controller do

  describe '#new' do
    subject do
      get(:new)
      response
    end

    context 'without session' do
      pending 'without session case, body.title becomes nil ; maybe rspec bug'
    end

    context 'with session' do
      before do
        FactoryGirl.create(:user)
        post(:create, USER_POST_LOGIN_PARAMS)
      end
      it_behaves_like 'a successful redirection to', '/welcome'
    end
  end

  describe '#create' do
    before do
      @params = USER_POST_LOGIN_PARAMS
      FactoryGirl.create(:user)
    end
    let(:params) { @params }

    subject do
      post(:create, params)
      response
    end

    context 'with valid params' do
      it_behaves_like 'a successful redirection to', '/welcome'
    end

    context 'with presence name and password' do
      let(:params) { { user: { name: '', password: '' } } }
      let(:errors) { 'las.errors.login_name.blank,las.errors.login_password.blank,las.errors.login_password.invalid' }
      it_behaves_like 'a successful rendered', 'new'
      it { expect(subject.body).to include(errors.split(',').map { |error| t(error) }.join(Settings[:error][:seperate])) }
    end

    context 'with no existance name and password' do
      let(:params) { { user: { name: NAME, password: 'otherpassword' } } }
      let(:error) { 'las.errors.login_authentication.invalid' }
      it_behaves_like 'a successful rendered', 'new'
      it { expect(subject.body).to include(t(error)) }
    end
  end
end
