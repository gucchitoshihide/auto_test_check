module Cert
  module Params
    extend self

    # http://stackoverflow.com/a/19715367
    #
    # x <=> Cert::Params.numeric?(value)
    #
    # -- given
    # value #=> Fixnum or String(only includes numeric)123 or '123'
    # x #=> true
    #
    # value #=> not Fixnum or String(only includes numerc)
    #           ex. nil, '', '123foo', 123.24, 4/2, [], {}, Object
    # x #=> false
    def numeric?(value)
      return true if value =~ /\A\d+\z/
      false
    end
  end
end
