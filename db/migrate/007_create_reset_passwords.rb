class CreateResetPasswords < ActiveRecord::Migration
  def change
    create_table :reset_passwords do |t|
      t.string :token
      t.date :resend_at

      t.timestamps
    end
  end
end
