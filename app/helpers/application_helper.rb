module ApplicationHelper
  def announce_comment(article_id)
    count = comment_count(article_id)
    return '' if count == 0
    '(' + count.to_s + ')'
  end

  def comment_count(article_id)
    Comment.num_followed(article_id)
  end

  def js_void_link_to(property)
    link_to property, 'javascript:void(0)'
  end
end
