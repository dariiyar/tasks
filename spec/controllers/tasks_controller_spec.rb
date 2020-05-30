require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'ProjectsController' do
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
  end
end
