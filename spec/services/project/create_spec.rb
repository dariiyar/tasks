require 'rails_helper'

RSpec.describe Project::Create do
  describe '#perform' do
    let(:project_double) { instance_double('Project') }
    let(:result) { subject.perform(project_double) }
    subject { described_class }

    context 'when project is valid' do
      before do
        allow(project_double).to receive(:save).and_return(true)
      end
      it 'saves and returns project' do
        expect(result.project).to be_equal(project_double)
        expect(result.success?).to be_truthy
      end
    end

    context 'when project isn`t valid' do
      before do
        allow(project_double).to receive(:save).and_return(false)
        allow(project_double).to receive(:errors).and_return('errors')
      end
      it 'returns errors' do
        expect(result.errors).to eq('errors')
        expect(result.project).to be_nil
        expect(result.success?).to be_falsey
      end
    end
  end
end
