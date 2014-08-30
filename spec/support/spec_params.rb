SESSION_ID  = 1
USER_ID     = 1
USER_NAME   = Settings[:back][:model][:user][:name]
EMAIL       = Settings[:back][:model][:user][:email]
PASSWORD    = Settings[:back][:model][:user][:password]
RESET_TOKEN = Settings[:back][:model][:user][:password_reset_token]

UNMATCH_RESET_TOKEN = 'unmatch_token'
NOT_EXISTS_EMAIL    = 'dummy@no.exists.dummy'

A_DATE = 24 * 60 * 60
SEND_DATE         = Time.now
THREE_DATES_SPENT = SEND_DATES + (3 * A_DATE)
FOUR_DATES_SPENT  = SEND_DATES + (4 * A_DATE)

POST_LOGIN_PARAMS = {
  user: {
    name:     USER_NAME,
    password: PASSWORD
  }
}

USER_MOCK = {
  id:       USER_ID,
  name:     USER_NAME,
  email:    EMAIL,
  password: PASSWORD
}

PASSWORD_RESEND_USER = {
  id:       USER_ID,
  password_reset: {
    token: RESET_TOKEN
    resend_at: Time.now
  }
}

ASSIGNED_USER_MOCK     = USER_MOCK
AUTHENTICATE_USER_MOCK = USER_MOCK
