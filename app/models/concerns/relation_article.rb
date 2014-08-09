module RelationArticle
  extend ActiveSupport::Concern

  included do
    belongs_to :week_report
  end
end
