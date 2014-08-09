module RelationArticle
  extend ActiveSupport::Concern

  included do
    belongs_to :week_report
    belongs_to :skill_profile
  end
end
