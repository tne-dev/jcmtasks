class AddUserToNeededModels < ActiveRecord::Migration[8.0]
  def change
    add_reference :projects, :user, null: false, foreign_key: true
    add_reference :tasks, :user, null: false, foreign_key: true
    add_reference :tags, :user, null: false, foreign_key: true
  end
end
