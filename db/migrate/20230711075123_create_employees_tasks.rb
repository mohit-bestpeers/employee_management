class CreateEmployeesTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :employees_tasks do |t|
      t.references :employee, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true

      t.timestamps
    end
  end
end
