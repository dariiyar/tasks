require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'TasksController' do
    describe "GET #index" do
      let(:tasks) { Task.all }
      subject { get :index }

      before :all do
        3.times { create(:project_with_tasks) }
      end
      it { is_expected.to be_successful }
      it 'returns valid JSON' do
        expect(subject.parsed_body.map(&:first).map(&:last)).to eq(tasks.map(&:id))
      end
    end
    describe "POST #batch_create" do
      let(:project) { create(:project) }
      let(:result_double) { double('result_double') }
      subject { post :batch_create, params: {} }

      context "Batch create is successful" do
        it 'it responses with status 201' do
          allow(Task::BatchCreate).to receive(:perform).and_return(result_double)
          allow(result_double).to receive(:success?).and_return(true)
          allow(result_double).to receive(:tasks).and_return([])
          expect(Task::BatchCreate).to receive(:perform)
          subject
          expect(response.status).to eq(201)
        end
      end

      context "Batch create failed" do
        it 'it responses with status 422' do
          allow(Task::BatchCreate).to receive(:perform).and_return(result_double)
          allow(result_double).to receive(:success?).and_return(false)
          allow(result_double).to receive(:errors).and_return([])
          expect(Task::BatchCreate).to receive(:perform)
          subject
          expect(response.status).to eq(422)
        end
      end
    end
  end
end
