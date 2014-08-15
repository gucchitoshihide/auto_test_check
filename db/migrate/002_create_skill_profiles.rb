class CreateSkillProfiles < ActiveRecord::Migration
  def change
    create_table :skill_profiles do |t|
      t.references :user, index: true
      t.string     :title, null: false, unique: true

      t.timestamps
    end
  end
end
