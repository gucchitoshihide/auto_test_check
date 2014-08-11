class CreateArticleSkillProfiles < ActiveRecord::Migration
  def change
    create_table :article_skill_profiles do |t|
      t.references :article,       index: true
      t.references :skill_profile, index: true

      t.timestamps
    end
  end
end
