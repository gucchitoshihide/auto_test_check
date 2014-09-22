FactoryGirl.define do
  factory :comment, class: Comment do
    content Settings.comment.content
  end
end
