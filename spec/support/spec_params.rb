SESSION_ID = 1
USER_ID    = 1
USER_NAME  = Settings[:back][:model][:user][:name]
EMAIL      = Settings[:back][:model][:user][:email]
PASSWORD   = Settings[:back][:model][:user][:password]



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

ASSIGNED_USER_MOCK     = USER_MOCK
AUTHENTICATE_USER_MOCK = USER_MOCK

