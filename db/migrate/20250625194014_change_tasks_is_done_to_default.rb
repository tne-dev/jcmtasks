class ChangeTasksIsDoneToDefault < ActiveRecord::Migration[8.0]
  def change
    change_column_default :tasks, :is_done, from: nil, to: false
  end
end
