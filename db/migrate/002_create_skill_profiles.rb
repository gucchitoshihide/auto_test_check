class CreateSkillProfiles < ActiveRecord::Migration
  def change
    create_table :skill_profiles do |t|
      t.references :article, index: true
      t.references :user,    index: true

      t.timestamps
    end
  end
end
