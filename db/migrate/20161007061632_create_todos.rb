class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.integer :project_id
      t.string :item
      t.string :status, :default => "new"

      t.timestamps
    end
  end
end
