def t(key)
  I18n.t(key)
end

# http://stackoverflow.com/a/5803121
def login
  post(logins_path, user: {name: USER_NAME, password: PASSWORD})
end
