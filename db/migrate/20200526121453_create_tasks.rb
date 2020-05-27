class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks, id: :uuid do |t|
      t.string :name
      t.text :description
      t.datetime :estimate_date
      t.decimal :price
      t.string :status
      t.integer :progress
      t.text :urls, array: true, default: []

      t.timestamps
    end

    add_reference :tasks, :project, index: true
  end
end
