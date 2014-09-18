def t(key)
  I18n.t(key)
end

def format_errors(errors_message)
  errors_message.split(',').map { |error| t(error) }.join(Settings.error.seperate)
end

# http://stackoverflow.com/a/5803121
def login
  get(new_login_path)
  post(login_path, USER_POST_LOGIN_PARAMS)
end

def login_as_admin
  post(admin_index_path, USER_POST_ADMIN_PARAMS)
end

# https://gist.github.com/mattconnolly/4158961
def basic_login_request
  @env     ||= {}
  id       = Settings[:admin][:basic_auth][:id]
  password = Settings[:admin][:basic_auth][:password]
  @env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(id, password)
end

def basic_login_controller
  id       = Settings[:admin][:basic_auth][:id]
  password = Settings[:admin][:basic_auth][:password]
  request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(id, password)
end
