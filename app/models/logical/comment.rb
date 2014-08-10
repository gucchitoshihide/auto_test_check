class Comment < ActiveRecord::Base
  include RelationComment
  include ValidationComment

  class << self
    def submit(content, referer)
      # Implement
    end
  end

  private

  def format_referer(referer)
    referer.gsub(/(http:https)\/\/(.+?)\//, '')
  end
end
