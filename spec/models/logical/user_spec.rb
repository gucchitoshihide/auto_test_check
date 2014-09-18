require 'rails_helper'

RSpec.describe User, :type => :model do
  describe '.authenticate' do
    before do
      @params = MODEL_POST_LOGIN_PARAMS
      FactoryGirl.create(:user)
    end
    let(:params) { @params }
    subject { User.authenticate(params) }

    context 'with valid params' do
      it { expect { subject }.not_to raise_error }
    end

    context 'with invalid params' do
      where(:name, :password, :expected_errors) do
        [
          [BLANK,     BLANK,      'las.errors.login_name.blank,las.errors.login_password.blank,las.errors.login_password.invalid'],
          ['a' * 255, BLANK,      'las.errors.login_password.blank,las.errors.login_password.invalid'],
          ['a' * 256, BLANK,      'las.errors.login_name.long,las.errors.login_password.blank,las.errors.login_password.invalid'],
          [BLANK,     'a'  * 255, 'las.errors.login_name.blank'],
          ['a' * 256, 'a'  * 255, 'las.errors.login_name.long'],
          [BLANK,     'a'  * 256, 'las.errors.login_name.blank,las.errors.login_password.long'],
          ['a' * 255, 'a'  * 256, 'las.errors.login_password.long'],
          ['a' * 256, 'a'  * 256, 'las.errors.login_name.long,las.errors.login_password.long'],
          [BLANK,     'あ' * 255, 'las.errors.login_name.blank,las.errors.login_password.invalid'],
          ['a' * 255, 'あ' * 255, 'las.errors.login_password.invalid'],
          ['a' * 256, 'あ' * 255, 'las.errors.login_name.long,las.errors.login_password.invalid'],
          [BLANK,     'あ' * 256, 'las.errors.login_name.blank,las.errors.login_password.long,las.errors.login_password.invalid'],
          ['a' * 255, 'あ' * 256, 'las.errors.login_password.long,las.errors.login_password.invalid'],
          ['a' * 256, 'あ' * 256, 'las.errors.login_name.long,las.errors.login_password.long,las.errors.login_password.invalid']
        ]
      end
      with_them do
        let(:errors) { format_errors(expected_errors) }
        let(:params) { @params.merge({ name: name, password: password }) }
        it { expect { subject }.to raise_error ValidationError, errors }
      end
    end
  end
end
