module ValidationArticle
  extend ActiveSupport::Concern

  included do
    validates_length_of   :title, maximum: Settings[:article][:title][:max_length]
    validates_presence_of :title
    validates_presence_of :content
  end
end
