require 'pry'
module Cert
  module Redirection

    class << self
      def from?(from, referer)
        referer_url = referer.gsub(/http:\/\/(.+?)\//, '')
        case from
        when Array
          return true if from.map { |from_url| referer_url.include?(from_url) }.include?(true)
        end
        false
      end
    end

  end
end
