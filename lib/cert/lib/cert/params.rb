module Cert
  module Params
    extend self

    def numerical?(value)
      return true if value =~ /\A\d+\z/
      false
    end
  end
end
