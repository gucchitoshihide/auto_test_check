class Comment < ActiveRecord::Base
  include RelationComment
  include ValidationComment

  class << self

    def submit(params, article_id)
      # issue - article doesn not have all comment id on table
      article = Article.find_by(id: article_id)
      comment = Comment.new(content: params[:content], article_id: article_id)
      if comment.save
        (article.comment_id = comment.id) and article.save
      else
        raise SystemError, 'Sytem Error happened Try again'
      end
    end

  end

end
