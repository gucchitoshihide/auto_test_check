FactoryGirl.define do
  factory :article, class: Article do
    title   Settings.article.title.description
    content Settings.article.content.description
  end

  factory :article_without_comment, class: Article do
    title   'without comment'
    content 'without comment'
  end
end
