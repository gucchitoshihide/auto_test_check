FactoryGirl.define do
  factory :reset_password do
    token     Settings[:back][:reset_passwords][:token]
    resend_at Settings[:back][:reset_passwords][:resend_at]
    user_id   1
  end
end
