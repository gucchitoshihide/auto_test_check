module RelationArticleSkillProfile
  extend ActiveSupport::Concern

  included do
    belongs_to :article
    belongs_to :skill_profile
  end
end
