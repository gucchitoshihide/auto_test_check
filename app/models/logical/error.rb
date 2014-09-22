class Error
  class << self
    def join(errored_message)
      errored_message.join(Settings[:error][:seperate])
    end
  end
end
