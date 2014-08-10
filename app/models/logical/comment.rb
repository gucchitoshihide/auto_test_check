class Comment < ActiveRecord::Base
  include RelationComment
  include ValidationComment
end
