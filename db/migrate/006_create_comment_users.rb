class CreateCommentUsers < ActiveRecord::Migration
  def change
    create_table :comment_users do |t|
      t.references :comment, index: true
      t.references :user,    index: true

      t.timestamps
    end
  end
end
