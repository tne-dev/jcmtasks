class CreateTaggedTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tagged_tasks do |t|
      t.references :task, null: false, foreign_key: true
      t.references :tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
