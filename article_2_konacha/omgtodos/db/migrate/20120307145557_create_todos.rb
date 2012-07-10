class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.text :body, null: false
      t.boolean :completed, null: false, default: false

      t.timestamps
    end
  end
end
