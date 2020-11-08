class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.date :date
      t.string :description
      t.integer :status
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
