require 'rails_helper'

RSpec.describe Task::BatchCreate do
  describe '#perform' do
    let(:project) { create(:project) }
    let(:tasks_params) { FactoryBot.attributes_for_list(:task,2, project_id: project.id, price:0, estimate_date: nil) }
    let(:result) { subject.perform }
    subject { described_class.new(tasks_params) }

    context 'when all tasks in the batch are valid' do
      it 'saves and returns array of tasks' do
        subject.instance_variable_set(:@valid, true)
        expect(result.success?).to be_truthy
        expect(result.tasks).not_to be_nil
      end
    end

    context 'when tasks in the batch are not valid' do
      it 'returns errors' do
        subject.instance_variable_set(:@valid, false)
        expect(result.success?).to be_falsey
        expect(result.tasks).to be_nil
      end
    end
  end
end
