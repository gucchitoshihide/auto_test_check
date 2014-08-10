module ValidationComment
  extend ActiveSupport::Concern

  included do
    validates_presence_of :content
  end
end
