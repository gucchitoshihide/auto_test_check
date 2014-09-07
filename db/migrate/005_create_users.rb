class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :avatar
      t.string :write_style, default: Settings[:user][:write_style][:plain]

      t.timestamps
    end
  end
end
