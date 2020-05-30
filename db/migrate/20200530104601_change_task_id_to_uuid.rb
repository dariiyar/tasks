class ChangeTaskIdToUuid < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :uuid, :uuid, default: 'gen_random_uuid()', null: false

    change_table :tasks do |t|
      t.remove :id
      t.rename :uuid, :id
    end
    execute 'ALTER TABLE tasks ADD PRIMARY KEY (id);'
  end
end
