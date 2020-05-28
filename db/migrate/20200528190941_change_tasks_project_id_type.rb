class ChangeTasksProjectIdType < ActiveRecord::Migration[6.0]
  def change
    remove_column(:tasks, :project_id, :bigint)
    add_reference(:tasks, :project, type: :uuid)
  end
end
