module RelationSkillProfile
  extend ActiveSupport::Concern

  included do
    belongs_to :user
    has_many   :articles, dependent: :destroy
  end
end
