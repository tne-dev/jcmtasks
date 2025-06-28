class AddIndexOnSearchedTitles < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def change
    add_index :tasks, :title, algorithm: :concurrently, name: "index_tasks_on_title"
    add_index :projects, :title, algorithm: :concurrently, name: "index_projects_on_title"
    add_index :tags, :title, algorithm: :concurrently, name: "index_tags_on_title"
  end
end
