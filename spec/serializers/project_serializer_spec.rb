require 'rails_helper'

RSpec.describe ProjectSerializer, type: :serializer do
  describe "attributes" do
    let(:project) { create(:project_with_tasks) }
    let(:tasks) { project.tasks }

    it "should include the last task's estimate date as an attribute" do
      serialized = serialize(project)
      max_date = tasks.sort_by(&:estimate_date).reverse.first.estimate_date.to_date
      expect(serialized[:estimate_date].to_date).to eql(max_date)
    end

    it "should include the smallest task's status as an attribute" do
      serialized = serialize(project)
      expect(serialized[:status]).to eql(tasks.min_by { |t| Task.statuses[t.status] }.status)
    end

    it "should include the smallest task's progress as an attribute" do
      serialized = serialize(project)
      expect(serialized[:progress]).to eql(tasks.map(&:progress).min)
    end

    it "should include the total tasks count as an attribute" do
      serialized = serialize(project)
      expect(serialized[:task_count]).to eql(tasks.count)
    end
  end
end
