require 'las_errors'

class Comment < ActiveRecord::Base
  include RelationComment
  include ValidationComment

  scope :followed?, ->(article_id) {
    ArticleComment.where('article_id = ?', article_id).present?
  }

  scope :show_all, ->(article_id) {
    related_comment_id = ArticleComment.where('article_id = ?', article_id).map { |record| record.comment_id }
    related_comment_id.map { |comment_id| self.find_by_id(comment_id) }
  }

  scope :num_followed, ->(article_id) {
    ArticleComment.where('article_id = ?', article_id).count
  }

  class << self

    def submit_on_week_report(params, article_id)
      article = Article.find_by(id: article_id)
      unless (article.comments << Comment.new(content: params[:content]))
        raise SystemError, 'Sytem Error happened Try again'
      end
    end

  end

end
