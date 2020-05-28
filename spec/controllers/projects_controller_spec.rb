require 'rails_helper'

RSpec.describe ProjectsController, type: :controller do
  describe 'ProjectsController' do
    describe "GET #index" do
      let!(:projects) { FactoryBot.create_list(:project, 3) }
      subject { get :index }

      it { is_expected.to be_successful }
      it 'returns valid JSON' do
        expect(subject.parsed_body.map(&:first).map(&:last)).to eq(projects.map(&:id))
      end
    end

    describe "POST #create" do
      let(:params) { { name: 'Name', price: 100.5 } }

      subject { post :create, params: params }

      context "with valid attributes" do
        it "creates with 200 status code" do
          subject
          expect(response.status).to eq(201)
        end
      end

      context "with invalid attributes" do
        it "failed without name with a 422 status code" do
          params[:name] = nil
          subject
          expect(response.status).to eq(422)
        end

        it "failed without price with a 422 status code" do
          params[:price] = nil
          subject
          expect(response.status).to eq(422)
        end
      end
    end
  end
end
