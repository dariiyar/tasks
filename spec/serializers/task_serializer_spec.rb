require 'rails_helper'

RSpec.describe TaskSerializer, type: :serializer do
  describe "attributes" do
    let(:task) { Task.first }

    before(:all) { create(:project_with_tasks) }

    it "should have the list of attributes" do
      tasks_attributes = %i[uuid name description estimate_date price status progress project]
      expect(serialize(task).keys).to be_eql(tasks_attributes)
    end

    it "should have the list of projet's attributes" do
      project_attributes = %i[uuid name description price estimate_date progress status task_count]
      expect(serialize(task.project).keys).to be_eql(project_attributes)
    end
  end
end
