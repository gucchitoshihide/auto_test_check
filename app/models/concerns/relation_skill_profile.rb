module RelationSkillProfile
  extend ActiveSupport::Concern

  included do
    has_many :users
    has_many :articles, dependent: :destroy
  end
end
