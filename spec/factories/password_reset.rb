FactoryGirl.define do
  factory :reset_password do
    token     Settings[:reset_passwords][:token]
    resend_at Settings[:reset_passwords][:resend_at]
    user_id   1
  end
end
