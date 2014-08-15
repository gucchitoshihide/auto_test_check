module RelationSkillProfile
  extend ActiveSupport::Concern

  included do
    has_many :users
    has_one  :article, dependent: :destroy
  end
end
