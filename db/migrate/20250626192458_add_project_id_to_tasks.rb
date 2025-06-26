class AddProjectIdToTasks < ActiveRecord::Migration[8.0]
  def change
    add_reference :tasks, :project, foreign_key: true
  end
end
