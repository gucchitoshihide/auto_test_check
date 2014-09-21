require 'active_support/core_ext/object/blank'
require 'pry'

module Search
  module Word
    extend self

    # -- given
    #
    # Article.all
    #   #=> #<[Article: id: 1, title: 'good morning'], [Article: id: 2 title: 'good bye'],
    #         [Article: id: 3, title: 'night']>
    #
    # Search::Word.reg_exp(Article.all, :title, 'good')
    #   #=> #<[Article: id: 1, title: 'good morning'], [Article: id: 2 title: 'good bye']
    #
    # Search::Word.reg_exp(Article.all, :title, '.*')
    #   #=>  #<[Article: id: 1, title: 'good morning'], [Article: id: 2 title: 'good bye'],
    #          [Article: id: 3, title: 'night']>
    #
    # Search::Word.reg_exp(Article.all, :thanks_world, 'good')
    #   #=> []
    #
    # -- changed given
    #
    # Article.all
    #   #=> []
    #
    # Search::Word.reg_exp(Article.all, :title, 'good')
    #   #=> []
 
    def reg_exp(records, property, search_word)
      return [] if (records.blank? or not records[0].respond_to?(property))

      if records.size > 1
        binding.pry
        return records.select { |record| record if record.send(property) =~ /#{search_word}/ }
      else
        return (records[0].send(property) =~ /#{search_word}/) ? records : []
      end
    end
  end
end
