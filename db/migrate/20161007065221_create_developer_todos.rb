class CreateDeveloperTodos < ActiveRecord::Migration
  def change
    create_table :developer_todos do |t|
      t.references :user, index: true
      t.references :todo, index: true

      t.timestamps
    end
  end
end
