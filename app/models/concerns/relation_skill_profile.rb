module RelationSkillProfile
  extend ActiveSupport::Concern

  included do
    has_many :users
    has_one  :article
  end
end
