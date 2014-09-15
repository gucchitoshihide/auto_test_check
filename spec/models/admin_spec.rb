require 'rails_helper'

RSpec.describe Admin, :type => :model do
  describe '.authenticate' do
    before do
      @params = MODEL_POST_ADMIN_PARAMS
      FactoryGirl.create(:admin)
    end
    let(:params) { @params }

    subject { Admin.authenticate(params) }

    context 'with valid params' do
      it { expect  { subject }.not_to raise_error }
    end

    context 'with invalid params' do
      where(:email, :password, :error) do
        [
          [''                        , '',         'las.errors.admin_email.blank,las.errors.admin_password.blank,las.errors.admin_password.invalid'],
          ['a' * 244 + '@example.com', '',         'las.errors.admin_email.long,las.errors.admin_password.blank,las.errors.admin_password.invalid'],
          [''                        , 'a'  * 255, 'las.errors.admin_email.blank'],
          ['a' * 244 + '@example.com', 'a'  * 255, 'las.errors.admin_email.long'],
          [''                        , 'a'  * 256, 'las.errors.admin_email.blank,las.errors.admin_password.long'],
          ['a' * 243 + '@example.com', 'a'  * 256, 'las.errors.admin_password.long'],
          ['a' * 244 + '@example.com', 'a'  * 256, 'las.errors.admin_email.long,las.errors.admin_password.long'],
          [''                        , 'あ' * 255, 'las.errors.admin_email.blank,las.errors.admin_password.invalid'],
          ['a' * 243 + '@example.com', 'あ' * 255, 'las.errors.admin_password.invalid'],
          ['a' * 244 + '@example.com', 'あ' * 255, 'las.errors.admin_email.long,las.errors.admin_password.invalid'],
          [''                        , 'あ' * 256, 'las.errors.admin_email.blank,las.errors.admin_password.long,las.errors.admin_password.invalid'],
          ['a' * 243 + '@example.com', 'あ' * 255, 'las.errors.admin_password.invalid'],
          ['a' * 244 + '@example.com', 'あ' * 256, 'las.errors.admin_email.long,las.errors.admin_password.long,las.errors.admin_password.invalid'],
        ]
      end
      with_them do
        let(:errors) { error.split(',').map{ |message| t(message) }.join(Settings[:error][:seperate]) }
        let(:params) { @params.merge({ email: email, password: password }) }
        it { expect { subject }.to raise_error ValidationError, errors }
      end
    end

    context 'with no existance email' do
      let(:params) { @params.merge(email: 'other_email@example.com') }
      let(:errors) { I18n.t('las.errors.admin_authorization.invalid') }

      it { expect { subject }.to raise_error AuthorizationError, errors }
    end

  end
end
