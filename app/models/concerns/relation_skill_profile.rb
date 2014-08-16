module RelationSkillProfile
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    has_one    :article
  end
end
