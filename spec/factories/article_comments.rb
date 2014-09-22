FactoryGirl.define do
  factory :article_comment, class: ArticleComment do
    article
    comment
  end
end
