class Article < ActiveRecord::Base
  include RelationArticle
  include ValidationArticle
end
