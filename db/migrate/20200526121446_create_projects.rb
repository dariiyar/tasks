class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects, id: :uuid do |t|
      t.string :name
      t.text :description
      t.decimal :price

      t.timestamps
    end
  end
end
