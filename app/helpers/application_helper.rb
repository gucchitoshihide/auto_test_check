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

  # http://qiita.com/shu_0115/items/476a51cb4751515f3ac2
  # http://qiita.com/2or3/items/3f25216663190676a693
  def markdown_to_html(text)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(text).html_safe
  end
end
