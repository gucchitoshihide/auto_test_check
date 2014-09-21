SESSION_ID                  = 1
USER_ID                     = 1
OTHER_USER_ID               = 2
NAME                        = Settings[:user][:name]
EMAIL                       = Settings[:user][:email]
PASSWORD                    = Settings[:user][:password]
RESET_TOKEN                 = Settings[:reset_passwords][:token]

ADMIN_NAME                  = Settings[:admin][:fixture][:name]
ADMIN_EMAIL                 = Settings[:admin][:fixture][:email]
ADMIN_PASSWORD              = Settings[:admin][:fixture][:password]
ADMIN_PASSWORD_CONFIRMATION = ADMIN_PASSWORD

CURRENT_PASSWORD                     = 'current_password'
MISSED_CURRENT_PASSWORD              = 'missed_current_password'
CHANGE_PASSWORD                      = 'change_password'
CHANGE_PASSWORD_CONFIRMATION         = CHANGE_PASSWORD
UNMATCH_CHANGE_PASSWORD              = 'unmatch_change_password'
UNMATCH_CHANGE_PASSWORD_CONFIRMATION = 'unmatch_change_password_confirmation'

UNMATCH_RESET_TOKEN = 'unmatch_token'
NOT_EXISTS_EMAIL    = 'dummy@no.exists.dummy'

LOCAL_HOST_ROUTE = 'http://localhost:3000/'

A_DATE = 24 * 60 * 60
NOW_A_DATE      = Date.today
THREE_DATES_AGO = NOW_A_DATE - 3
FOUR_DATES_AGO  = NOW_A_DATE - 4

BLANK = ''
BLANK_PARAMETERS = {}

USER_POST_LOGIN_PARAMS = {
  user: {
    name:     NAME,
    password: PASSWORD,
  }
}

MODEL_POST_LOGIN_PARAMS = {
  name:     NAME,
  password: PASSWORD,
}

USER_GET_SKILL_PROFILE_PARAMS = {
  id: USER_ID
}

USER_POST_ADMIN_PARAMS = {
  admin: {
    email:    ADMIN_EMAIL,
    password: ADMIN_PASSWORD,
  }
}

MODEL_POST_ADMIN_PARAMS = {
  email:    ADMIN_EMAIL,
  password: ADMIN_PASSWORD,
}

USER_MOCK = {
  id:       USER_ID,
  name:     NAME,
  email:    EMAIL,
  password: PASSWORD
}

PASSWORD_RESEND_USER = {
  id:       USER_ID,
  password_reset: {
    token: RESET_TOKEN,
    resend_at: Time.now
  }
}

ASSIGNED_USER_MOCK     = USER_MOCK
AUTHENTICATE_USER_MOCK = USER_MOCK
