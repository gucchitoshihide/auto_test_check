require 'active_support/core_ext/object/blank'
require 'pry'

module Search
  module Word
    extend self

    # method trusts records is ActiveRecord::Relation
    def reg_exp(records, field, search_word)
      # respond of records[0] should be changed
      # * not to trust all record is in same group
      # * ex. FooAR(respond x field), FooAR, BarAR(not respond x field), FooAR
      return [] if (records.blank? and not records[0].respond_to?(field.to_s))

      if records.size > 1
        return records.select { |record| record if record.send(field) =~ /#{search_word}/ }
      else
        return (records[0].send(field) =~ /#{search_word}/) ? records : []
      end
    end

  end
end
