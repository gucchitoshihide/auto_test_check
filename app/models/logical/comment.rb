require 'las_errors'

class Comment < ActiveRecord::Base
  include RelationComment
  include ValidationComment

  class << self

    def submit_on_week_report(params, article_id)
      article = Article.find_by(id: article_id)
      unless (article.comments << Comment.new(content: params[:content]))
        raise SystemError, 'Sytem Error happened Try again'
      end
    end

  end

end
