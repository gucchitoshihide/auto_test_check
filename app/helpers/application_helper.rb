module ApplicationHelper
  def announce_comment(article_id)
    count = comment_count(article_id)
    return '' if count == 0
    '(' + count.to_s + ')'
  end

  def comment_count(article_id)
    Comment.num_followed(article_id)
  end
end
