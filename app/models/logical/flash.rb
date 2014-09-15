class Flash
  class << self
    def format_error_message(error_message)
      error_message.split(Settings[:error][:seperate])
    end
  end
end
