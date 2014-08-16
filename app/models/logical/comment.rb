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

    def submit(params, article_id, user_id)
      article = Article.find_by(id: article_id)
      user    = User.find_by(id: user_id)
      begin 
        comment = Comment.new(content: params[:content], user_id: user_id)
        [article, user].each { |associated_record| associated_record.comments << comment }
      rescue ActiveRecord::RecordInvalid => e
        raise ValidationError, e.message
      end
    end

  end

end
